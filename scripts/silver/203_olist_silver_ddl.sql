-----------------------
-- Create Olist Silver Tables
-----------------------
USE ecommerceDWH;
Go

--- Customers Table
IF OBJECT_ID('silver.olist_customers', 'U') IS NOT NULL
    DROP TABLE silver.olist_customers;
GO

CREATE TABLE silver.olist_customers (
  customer_id TEXT NOT NULL,
  customer_unique_id TEXT,
  customer_zip_code_prefix INTEGER,
  customer_city TEXT,
  customer_state TEXT
);
GO
  
--- Sellers Table
IF OBJECT_ID('silver.olist_sellers', 'U') IS NOT NULL
    DROP TABLE silver.olist_sellers;
GO
  
CREATE TABLE silver.olist_sellers.sellers (
  seller_id TEXT NOT NULL,
  seller_zip_code_prefix INTEGER,
  seller_city TEXT,
  seller_state TEXT
);
GO

--- Products Table
IF OBJECT_ID('silver.olist_products', 'U') IS NOT NULL
    DROP TABLE silver.olist_products;
GO

CREATE TABLE silver.olist_products (
  product_id TEXT NOT NULL,
  product_category_name TEXT,
  product_name_length INTEGER,
  product_description_length INTEGER,
  product_photos_qty INTEGER,
  product_weight_g NUMERIC,
  product_length_cm NUMERIC,
  product_height_cm NUMERIC,
  product_width_cm NUMERIC
);
GO

--- Orders Table
IF OBJECT_ID('silver.olist_orders', 'U') IS NOT NULL
    DROP TABLE silver.olist_orders;
GO
  
CREATE TABLE silver.olist_orders (
  order_id TEXT NOT NULL,
  customer_id TEXT,
  order_status TEXT,
  order_purchase_timestamp TIMESTAMP,
  order_approved_at TIMESTAMP,
  order_delivered_carrier_date TIMESTAMP,
  order_delivered_customer_date TIMESTAMP,
  order_estimated_delivery_date TIMESTAMP
);
GO

--- Order Items Table
IF OBJECT_ID('silver.olist_order_items', 'U') IS NOT NULL
    DROP TABLE silver.olist_order_items;
GO
  
CREATE TABLE order_items (
  order_id TEXT,
  order_item_id INTEGER,
  product_id TEXT,
  seller_id TEXT,
  shipping_limit_date TIMESTAMP,
  price NUMERIC(12,2),
  freight_value NUMERIC(12,2)
);
GO

--- Orders Payments Table
IF OBJECT_ID('silver.order_payments', 'U') IS NOT NULL
    DROP TABLE silver.olist_order_payments;
GO
  
CREATE TABLE order_payments (
  order_id TEXT,
  payment_sequential INTEGER,
  payment_type TEXT,
  payment_installments INTEGER,
  payment_value NUMERIC(12,2)
);
GO

--- Orders Reviews Table
IF OBJECT_ID('silver.order_reviews', 'U') IS NOT NULL
    DROP TABLE silver.olist_order_reviews;
GO

CREATE TABLE silver.olist_order_reviews (
  review_id TEXT,
  order_id TEXT,
  review_score INTEGER,
  review_comment_title TEXT,
  review_comment_message TEXT,
  review_creation_date TIMESTAMP,
  review_answer_timestamp TIMESTAMP
);
GO

--- Product Category Name Translation Table
IF OBJECT_ID('silver.olist_product_category_name_translation', 'U') IS NOT NULL
    DROP TABLE silver.olist_product_category_name_translation;
GO

CREATE TABLE silver.olist_product_category_name_translation (
  product_category_name TEXT,
  product_category_name_english TEXT
);
GO
