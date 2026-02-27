-- With SQLCMD Mode ON

:setvar BasePath "C:\Users\muham\ecommerce-data-warehouse\datasets"

PRINT 'Starting Load Process...';

:r .\scripts\1_ddl_database_and_schemas.sql
:r .\scripts\bronze\101_maven_bronze_ddl.sql
:r .\scripts\bronze\102_maven_bronze_load.sql
:r .\scripts\silver\103_maven_silver_ddl.sql
:r .\scripts\silver\104_maven_transform.sql
:r .\scripts\gold\105_maven_views.sql

PRINT 'Load Finished Successfully.';