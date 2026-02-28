# E-Commerce Data Warehouse (SQL Server)

📌 Project Overview
* This project demonstrates the design and implementation of a layered Data Warehouse architecture using Microsoft SQL Server.
The goal is to simulate a real-world data engineering scenario by building a structured and scalable warehouse for multiple e-commerce datasets.

The project follows a Bronze → Silver → Gold architecture pattern to separate raw ingestion, transformation, and analytical consumption layers

🏗 Architecture
* The warehouse is organized into three schemas:
bronze → Raw data ingestion layer (no transformations)
silver → Cleaned and transformed data with enforced constraints
gold → Business-ready analytical views and metrics
* This layered approach ensures:
Clear separation of concerns
Reproducible transformations
Improved data quality
Better performance optimization

🗂 Project Structure
```
ecommerce-data-warehouse/
│
├── datasets/                        # All CSV dataset files
│   ├── maventoy/                    # MavenToy dataset
│   │   ├── order_item_refunds.csv
│   │   ├── order_items.csv
│   │   ├── orders.csv
│   │   ├── products.csv
│   │   ├── website_pageviews.csv      # Not included in Git due to size
│   │   └── website_sessions.csv      # Not included in Git due to size
│   │
│   └── olist/                        # Olist dataset
│       ├── olist_customers_dataset.csv
│       ├── olist_order_items_dataset.csv
│       ├── olist_order_payments_dataset.csv
│       ├── olist_order_reviews_dataset.csv
│       ├── olist_orders_dataset.csv
│       ├── olist_products_dataset.csv
│       ├── olist_sellers_dataset.csv
│       └── product_category_name_translation.csv
│
├── sql/                              # All SQL scripts
│   ├── 1_create_database.sql        # Create the database and schemas: bronze, silver, gold
│   │
│   ├── bronze/                       # Bronze layer scripts
│   │   ├── 101_maven_bronze_ddl.sql
│   │   ├── 102_maven_bronze_load.sql
│   │   ├── 201_olist_bronze_ddl.sql
│   │   └── 202_olist_bronze_load.sql
│   │
│   ├── silver/                       # Silver layer scripts
│   │   ├── 103_maven_silver_ddl.sql
│   │   ├── 104_maven_transform.sql
│   │   ├── 203_olist_silver_ddl.sql
│   │   └── 204_olist_transform.sql
│   │
│   ├── gold/                         # Gold layer scripts
│   │   ├── 105_maven_views.sql
│   │   └── 205_olist_tables.sql
│
├── notebooks/                        # Jupyter notebooks for analysis
│   ├── maven_notebook.ipynb
│   └── olist_notebook.ipynb
│
├── run_maven.sql                     # Run MavenToy project
├── run_olist.sql                     # Run Olist project
└── README.md                         # Main project README
```

## Olist Gold Tables Notes
Future Work – PKs, FKs, and column adjustments need careful review before final implementation.
Keys – No Primary or Foreign Keys added yet; table relationships are not enforced.
Duplicates – Some tables (e.g., olist_orders) have duplicate rows; PK addition removed duplicates (350 rows left).
Columns – ~108 columns were modified or shifted; some were made NOT NULL for future PKs.
