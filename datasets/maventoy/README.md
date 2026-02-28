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
### CSV File Descriptions

The original dataset consists of the following CSV files:

1. sessions.csv

Contains high-level website traffic data. Each row represents a unique user session.

    session_id: Unique identifier for each web session.

    created_at: The date and time the session started.

    user_id: Unique identifier for the user (if logged in).

    utm_source: The source of traffic (e.g., gsearch, bsearch, social).

    utm_campaign: The specific marketing campaign name.

    utm_content: The specific ad content or creative used.

    device_type: The type of device used (e.g., desktop, mobile).

    http_referer: The URL of the page that linked to the store.

2. pageviews.csv

Granular data showing every page a user visited during a session. Essential for funnel analysis.

    website_pageview_id: Unique identifier for each page view event.

    created_at: Timestamp of when the page was viewed.

    website_session_id: Foreign key connecting to the sessions table.

    pageview_url: The specific page URL visited (e.g., /products, /cart, /shipping).

3. orders.csv

Summary table for every completed transaction.

    order_id: Unique identifier for each order.

    created_at: Timestamp of when the order was placed.

    website_session_id: Foreign key connecting the order to the specific session it originated from.

    user_id: Unique identifier for the customer.

    primary_product_id: The ID of the main product purchased in the order.

    items_purchased: Total count of items in the order.

    price_usd: The total revenue amount charged to the customer.

    cogs_usd: The total Cost of Goods Sold for the order.

4. order_items.csv

Breakdown of each individual item within an order (Line-item level).

    order_item_id: Unique identifier for each specific item row.

    created_at: Timestamp of the transaction.

    order_id: Foreign key connecting to the orders table.

    product_id: Foreign key connecting to the products table.

    is_primary_item: Boolean (1/0) indicating if this was the main item or a cross-sell/add-on.

    price_usd: Sale price for this specific item.

    cogs_usd: Cost of goods sold for this specific item.

5. products.csv

The product catalog containing static product information.

    product_id: Unique identifier for each product.

    created_at: Date the product was first added to the store.

    product_name: The official name of the toy or product.

6. order_item_refunds.csv

Contains records of returned items and refunded amounts.

    order_item_refund_id: Unique identifier for the refund record.

    created_at: Timestamp of when the refund was processed.

    order_item_id: Foreign key connecting to the specific item that was refunded.

    order_id: Foreign key connecting to the original order.

    refund_amount_usd: The total amount returned to the customer.

---
### Note on Data Availability

Due to GitHub file size limitations, **some or all CSV files are not included in this repository**.

The full dataset can be downloaded directly from Maven Analytics using the link below:

🔗 **Toy Store E-Commerce Dataset (Maven Analytics)**  
https://mavenanalytics.io/data-playground/toy-store-e-commerce-database

After downloading, place the CSV files in this folder following the expected structure before running the SQL scripts or Jupyter notebooks.
