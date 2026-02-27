------------------------
-- Loading Bronze Layer
------------------------
USE ecommerceDWH;
GO

--- Inserting Data Into Customers Table
TRUNCATE TABLE bronze.olist_customers;

BULK INSERT bronze.olist_customers
FROM '$(BasePath)\olist\olist_customers_dataset.csv'
WITH (
    FIRSTROW = 2,
    FIELDTERMINATOR = ',',
    ROWTERMINATOR = '0x0A',
    DATAFILETYPE = 'char',
    CODEPAGE = '65001',
    TABLOCK
);
GO

--- Inserting Data Into Sellers Table
TRUNCATE TABLE bronze.olist_sellers;

BULK INSERT bronze.olist_sellers
FROM '$(BasePath)\olist\olist_sellers_dataset.csv'
WITH (
    FIRSTROW = 2,
    FIELDTERMINATOR = ',',
    ROWTERMINATOR = '0x0A',
    DATAFILETYPE = 'char',
    CODEPAGE = '65001',
    TABLOCK
);
GO

--- Inserting Data Into Products Table
TRUNCATE TABLE bronze.olist_products;

BULK INSERT bronze.olist_products
FROM '$(BasePath)\olist\olist_products_dataset.csv'
WITH (
    FIRSTROW = 2,
    FIELDTERMINATOR = ',',
    ROWTERMINATOR = '0x0A',
    DATAFILETYPE = 'char',
    CODEPAGE = '65001',
    TABLOCK
);
GO

--- Inserting Data Into Orders Table
TRUNCATE TABLE bronze.olist_orders;

BULK INSERT bronze.olist_orders
FROM '$(BasePath)\olist\olist_orders_dataset.csv'
WITH (
    FIRSTROW = 2,
    FIELDTERMINATOR = ',',
    ROWTERMINATOR = '0x0A',
    DATAFILETYPE = 'char',
    CODEPAGE = '65001',
    TABLOCK
);
GO

--- Inserting Data Into Order Items Table
TRUNCATE TABLE bronze.olist_order_items;

BULK INSERT bronze.olist_order_items
FROM '$(BasePath)\olist\olist_order_items_dataset.csv'
WITH (
    FIRSTROW = 2,
    FIELDTERMINATOR = ',',
    ROWTERMINATOR = '0x0A',
    DATAFILETYPE = 'char',
    CODEPAGE = '65001',
    TABLOCK
);
GO

--- Inserting Data Into Order Payments Table
TRUNCATE TABLE bronze.olist_order_payments;

BULK INSERT bronze.olist_order_payments
FROM '$(BasePath)\olist\olist_order_payments_dataset.csv'
WITH (
    FIRSTROW = 2,
    FIELDTERMINATOR = ',',
    ROWTERMINATOR = '0x0A',
    DATAFILETYPE = 'char',
    CODEPAGE = '65001',
    TABLOCK
);
GO

--- Inserting Data Into Category Translation Table
TRUNCATE TABLE bronze.olist_product_category_name_translation;

BULK INSERT bronze.olist_product_category_name_translation
FROM '$(BasePath)\olist\product_category_name_translation.csv'
WITH (
    FIRSTROW = 2,
    FIELDTERMINATOR = ',',
    ROWTERMINATOR = '0x0A',
    DATAFILETYPE = 'char',
    CODEPAGE = '65001',
    TABLOCK
);
GO

--- Load Data Into Temporary Order Reviews Table
TRUNCATE TABLE bronze.olist_order_reviews_tmp;

BULK INSERT bronze.olist_order_reviews_tmp
FROM '$(BasePath)\olist\olist_order_reviews_dataset.csv'
WITH (
    FIRSTROW = 2,
    FIELDTERMINATOR = ',',
    ROWTERMINATOR = '0x0A',
    DATAFILETYPE = 'char',
    CODEPAGE = '65001',
    TABLOCK
);
GO

--- Clean and Insert into Final Order Reviews Table
TRUNCATE TABLE bronze.olist_order_reviews;

INSERT INTO bronze.olist_order_reviews (
    review_id,
    order_id,
    review_score,
    review_comment_title,
    review_comment_message,
    review_creation_date,
    review_answer_timestamp
)
SELECT
    LEFT(review_id, 100),
    LEFT(order_id, 100),
    TRY_CAST(review_score AS INT),
    LEFT(review_comment_title, 255),
    review_comment_message,
    TRY_CAST(review_creation_date AS DATETIME2),
    TRY_CAST(review_answer_timestamp AS DATETIME2)
FROM bronze.olist_order_reviews_tmp;
GO

PRINT 'Loading Bronze Layer Finished Successfully.';