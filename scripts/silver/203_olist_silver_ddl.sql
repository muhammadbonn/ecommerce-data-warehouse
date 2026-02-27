------------------------
-- Create Olist Silver Tables
------------------------
USE ecommerceDWH;
GO

--- Customers Table
IF OBJECT_ID('silver.olist_customers', 'U') IS NOT NULL
    DROP TABLE silver.olist_customers;
GO

CREATE TABLE silver.olist_customers (
    customer_id NVARCHAR(50) NOT NULL,
    customer_unique_id NVARCHAR(50) NULL,
    customer_zip_code_prefix VARCHAR(10) NULL,
    customer_city NVARCHAR(100) NULL,
    customer_state NVARCHAR(50) NULL
);
GO

--- Sellers Table
IF OBJECT_ID('silver.olist_sellers', 'U') IS NOT NULL
    DROP TABLE silver.olist_sellers;
GO

CREATE TABLE silver.olist_sellers (
    seller_id NVARCHAR(50) NOT NULL,
    seller_zip_code_prefix VARCHAR(10) NULL,
    seller_city NVARCHAR(100) NULL,
    seller_state NVARCHAR(50) NULL
);
GO

--- Products Table
IF OBJECT_ID('silver.olist_products', 'U') IS NOT NULL
    DROP TABLE silver.olist_products;
GO

CREATE TABLE silver.olist_products (
    product_id NVARCHAR(50) NOT NULL,
    product_category_name NVARCHAR(100) NULL,
    product_name_length INT NULL,
    product_description_length INT NULL,
    product_photos_qty INT NULL,
    product_weight_g DECIMAL(12,2) NULL,
    product_length_cm DECIMAL(12,2) NULL,
    product_height_cm DECIMAL(12,2) NULL,
    product_width_cm DECIMAL(12,2) NULL
);
GO

--- Orders Table
IF OBJECT_ID('silver.olist_orders', 'U') IS NOT NULL
    DROP TABLE silver.olist_orders;
GO

CREATE TABLE silver.olist_orders (
    order_id NVARCHAR(50) NOT NULL,
    customer_id NVARCHAR(50) NULL,
    order_status NVARCHAR(50) NULL,
    order_purchase_timestamp DATETIME2 NULL,
    order_approved_at DATETIME2 NULL,
    order_delivered_carrier_date DATETIME2 NULL,
    order_delivered_customer_date DATETIME2 NULL,
    order_estimated_delivery_date DATETIME2 NULL
);
GO

--- Order Items Table
IF OBJECT_ID('silver.olist_order_items', 'U') IS NOT NULL
    DROP TABLE silver.olist_order_items;
GO

CREATE TABLE silver.olist_order_items (
    order_id NVARCHAR(50) NOT NULL,
    order_item_id INT NULL,
    product_id NVARCHAR(50) NULL,
    seller_id NVARCHAR(50) NULL,
    shipping_limit_date DATETIME2 NULL,
    price DECIMAL(12,2) NULL,
    freight_value DECIMAL(12,2) NULL
);
GO

--- Order Payments Table
IF OBJECT_ID('silver.olist_order_payments', 'U') IS NOT NULL
    DROP TABLE silver.olist_order_payments;
GO

CREATE TABLE silver.olist_order_payments (
    order_id NVARCHAR(50) NOT NULL,
    payment_sequential INT NULL,
    payment_type NVARCHAR(50) NULL,
    payment_installments INT NULL,
    payment_value DECIMAL(12,2) NULL
);
GO

--- Order Reviews Table
IF OBJECT_ID('silver.olist_order_reviews', 'U') IS NOT NULL
    DROP TABLE silver.olist_order_reviews;
GO

CREATE TABLE silver.olist_order_reviews (
    review_id NVARCHAR(50) NOT NULL,
    order_id NVARCHAR(50) NULL,
    review_score INT NULL,
    review_comment_title NVARCHAR(255) NULL,
    review_comment_message NVARCHAR(MAX) NULL,
    review_creation_date DATETIME2 NULL,
    review_answer_timestamp DATETIME2 NULL
);
GO

--- Product Category Name Translation Table
IF OBJECT_ID('silver.olist_product_category_name_translation', 'U') IS NOT NULL
    DROP TABLE silver.olist_product_category_name_translation;
GO

CREATE TABLE silver.olist_product_category_name_translation (
    product_category_name NVARCHAR(100) NULL,
    product_category_name_english NVARCHAR(100) NULL
);
GO