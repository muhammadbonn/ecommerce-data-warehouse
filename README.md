# E-Commerce Data Warehouse (SQL Server)

## Project Overview
* This project demonstrates the design and implementation of a layered Data Warehouse architecture using Microsoft SQL Server. The goal is to simulate a real-world data engineering scenario by building a structured and scalable warehouse for multiple e-commerce datasets.

---
## Architecture

The project follows the medallion architecture to separate raw ingestion, transformation, and analytical consumption layers. The warehouse is organized into three schemas:

  - **bronze** → Raw data ingestion layer (no transformations)

  - **silver** → Cleaned and transformed data with enforced constraints

  - **gold** → Business-ready analytical views and metrics

This layered approach ensures:

  - Clear separation of concerns

  - Reproducible transformations

  - Improved data quality
  
  - Better performance optimization

---
## How to Run the Project

This project automates the ETL process (Bronze → Silver → Gold) using SQL scripts managed by a master execution file.

### Prerequisites

* Before running the scripts, ensure you have the following installed:

1. **SQL Server & SSMS:** SQL Server 2017 or later (Express, Developer, or Enterprise edition).
   
2. **SQLCMD Utility:** Usually installed with SQL Server, but you can verify by running sqlcmd -? in your terminal.
   
3. **Dataset:** Ensure the raw CSV files are placed in the directory specified in your script variables (e.g., C:\Users\muham\ecommerce-data-warehouse\datasets).
   
---
## Setup & Execution Steps

Follow these steps to build the data warehouse from scratch:
1. Clone the Repository

   ```git clone https://github.com/muhammadbonn/ecommerce-data-warehouse.git```
   
3. PowerShell
   
   ```cd C:\Users\muham\ecommerce-data-warehouse```
   
   ```sqlcmd -S localhost\SQLEXPRESS -E -i run_maven.sql ```

   or

   ```sqlcmd -S localhost\SQLEXPRESS -E -i run_olist.sql ```

   Note: Replace localhost\SQLEXPRESS with your actual SQL Server instance name if it differs.

Command Breakdown:

```-S: Specifies the Server instance.```

```-E: Uses a Trusted Connection (Windows Authentication).```

```-i: Specifies the Input file to execute.```

---
## Project Structure & Documentation

For more detailed information about each layer of the data warehouse and datasets, please refer to the following:

**MavenToy Dataset**

* **Datasets Info:** [View Dataset Descriptions](./datasets/olist/README.md)

**Olist Dataset**

* **Datasets Info:** [View Dataset Descriptions](./datasets/olist/README.md)
* **Bronze Layer:** [View Bronze Scripts Docs](./scripts/bronze/README.md)
* **Silver Layer:** [View Transformation Logic](./scripts/silver/README.md)
* **Gold Layer:** [View Logic](./scripts/gold/README.md)
 
### Project Structure
```
ecommerce-data-warehouse/
│
├── datasets/                         # All CSV dataset files
│   ├── maventoy/                     # MavenToy dataset
│   │
│   └── olist/                        # Olist dataset
│
├── sql/                              # All SQL scripts
│   ├── 1_create_database.sql         # Create the database and schemas: bronze, silver, gold
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
├── run_maven.sql                     # MavenToy execution file
├── run_olist.sql                     # Olist execution file
└── README.md                         # Main project README
```

* Olist Gold Tables Notes (Future Work): PKs, FKs, and column adjustments need careful review before final implementation.
