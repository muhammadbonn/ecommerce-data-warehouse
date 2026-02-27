-----------------------
-- Create Olist Bronze Tables
-----------------------
USE ecommerceDWH;
GO

--- Customers Table
IF OBJECT_ID('bronze.olist_customers', 'U') IS NOT NULL
    DROP TABLE bronze.olist_customers;
GO

CREATE TABLE bronze.olist_customers (
    customer_id VARCHAR(100) NOT NULL,
    customer_unique_id VARCHAR(100) NULL,
    customer_zip_code_prefix VARCHAR(20) NULL,
    customer_city VARCHAR(100) NULL,
    customer_state VARCHAR(10) NULL
);
GO

--- Sellers Table
IF OBJECT_ID('bronze.olist_sellers', 'U') IS NOT NULL
    DROP TABLE bronze.olist_sellers;
GO

CREATE TABLE bronze.olist_sellers (
    seller_id VARCHAR(100) NOT NULL,
    seller_zip_code_prefix VARCHAR(20) NULL,
    seller_city VARCHAR(100) NULL,
    seller_state VARCHAR(50) NULL
);
GO

--- Products Table
IF OBJECT_ID('bronze.olist_products', 'U') IS NOT NULL
    DROP TABLE bronze.olist_products;
GO

CREATE TABLE bronze.olist_products (
    product_id VARCHAR(100) NOT NULL,
    product_category_name VARCHAR(255) NULL,
    product_name_length VARCHAR(20) NULL,
    product_description_length VARCHAR(20) NULL,
    product_photos_qty VARCHAR(20) NULL,
    product_weight_g VARCHAR(20) NULL,
    product_length_cm VARCHAR(20) NULL,
    product_height_cm VARCHAR(20) NULL,
    product_width_cm VARCHAR(20) NULL
);
GO

--- Orders Table
IF OBJECT_ID('bronze.olist_orders', 'U') IS NOT NULL
    DROP TABLE bronze.olist_orders;
GO

CREATE TABLE bronze.olist_orders (
    order_id VARCHAR(100) NOT NULL,
    customer_id VARCHAR(100) NULL,
    order_status VARCHAR(50) NULL,
    order_purchase_timestamp VARCHAR(50) NULL,
    order_approved_at VARCHAR(50) NULL,
    order_delivered_carrier_date VARCHAR(50) NULL,
    order_delivered_customer_date VARCHAR(50) NULL,
    order_estimated_delivery_date VARCHAR(50) NULL
);
GO

--- Order Items Table
IF OBJECT_ID('bronze.olist_order_items', 'U') IS NOT NULL
    DROP TABLE bronze.olist_order_items;
GO

CREATE TABLE bronze.olist_order_items (
    order_id VARCHAR(100) NULL,
    order_item_id VARCHAR(20) NULL,
    product_id VARCHAR(100) NULL,
    seller_id VARCHAR(100) NULL,
    shipping_limit_date VARCHAR(50) NULL,
    price VARCHAR(50) NULL,
    freight_value VARCHAR(50) NULL
);
GO

--- Order Payments Table
IF OBJECT_ID('bronze.olist_order_payments', 'U') IS NOT NULL
    DROP TABLE bronze.olist_order_payments;
GO

CREATE TABLE bronze.olist_order_payments (
    order_id VARCHAR(100) NULL,
    payment_sequential VARCHAR(20) NULL,
    payment_type VARCHAR(50) NULL,
    payment_installments VARCHAR(20) NULL,
    payment_value VARCHAR(50) NULL
);
GO

--- Category Translation Table
IF OBJECT_ID('bronze.olist_product_category_name_translation', 'U') IS NOT NULL
    DROP TABLE bronze.olist_product_category_name_translation;
GO

CREATE TABLE bronze.olist_product_category_name_translation (
    product_category_name VARCHAR(255) NULL,
    product_category_name_english VARCHAR(255) NULL
);
GO

--- Temporary Order Reviews Table
IF OBJECT_ID('bronze.olist_order_reviews_tmp', 'U') IS NOT NULL
    DROP TABLE bronze.olist_order_reviews_tmp;
GO

CREATE TABLE bronze.olist_order_reviews_tmp (
    review_id VARCHAR(MAX) NULL,
    order_id VARCHAR(MAX) NULL,
    review_score VARCHAR(MAX) NULL,
    review_comment_title VARCHAR(MAX) NULL,
    review_comment_message VARCHAR(MAX) NULL,
    review_creation_date VARCHAR(MAX) NULL,
    review_answer_timestamp VARCHAR(MAX) NULL
);
GO

--- Final Order Reviews Table
IF OBJECT_ID('bronze.olist_order_reviews', 'U') IS NOT NULL
    DROP TABLE bronze.olist_order_reviews;
GO

CREATE TABLE bronze.olist_order_reviews (
    review_id VARCHAR(100) NULL,
    order_id VARCHAR(100) NULL,
    review_score INT NULL,
    review_comment_title VARCHAR(255) NULL,
    review_comment_message VARCHAR(MAX) NULL,
    review_creation_date DATETIME2 NULL,
    review_answer_timestamp DATETIME2 NULL
);
GO
