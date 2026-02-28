-----------------------------
-- Gold Layer
-----------------------------
USE ecommerceDWH;
GO

--- Products Dimension Table
IF OBJECT_ID('gold.olist_products', 'U') IS NOT NULL
    DROP TABLE gold.olist_dim_products;
GO

SELECT 
    p.product_id,
    t.product_category_name_english AS product_category
INTO gold.olist_dim_products
FROM silver.olist_products AS p
LEFT JOIN silver.olist_product_category_name_translation AS t
    ON p.product_category_name = t.product_category_name;
GO

--- Sellers Dimension Table
IF OBJECT_ID('gold.olist_dim_sellers', 'U') IS NOT NULL
    DROP TABLE gold.olist_dim_sellers;
GO

SELECT DISTINCT *
INTO gold.olist_dim_sellers
FROM silver.olist_sellers;
GO

--- Customers Dimension Table
IF OBJECT_ID('gold.olist_dim_customers', 'U') IS NOT NULL
    DROP TABLE gold.olist_dim_customers;
GO

SELECT DISTINCT *
INTO gold.olist_dim_customers
FROM silver.olist_customers;
GO

--- Sales Fact Table
IF OBJECT_ID('gold.olist_fact_sales', 'U') IS NOT NULL
    DROP TABLE gold.olist_fact_sales;
GO

---- Aggregate Reviews (Order Level)
WITH Reviews AS (
    SELECT
        order_id,
        MAX(ISNULL(review_score, 0)) AS review_score
    FROM silver.olist_order_reviews
    GROUP BY order_id
),
---- Aggregate Payments (Order Level)
Payments AS (
    SELECT 
        order_id, 
        STRING_AGG(payment_type, ', ') WITHIN GROUP (ORDER BY payment_type) AS payments,
        STRING_AGG(CAST(payment_installments AS VARCHAR), ', ') 
        WITHIN GROUP (ORDER BY payment_type) AS installments,
        SUM(ISNULL(payment_value, 0)) AS total_payment_value
    FROM silver.olist_order_payments
    GROUP BY order_id
)
SELECT
    i.order_id,
    i.order_item_id,
    CAST(o.order_purchase_timestamp AS DATE) AS order_date,
    o.customer_id,
    i.product_id,
    i.seller_id,
    p.product_category,
    c.customer_state,
    s.seller_state,
    o.order_status,
    r.review_score,
    pay.payments,
    pay.installments,
    i.price,
    i.freight_value,
    i.price + i.freight_value AS total_item_value,
    pay.total_payment_value
INTO gold.olist_fact_sales
FROM silver.olist_order_items i
LEFT JOIN silver.olist_orders o
    ON i.order_id = o.order_id
LEFT JOIN Reviews r
    ON i.order_id = r.order_id
LEFT JOIN Payments pay
    ON i.order_id = pay.order_id
LEFT JOIN gold.olist_products p
    ON i.product_id = p.product_id
LEFT JOIN silver.olist_customers c
    ON o.customer_id = c.customer_id
LEFT JOIN silver.olist_sellers s
    ON i.seller_id = s.seller_id;
GO