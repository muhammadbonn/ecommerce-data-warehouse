## Data Source
- **Dataset:** [Brazilian E-commerce Public Dataset by Olist](https://www.kaggle.com/datasets/olistbr/brazilian-ecommerce)  
- **Provider:** Olist (via Kaggle)  
- **Period:** 2016–2018  
- **Description:** A comprehensive dataset containing thousands of e-commerce orders from multiple Brazilian marketplaces, including customer, seller, product, payment, and review data.

---
### Data Structure
```
└── olist/                                # Olist dataset
├── olist_customers_dataset.csv
├── olist_order_items_dataset.csv
├── olist_order_payments_dataset.csv
├── olist_order_reviews_dataset.csv
├── olist_orders_dataset.csv
├── olist_products_dataset.csv
├── olist_sellers_dataset.csv
└── product_category_name_translation.csv
```

---
### Key Design Choices
- Only **core business attributes** were kept — focusing on customers, sellers, products, orders, payments, and reviews.  
- **Timing fields**, **delivery durations**, and **geospatial coordinates (lat/lng)** were intentionally **excluded** to simplify the model.  
- Brazilian **cities and states** were retained for geographical insights.
