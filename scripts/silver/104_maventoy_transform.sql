-----------------------------
-- Loading Silver Layer
-----------------------------
USE ecommerceDWH;
Go

--- Inserting Data Into Pageviews Table
TRUNCATE TABLE silver.maven_pageviews;
INSERT INTO silver.maven_pageviews (
	website_pageview_id,
	created_at,
	website_session_id,
	pageview_url
	)
SELECT
    website_pageview_id,
    CAST(
        REPLACE(created_at, '"', '')
        AS DATETIME2(0)
    ) AS created_at,
	website_session_id,
    pageview_url
FROM bronze.maven_pageviews
WHERE
    TRY_CAST(REPLACE(created_at, '"', '') AS DATETIME2(0)) IS NOT NULL;

--- Inserting Data Into Items Table
TRUNCATE TABLE silver.maven_items;
INSERT INTO silver.maven_items (
	order_item_id,
	created_at,
	order_id,
	product_id,
	is_primary_item,
	price_usd,
	cogs_usd
)
SELECT 
	order_item_id,
	created_at,
	order_id,
	product_id,
	is_primary_item,
	price_usd,
	cogs_usd
FROM bronze.maven_items;

--- Inserting Data Into Orders Table
TRUNCATE TABLE silver.maven_orders;
INSERT INTO silver.maven_orders (
	order_id,
	created_at,
	website_session_id,
	user_id,
	primary_product_id,
	items_purchased,
	price_usd,
	cogs_usd
)
SELECT 
	order_id,
	created_at,
	website_session_id,
	user_id,
	primary_product_id,
	items_purchased,
	price_usd,
	cogs_usd
FROM bronze.maven_orders;

--- Inserting Data Into Products Table
TRUNCATE TABLE silver.maven_products;
INSERT INTO silver.maven_products (
	product_id,
	created_at,
	product_name
)
SELECT 
	product_id,
	created_at,
	product_name
FROM bronze.maven_products;

--- Inserting Data Into Refunds Table
TRUNCATE TABLE silver.maven_refunds;
INSERT INTO silver.maven_refunds (
	order_item_refund_id,
	created_at,
	order_item_id,
	order_id,
	refund_amount_usd
)
SELECT 
	order_item_refund_id,
	created_at,
	order_item_id,
	order_id,
	refund_amount_usd
FROM bronze.maven_refunds;

--- Inserting Data Into Sessions Table
TRUNCATE TABLE silver.maven_sessions;
INSERT INTO silver.maven_sessions (
	website_session_id,
	created_at,
	user_id,
	is_repeat_session,
	utm_source,
	utm_campaign,
	utm_content,
	device_type,
	http_referer
)
SELECT 
	website_session_id,
	created_at,
	user_id,
	is_repeat_session,
	utm_source,
	utm_campaign,
	utm_content,
	device_type,
	http_referer
FROM bronze.maven_sessions;

-----------------------------
-- Adding Primary Keys
-----------------------------
ALTER TABLE silver.maven_items
ADD CONSTRAINT pk_items PRIMARY KEY (order_item_id);

ALTER TABLE silver.maven_orders
ADD CONSTRAINT pk_orders PRIMARY KEY (order_id);

ALTER TABLE silver.maven_pageviews
ADD CONSTRAINT pk_pageviews PRIMARY KEY (website_pageview_id);

ALTER TABLE silver.maven_products
ADD CONSTRAINT pk_products PRIMARY KEY (product_id);

ALTER TABLE silver.maven_refunds
ADD CONSTRAINT pk_refunds PRIMARY KEY (order_item_refund_id);

ALTER TABLE silver.maven_sessions
ADD CONSTRAINT pk_sessions PRIMARY KEY (website_session_id);

-----------------------------
-- Adding Foreign Keys
-----------------------------
ALTER TABLE silver.maven_items
ADD CONSTRAINT fk_items_orders
FOREIGN KEY (order_id)
REFERENCES silver.maven_orders (order_id);

ALTER TABLE silver.maven_items
ADD CONSTRAINT fk_items_products
FOREIGN KEY (product_id)
REFERENCES silver.maven_products (product_id);

ALTER TABLE silver.maven_orders
ADD CONSTRAINT fk_orders_sessions
FOREIGN KEY (website_session_id)
REFERENCES silver.maven_sessions (website_session_id);

ALTER TABLE silver.maven_pageviews
ADD CONSTRAINT fk_pageviews_sessions
FOREIGN KEY (website_session_id)
REFERENCES silver.maven_sessions (website_session_id);

ALTER TABLE silver.maven_refunds
ADD CONSTRAINT fk_refunds_orders
FOREIGN KEY (order_item_id)
REFERENCES silver.maven_items (order_item_id);
