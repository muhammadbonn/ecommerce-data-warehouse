-----------------------------
-- Loading Olist Silver Layer
-----------------------------
USE ecommerceDWH;
GO

--- Customers Table
TRUNCATE TABLE silver.olist_customers;

INSERT INTO silver.olist_customers (
    customer_id,
    customer_unique_id,
    customer_zip_code_prefix,
    customer_city,
    customer_state
)
SELECT DISTINCT
    customer_id,
    customer_unique_id,
    REPLACE(customer_zip_code_prefix, '"', ''),
    customer_city,
    customer_state
FROM bronze.olist_customers
WHERE customer_id IS NOT NULL;
GO

--- Sellers Table
TRUNCATE TABLE silver.olist_sellers;

INSERT INTO silver.olist_sellers (
    seller_id,
    seller_zip_code_prefix,
    seller_city,
    seller_state
)
SELECT DISTINCT
    seller_id,
    REPLACE(seller_zip_code_prefix, '"', ''),
    seller_city,
    seller_state
FROM bronze.olist_sellers
WHERE seller_id IS NOT NULL;
GO

--- Product Category Name Translation Table
TRUNCATE TABLE silver.olist_product_category_name_translation;

INSERT INTO silver.olist_product_category_name_translation (
    product_category_name,
    product_category_name_english
)
SELECT DISTINCT
    product_category_name,
    product_category_name_english
FROM bronze.olist_product_category_name_translation
WHERE product_category_name IS NOT NULL;
GO

--- Products Table
TRUNCATE TABLE silver.olist_products;

INSERT INTO silver.olist_products (
    product_id,
    product_category_name,
    product_name_length,
    product_description_length,
    product_photos_qty,
    product_weight_g,
    product_length_cm,
    product_height_cm,
    product_width_cm
)
SELECT DISTINCT
    product_id,
    product_category_name,
    TRY_CAST(product_name_length AS INT),
    TRY_CAST(product_description_length AS INT),
    TRY_CAST(product_photos_qty AS INT),
    TRY_CAST(product_weight_g AS DECIMAL(12,2)),
    TRY_CAST(product_length_cm AS DECIMAL(12,2)),
    TRY_CAST(product_height_cm AS DECIMAL(12,2)),
    TRY_CAST(product_width_cm AS DECIMAL(12,2))
FROM bronze.olist_products
WHERE product_id IS NOT NULL;
GO

--- Orders Table
TRUNCATE TABLE silver.olist_orders;

INSERT INTO silver.olist_orders (
    order_id,
    customer_id,
    order_status,
    order_purchase_timestamp,
    order_approved_at,
    order_delivered_carrier_date,
    order_delivered_customer_date,
    order_estimated_delivery_date
)
SELECT DISTINCT
    order_id,
    customer_id,
    order_status,
    TRY_CAST(NULLIF(LTRIM(RTRIM(order_purchase_timestamp)), '') AS DATETIME2),
    TRY_CAST(NULLIF(LTRIM(RTRIM(order_approved_at)), '') AS DATETIME2),
    TRY_CAST(NULLIF(LTRIM(RTRIM(order_delivered_carrier_date)), '') AS DATETIME2),
    TRY_CAST(NULLIF(LTRIM(RTRIM(order_delivered_customer_date)), '') AS DATETIME2),
    TRY_CAST(NULLIF(LTRIM(RTRIM(order_estimated_delivery_date)), '') AS DATETIME2)
FROM bronze.olist_orders
WHERE order_id IS NOT NULL;
GO

--- Order Items Table
TRUNCATE TABLE silver.olist_order_items;

INSERT INTO silver.olist_order_items (
    order_id,
    order_item_id,
    product_id,
    seller_id,
    shipping_limit_date,
    price,
    freight_value
)
SELECT
    order_id,
    order_item_id,
    product_id,
    seller_id,
    shipping_limit_date,
    price,
    freight_value
FROM (
    SELECT
        order_id,
        TRY_CAST(NULLIF(LTRIM(RTRIM(order_item_id)), '') AS INT) AS order_item_id,
        product_id,
        seller_id,
        TRY_CAST(NULLIF(LTRIM(RTRIM(shipping_limit_date)), '') AS DATETIME2) AS shipping_limit_date,
        TRY_CAST(NULLIF(LTRIM(RTRIM(price)), '') AS DECIMAL(12,2)) AS price,
        TRY_CAST(NULLIF(LTRIM(RTRIM(freight_value)), '') AS DECIMAL(12,2)) AS freight_value,
        ROW_NUMBER() OVER(
            PARTITION BY order_id, order_item_id
            ORDER BY shipping_limit_date DESC
        ) AS rn
    FROM bronze.olist_order_items
    WHERE order_id IS NOT NULL
) t
WHERE t.rn = 1
AND t.order_item_id IS NOT NULL;

--- Order Payments Table
TRUNCATE TABLE silver.olist_order_payments;

INSERT INTO silver.olist_order_payments (
    order_id,
    payment_sequential,
    payment_type,
    payment_installments,
    payment_value
)
SELECT
    order_id,
    payment_sequential,
    payment_type,
    payment_installments,
    payment_value
FROM (
    SELECT
        order_id,
        TRY_CAST(NULLIF(LTRIM(RTRIM(payment_sequential)), '') AS INT) AS payment_sequential,
        payment_type,
        TRY_CAST(NULLIF(LTRIM(RTRIM(payment_installments)), '') AS INT) AS payment_installments,
        TRY_CAST(NULLIF(LTRIM(RTRIM(payment_value)), '') AS DECIMAL(12,2)) AS payment_value,
        ROW_NUMBER() OVER(
            PARTITION BY order_id,
            TRY_CAST(NULLIF(LTRIM(RTRIM(payment_sequential)), '') AS INT)
            ORDER BY TRY_CAST(NULLIF(LTRIM(RTRIM(payment_sequential)), '') AS INT)
        ) AS rn
    FROM bronze.olist_order_payments
    WHERE order_id IS NOT NULL
) t
WHERE t.rn = 1
AND t.payment_sequential IS NOT NULL;


--- Order Reviews Table
TRUNCATE TABLE silver.olist_order_reviews;

INSERT INTO silver.olist_order_reviews (
    review_id,
    order_id,
    review_score,
    review_comment_title,
    review_comment_message,
    review_creation_date,
    review_answer_timestamp
)
SELECT
    review_id,
    order_id,
    review_score,
    review_comment_title,
    review_comment_message,
    review_creation_date,
    review_answer_timestamp
FROM (
    SELECT
        LTRIM(RTRIM(review_id)) AS review_id,
        LTRIM(RTRIM(order_id)) AS order_id,
        TRY_CAST(NULLIF(LTRIM(RTRIM(review_score)), '') AS INT) AS review_score,
        review_comment_title,
        review_comment_message,
        TRY_CAST(NULLIF(LTRIM(RTRIM(review_creation_date)), '') AS DATETIME2) AS review_creation_date,
        TRY_CAST(NULLIF(LTRIM(RTRIM(review_answer_timestamp)), '') AS DATETIME2) AS review_answer_timestamp,
        ROW_NUMBER() OVER(
            PARTITION BY LTRIM(RTRIM(review_id))
            ORDER BY TRY_CAST(NULLIF(LTRIM(RTRIM(review_creation_date)), '') AS DATETIME2) DESC
        ) AS rn
    FROM bronze.olist_order_reviews
    WHERE review_id IS NOT NULL
      AND LEN(review_id) <= 50
      AND LEN(order_id) <= 50
) t
WHERE t.rn = 1;
GO

PRINT 'Loading Silver Layer Finished Successfully.';
