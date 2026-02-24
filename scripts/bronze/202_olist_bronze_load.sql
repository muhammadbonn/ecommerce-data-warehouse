------------------------
-- Loading Bronze Layer
------------------------
USE ecommerceDWH;
GO

--- Include script paths
:r ..\..\config\1_paths.sql
  
--- Inserting Data Into Customers Table
TRUNCATE TABLE bronze.olist_customers;
GO

BULK INSERT bronze.olist_customers
FROM @base_path + 'olist\olist_customers_dataset.csv'
WITH (
    FIRSTROW = 2,
    FIELDTERMINATOR = ',',
    ROWTERMINATOR = '0x0a',    
    TABLOCK
  );
GO

--- Inserting Data Into Sellers Table
TRUNCATE TABLE bronze.olist_sellers;
GO

BULK INSERT bronze.olist_sellers
FROM @base_path + 'olist\olist_sellers_dataset.csv'
WITH (
    FIRSTROW = 2,
    FIELDTERMINATOR = ',',
    ROWTERMINATOR = '0x0a',    
    TABLOCK
  );
GO

--- Inserting Data Into Products Table
TRUNCATE TABLE bronze.olist_products;
GO

BULK INSERT bronze.olist_products
FROM @base_path + 'olist\olist_products_dataset.csv'
WITH (
    FIRSTROW = 2,
    FIELDTERMINATOR = ',',
    ROWTERMINATOR = '0x0a',    
    TABLOCK
  );
GO

--- Inserting Data Into Orders Table
TRUNCATE TABLE bronze.olist_orders;
GO

BULK INSERT bronze.olist_orders
FROM @base_path + 'olist\olist_orders_dataset.csv'
WITH (
    FIRSTROW = 2,
    FIELDTERMINATOR = ',',
    ROWTERMINATOR = '0x0a',    
    TABLOCK
  );
GO

--- Inserting Data Into Order Items Table
TRUNCATE TABLE bronze.olist_order_items;
GO

BULK INSERT bronze.olist_order_items
FROM @base_path + 'olist\olist_order_items_dataset.csv'
WITH (
    FIRSTROW = 2,
    FIELDTERMINATOR = ',',
    ROWTERMINATOR = '0x0a',    
    TABLOCK
  );
GO

--- Inserting Data Into Order Payments Table
TRUNCATE TABLE bronze.olist_order_payments;
GO

BULK INSERT bronze.olist_order_payments
FROM @base_path + 'olist\olist_order_payments_dataset.csv'
WITH (
    FIRSTROW = 2,
    FIELDTERMINATOR = ',',
    ROWTERMINATOR = '0x0a',    
    TABLOCK
  );
GO

--- Inserting Data Into Order Reviews Table
TRUNCATE TABLE bronze.olist_order_reviews;
GO

BULK INSERT bronze.olist_order_reviews
FROM @base_path + 'olist\olist_order_reviews_dataset.csv'
WITH (
    FIRSTROW = 2,
    FIELDTERMINATOR = ',',
    ROWTERMINATOR = '0x0a',    
    TABLOCK
  );
GO

--- Inserting Data Into Product Category Name Translation Table
TRUNCATE TABLE bronze.olist_product_category_name_translation;
GO

BULK INSERT bronze.olist_product_category_name_translation
FROM @base_path + 'olist\product_category_name_translation.csv'
WITH (
    FIRSTROW = 2,
    FIELDTERMINATOR = ',',
    ROWTERMINATOR = '0x0a',    
    TABLOCK
  );
GO


