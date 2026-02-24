------------------------
-- Loading Bronze Layer
------------------------
USE ecommerceDWH;
GO

--- Include script paths
:r ..\..\config\1_paths.sql
  
--- Inserting Data Into Items Table
TRUNCATE TABLE bronze.maven_items;
GO

BULK INSERT bronze.maven_items
FROM @base_path + 'maventoy\order_items.csv'
WITH (
    FIRSTROW = 2,
    FIELDTERMINATOR = ',',
    ROWTERMINATOR = '0x0a',    
    TABLOCK
  );
GO

--- Inserting Data Into Orders Table
TRUNCATE TABLE bronze.maven_orders;
Go

BULK INSERT bronze.maven_orders
FROM @base_path + 'maventoy\orders.csv'
WITH (
	FIRSTROW = 2,
	FIELDTERMINATOR = ',',
	ROWTERMINATOR = '0x0a',	
	TABLOCK
);
Go

--- Inserting Data Into Pageviews Table
TRUNCATE TABLE bronze.maven_pageviews;
Go

BULK INSERT bronze.maven_pageviews
FROM @base_path + 'maventoy\website_pageviews.csv'
WITH (
	FIRSTROW = 2,
	FIELDTERMINATOR = ',',
	ROWTERMINATOR = '0x0a',	
	TABLOCK
);
Go

--- Inserting Data Into Products Table
TRUNCATE TABLE bronze.maven_products;
Go

BULK INSERT bronze.maven_products
FROM @base_path + 'maventoy\products.csv'
WITH (
	FIRSTROW = 2,
	FIELDTERMINATOR = ',',
	ROWTERMINATOR = '0x0a',	
	TABLOCK
);
Go

--- Inserting Data Into Refunds Table
TRUNCATE TABLE bronze.maven_refunds;
Go

BULK INSERT bronze.maven_refunds
FROM @base_path + 'maventoy\order_item_refunds.csv'
WITH (
	FIRSTROW = 2,
	FIELDTERMINATOR = ',',
	ROWTERMINATOR = '0x0a',	
	TABLOCK
);
Go

--- Inserting Data Into Sessions Table
TRUNCATE TABLE bronze.maven_sessions;
Go
BULK INSERT bronze.maven_sessions
FROM @base_path + 'maventoy\website_sessions.csv'
WITH (
	FIRSTROW = 2,
	FIELDTERMINATOR = ',',
	ROWTERMINATOR = '0x0a',	
	TABLOCK
);
Go
