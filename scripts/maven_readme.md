## Maven Toy Store: Detailed Scripts Description

This pipeline manages the data for the Maven Toy Store, focusing on website performance, sales funnels, and product profitability. It follows the Medallion Architecture to transform raw website logs and sales data into high-level analytical views.
1. Bronze Layer (Raw Ingestion)

    **101_maven_bronze_ddl.sql:** Establishes the initial schema for the Maven dataset. It uses standard types like INT and DECIMAL where the structure is predictable, while using VARCHAR for more volatile fields like page URLs or timestamps to prevent loading failures.

    **102_maven_bronze_load.sql:** Uses the BULK INSERT command to ingest data from multiple CSV files (Orders, Items, Pageviews, Products, Refunds, and Sessions). This stage acts as the raw landing zone for all toy store operations.

2. Silver Layer (Normalization & Constraints)

    **103_maven_silver_ddl.sql:** Defines the cleaned schema, ensuring all primary entities have NOT NULL constraints on their unique identifiers.

    **104_maven_transform.sql:** This is the core of the Silver layer. It performs:

        Data Type Cleaning: For example, stripping quotes from timestamps in maven_pageviews and casting them to proper DATETIME2 formats.

        Referential Integrity: Unlike the Bronze layer, this script adds Primary Keys and Foreign Keys to establish formal relationships between sessions, orders, and products.

3. Gold Layer (Business Logic & Analytics)

    **105_maven_views.sql:** Instead of physical tables, this project uses Calculated Views to provide real-time insights:

        Daily Performance: Aggregates revenue, gross profit, and net profit (revenue minus refunds) on a daily basis.

        Product Performance: Ranks products by items sold and revenue using Window Functions (RANK(), NTILE).

        Marketing Funnel: Calculates the conversion rate from website sessions to actual orders, partitioned by UTM marketing sources.
