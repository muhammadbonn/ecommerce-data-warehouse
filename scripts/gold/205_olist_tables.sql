-----------------------------
-- Gold Layer Unified
-----------------------------
USE ecommerceDWH;
GO

--- Order Payments Summary Table
IF OBJECT_ID('gold.olist_order_payments_summary', 'U') IS NOT NULL
    DROP TABLE gold.olist_order_payments_summary;
GO

;WITH DistinctPayments AS (
    SELECT DISTINCT
        order_id,
        payment_type,
        payment_installments,
        payment_value
    FROM silver.olist_order_payments
)
SELECT 
    dp.order_id,
    STRING_AGG(dp.payment_type, ', ') WITHIN GROUP (ORDER BY dp.payment_type) AS payments,
    STRING_AGG(CAST(dp.payment_installments AS VARCHAR), ', ') 
        WITHIN GROUP (ORDER BY dp.payment_type) AS installments,  -- Same ordering for payment_type
    SUM(dp.payment_value) AS total_payment_value
INTO gold.olist_order_payments_summary
FROM DistinctPayments dp
GROUP BY dp.order_id;
GO


--- Products Dimension Table
IF OBJECT_ID('gold.olist_products', 'U') IS NOT NULL
    DROP TABLE gold.olist_products;
GO

SELECT 
    p.product_id,
    t.product_category_name_english AS product_category
INTO gold.olist_products
FROM silver.olist_products AS p
LEFT JOIN silver.olist_product_category_name_translation AS t
    ON p.product_category_name = t.product_category_name;
GO

--- Orders Fact Table
IF OBJECT_ID('gold.olist_orders', 'U') IS NOT NULL
    DROP TABLE gold.olist_orders;
GO

SELECT DISTINCT
    o.order_id,
    o.customer_id,
    o.order_status,
    r.review_id,
    r.review_score,
    ps.payments,
    ps.installments,
    ps.total_payment_value
INTO gold.olist_orders
FROM silver.olist_orders AS o
LEFT JOIN silver.olist_order_reviews AS r
    ON o.order_id = r.order_id
LEFT JOIN gold.olist_order_payments_summary AS ps
    ON o.order_id = ps.order_id;
GO

--- Order Items Fact Table
IF OBJECT_ID('gold.olist_order_items', 'U') IS NOT NULL
    DROP TABLE gold.olist_order_items;
GO

SELECT DISTINCT
    i.order_id,
    i.order_item_id,
    i.product_id,
    i.seller_id,
    i.price,
    i.freight_value,
    i.price + i.freight_value AS total_value,
    p.product_category
INTO gold.olist_order_items
FROM silver.olist_order_items AS i
LEFT JOIN gold.olist_products AS p
    ON i.product_id = p.product_id;
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