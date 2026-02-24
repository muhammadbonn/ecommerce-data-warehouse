-----------------------
-- Create Silver Tables
-----------------------
USE ecommerceDWH;
Go
  
--- Orders Table
IF OBJECT_ID('silver.maven_orders', 'U') IS NOT NULL
    DROP TABLE silver.maven_orders;
GO

CREATE TABLE silver.maven_orders (
    order_id INT NOT NULL,
    created_at DATETIME2(0),
    website_session_id INT,
    user_id INT,
    primary_product_id INT,
    items_purchased INT,
    price_usd DECIMAL(10,2),
    cogs_usd DECIMAL(10,2)
);
GO

--- Items Table
IF OBJECT_ID('silver.maven_items', 'U') IS NOT NULL
    DROP TABLE silver.maven_items;
GO

CREATE TABLE silver.maven_items (
    order_item_id INT NOT NULL,
    created_at DATETIME2(0),
    order_id INT,
    product_id INT,
    is_primary_item BIT,
    price_usd DECIMAL(10,2),
    cogs_usd DECIMAL(10,2)
);
GO

--- Refunds Table
IF OBJECT_ID('silver.maven_refunds', 'U') IS NOT NULL
    DROP TABLE silver.maven_refunds;
GO

CREATE TABLE silver.maven_refunds (
    order_item_refund_id INT NOT NULL,
    created_at DATETIME2(0),
    order_item_id INT,
    order_id INT,
    refund_amount_usd DECIMAL(10,2),
);
GO
  
--- Products Table
IF OBJECT_ID('silver.maven_products', 'U') IS NOT NULL
    DROP TABLE silver.maven_products;
GO

CREATE TABLE silver.maven_products (
    product_id INT NOT NULL,
    created_at DATETIME2(0),
    product_name VARCHAR(255)
);

--- Pageviews Table
IF OBJECT_ID('silver.maven_pageviews', 'U') IS NOT NULL
    DROP TABLE silver.maven_pageviews;
GO

CREATE TABLE silver.maven_pageviews (
    website_pageview_id INT NOT NULL,
    created_at DATETIME2(0),
    website_session_id INT,
    pageview_url VARCHAR(255)
);

--- Sessions Table
IF OBJECT_ID('silver.maven_sessions', 'U') IS NOT NULL
    DROP TABLE silver.maven_sessions;
GO

CREATE TABLE silver.maven_sessions (
    website_session_id INT NOT NULL,
    created_at DATETIME2(0),
    user_id INT,
    is_repeat_session BIT,
    utm_source VARCHAR(50),
    utm_campaign VARCHAR(50),
    utm_content VARCHAR(50),
    device_type VARCHAR(20),
    http_referer VARCHAR(255)
);
