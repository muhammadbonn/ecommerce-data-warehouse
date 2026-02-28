## Data Source
- **Dataset:** [Toy Store E-Commerce Database](https://mavenanalytics.io/data-playground/toy-store-e-commerce-database)  
- **Provider:** Maven Analytics 
- **Description:** E-Commerce database for Maven Fuzzy Factory, an online retailer that sells teddy bears. 

---
### Dataset Structure
```
├── maventoy/                      # MavenToy dataset
|   ├── order_item_refunds.csv
│   ├── order_items.csv
│   ├── orders.csv
│   ├── products.csv
│   ├── website_pageviews.csv      # Not included in Git due to size
│   └── website_sessions.csv       # Not included in Git due to size
```

---
### CSV Files Description

The original dataset consists of the following CSV files:

- **sessions.csv**  
  Website session data, including traffic sources, device types, and session timestamps.

- **pageviews.csv**  
  Individual page views associated with website sessions, used for behavioral and funnel analysis.

- **orders.csv**  
  Order-level data, including order timestamps, total price, and number of items purchased.

- **order_items.csv**  
  Line-item details for each order, including product, price, and cost of goods sold (COGS).

- **products.csv**  
  Product catalog containing product identifiers and product names.

- **refunds.csv**  
  Refund transactions linked to specific order items and orders.

---
### Note on Data Availability

Due to GitHub file size limitations, **some or all CSV files are not included in this repository**.

The full dataset can be downloaded directly from Maven Analytics using the link below:

🔗 **Toy Store E-Commerce Dataset (Maven Analytics)**  
https://mavenanalytics.io/data-playground/toy-store-e-commerce-database

After downloading, place the CSV files in this folder following the expected structure before running the SQL scripts or Jupyter notebooks.
---
