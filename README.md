# E-Commerce Data Warehouse (SQL Server)

📌 Project Overview:
* This project demonstrates the design and implementation of a layered Data Warehouse architecture using Microsoft SQL Server.
The goal is to simulate a real-world data engineering scenario by building a structured and scalable warehouse for multiple e-commerce datasets.
The project follows a Bronze → Silver → Gold architecture pattern to separate raw ingestion, transformation, and analytical consumption layers

🏗 Architecture:
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
├── datasets/
│   ├── maventoy/
│   └── olist/
│
├── sql/
│   ├── 01_create_database.sql
│   │
│   ├── bronze/
│   ├── silver/
│   ├── gold/
│   ├── indexing/
│   └── tests/
│
├── erd/
└── README.md```
