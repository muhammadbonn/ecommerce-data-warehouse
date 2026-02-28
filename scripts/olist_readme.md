## Olist Data Warehouse: Detailed Scripts Description

This project implements a complete End-to-End Data Warehouse using the Medallion Architecture. Below is a breakdown of the SQL scripts provided:

1. Bronze Layer (Raw Ingestion)

    201_olist_bronze_ddl.sql: Defines the physical schema for the Bronze layer. Tables are created with VARCHAR(MAX) or large VARCHAR limits to ensure zero-loss ingestion, accommodating raw data quirks.

    202_olist_bronze_load.sql: Orchestrates the data loading process using the BULK INSERT command. It handles raw CSV files, manages encoding (UTF-8), and includes a specific staging logic for Order Reviews to handle complex text data before the final bronze landing.

2. Silver Layer (Cleansing & Standardization)

    203_olist_silver_ddl.sql: Defines the refined schema. Unlike Bronze, this layer enforces strict data types (DATETIME2, DECIMAL, INT) and proper column lengths to ensure data quality.

    204_olist_transform.sql: The "Engine" of the pipeline. This script performs:

        Data Casting: Converting strings to structured types using TRY_CAST.

        Deduplication: Utilizing ROW_NUMBER() with PARTITION BY to remove duplicate records in order_items, payments, and reviews.

        Data Cleaning: Trimming whitespaces, handling NULL values, and removing formatting artifacts (like extra quotes).

3. Gold Layer (Dimensional Modeling)

    205_olist_tables.sql: Transforms the cleaned Silver data into a Star Schema optimized for analytics.

        Dimensions: Creates dim_products (with category translations), dim_customers, and dim_sellers.

        Fact Table: Builds fact_sales, a comprehensive table that aggregates order-level information, including review scores and total payment values, providing a flat structure for rapid BI reporting.
