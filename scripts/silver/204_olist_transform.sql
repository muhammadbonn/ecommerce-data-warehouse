-----------------------------
-- Loading Olist Silver Layer
-----------------------------
USE ecommerceDWH;
GO

--- Inserting Data Into Customers Table
TRUNCATE TABLE silver.olist_customers;
INSERT INTO silver.olist_customers (
    customer_id,
    customer_unique_id,
    customer_zip_code_prefix,
    customer_city,
    customer_state
)
SELECT
    customer_id,
    customer_unique_id,
    customer_zip_code_prefix,
    customer_city,
    customer_state
FROM bronze.olist_customers;

--- Inserting Data Into Sellers Table
TRUNCATE TABLE silver.olist_sellers;
INSERT INTO silver.olist_sellers (
    seller_id,
    seller_zip_code_prefix,
    seller_city,
    seller_state
)
SELECT
    seller_id,
    seller_zip_code_prefix,
    seller_city,
    seller_state
FROM bronze.olist_sellers;

--- Inserting Data Into Products Table
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
SELECT
    product_id,
    product_category_name,
    product_name_length,
    product_description_length,
    product_photos_qty,
    product_weight_g,
    product_length_cm,
    product_height_cm,
    product_width_cm
FROM bronze.olist_products;

--- Inserting Data Into Orders Table
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
SELECT
    order_id,
    customer_id,
    order_status,
    order_purchase_timestamp,
    order_approved_at,
    order_delivered_carrier_date,
    order_delivered_customer_date,
    order_estimated_delivery_date
FROM bronze.olist_orders;

--- Inserting Data Into Order Items Table
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
FROM bronze.olist_order_items;

--- Inserting Data Into Order Payments Table
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
FROM bronze.olist_order_payments;

--- Inserting Data Into Order Reviews Table
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
FROM bronze.olist_order_reviews;

--- Inserting Data Into Product Category Name Translation Table
TRUNCATE TABLE silver.olist_product_category_name_translation;
INSERT INTO silver.olist_product_category_name_translation (
    product_category_name,
    product_category_name_english
)
SELECT
    product_category_name,
    product_category_name_english
FROM bronze.olist_product_category_name_translation;

-----------------------------
-- Adding Primary Keys
-----------------------------
ALTER TABLE silver.olist_customers
ADD CONSTRAINT pk_olist_customers PRIMARY KEY (customer_id);

ALTER TABLE silver.olist_sellers
ADD CONSTRAINT pk_olist_sellers PRIMARY KEY (seller_id);

ALTER TABLE silver.olist_products
ADD CONSTRAINT pk_olist_products PRIMARY KEY (product_id);

ALTER TABLE silver.olist_orders
ADD CONSTRAINT pk_olist_orders PRIMARY KEY (order_id);

ALTER TABLE silver.olist_order_items
ADD CONSTRAINT pk_olist_order_items PRIMARY KEY (order_item_id);

ALTER TABLE silver.olist_order_payments
ADD CONSTRAINT pk_olist_order_payments PRIMARY KEY (order_id, payment_sequential);

ALTER TABLE silver.olist_order_reviews
ADD CONSTRAINT pk_olist_order_reviews PRIMARY KEY (review_id);

ALTER TABLE silver.olist_product_category_name_translation
ADD CONSTRAINT pk_olist_product_category_name_translation PRIMARY KEY (product_category_name);

-----------------------------
-- Adding Foreign Keys
-----------------------------
ALTER TABLE silver.olist_orders
ADD CONSTRAINT fk_olist_orders_customers
FOREIGN KEY (customer_id)
REFERENCES silver.olist_customers (customer_id);

ALTER TABLE silver.olist_order_items
ADD CONSTRAINT fk_olist_order_items_orders
FOREIGN KEY (order_id)
REFERENCES silver.olist_orders (order_id);

ALTER TABLE silver.olist_order_items
ADD CONSTRAINT fk_olist_order_items_products
FOREIGN KEY (product_id)
REFERENCES silver.olist_products (product_id);

ALTER TABLE silver.olist_order_items
ADD CONSTRAINT fk_olist_order_items_sellers
FOREIGN KEY (seller_id)
REFERENCES silver.olist_sellers (seller_id);

ALTER TABLE silver.olist_order_payments
ADD CONSTRAINT fk_olist_order_payments_orders
FOREIGN KEY (order_id)
REFERENCES silver.olist_orders (order_id);

ALTER TABLE silver.olist_order_reviews
ADD CONSTRAINT fk_olist_order_reviews_orders
FOREIGN KEY (order_id)
REFERENCES silver.olist_orders (order_id);
