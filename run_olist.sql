-- With SQLCMD Mode ON

:setvar BasePath "C:\Users\muham\ecommerce-data-warehouse\datasets"

PRINT 'Starting Load Process...';

:r .\scripts\1_ddl_database_and_schemas.sql
:r .\scripts\bronze\201_olist_bronze_ddl.sql
:r .\scripts\bronze\202_olist_bronze_load.sql
:r .\scripts\silver\203_olist_silver_ddl.sql
:r .\scripts\silver\204_olist_transform.sql
:r .\scripts\gold\205_olist_tables.sql

PRINT 'Load Finished Successfully.';