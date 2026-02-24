-----------------------------
-- Gold Layer 
-----------------------------
USE ecommerceDWH;
GO

--- Order Payments Summary Table
SELECT 
    op.order_id,
    STRING_AGG(DISTINCT op.payment_type, ', ') WITHIN GROUP (ORDER BY op.payment_type) AS payments,
    STRING_AGG(DISTINCT CAST(op.payment_installments AS VARCHAR), ', ') WITHIN GROUP (ORDER BY op.payment_installments) AS installments,
    SUM(op.payment_value) AS total_payment_value
INTO gold.olist_order_payments_summary
FROM silver.olist_order_payments AS op
GROUP BY op.order_id;
GO

--- Products Dimension Table
SELECT 
    p.product_id,
    t.product_category_name_english AS product_category
INTO gold.olist_products
FROM silver.olist_products AS p
LEFT JOIN silver.olist_product_category_name_translation AS t
    ON p.product_category_name = t.product_category_name;
GO

--- Orders Fact Table
SELECT
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
SELECT
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
SELECT DISTINCT *
INTO gold.olist_dim_sellers
FROM silver.olist_sellers;
GO

--- Customers Dimension Table
SELECT DISTINCT *
INTO gold.olist_dim_customers
FROM silver.olist_customers;
GO

--------------------------------
-- Primary Keys:
--------------------------------
ALTER TABLE gold.olist_orders ADD CONSTRAINT pk_olist_orders PRIMARY KEY(order_id);
ALTER TABLE gold.olist_order_items ADD CONSTRAINT pk_olist_order_items PRIMARY KEY(order_item_id);
ALTER TABLE gold.olist_products ADD CONSTRAINT pk_olist_products PRIMARY KEY(product_id);
ALTER TABLE gold.olist_dim_customers ADD CONSTRAINT pk_olist_customers PRIMARY KEY(customer_id);
ALTER TABLE gold.olist_dim_sellers ADD CONSTRAINT pk_olist_sellers PRIMARY KEY(seller_id);

--------------------------------
-- Indexes
--------------------------------
CREATE INDEX idx_order_items_order_id ON gold.olist_order_items(order_id);
CREATE INDEX idx_order_items_product_id ON gold.olist_order_items(product_id);


--------------------------------
-- Foreign Keys:
--------------------------------
ALTER TABLE gold.olist_order_items ADD CONSTRAINT fk_items_orders
FOREIGN KEY(order_id) REFERENCES gold.olist_orders(order_id);

ALTER TABLE gold.olist_order_items ADD CONSTRAINT fk_items_products
FOREIGN KEY(product_id) REFERENCES gold.olist_products(product_id);

ALTER TABLE gold.olist_order_items ADD CONSTRAINT fk_items_sellers
FOREIGN KEY(seller_id) REFERENCES gold.olist_dim_sellers(seller_id);
