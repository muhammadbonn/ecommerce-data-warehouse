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
CSV File Descriptions
1. olist_customers_dataset.csv

Contains information about customers and their locations. Used to analyze customer distribution and geo-segmentation.

    customer_id: Key to the orders dataset. Each order has a unique customer_id.

    customer_unique_id: Unique identifier for a customer (stays the same for returning customers).

    customer_zip_code_prefix: First five digits of customer zip code.

    customer_city: City name.

    customer_state: State abbreviation.

2. olist_orders_dataset.csv

The core table containing the main lifecycle of every order.

    order_id: Unique identifier of the order.

    customer_id: Foreign key to customers table.

    order_status: Status of the order (delivered, canceled, etc.).

    order_purchase_timestamp: Timestamp of the purchase.

    order_delivered_customer_date: Actual delivery date to the customer.

3. olist_order_items_dataset.csv

Contains data about the items purchased within each order.

    order_id: Unique identifier of the order.

    order_item_id: Sequential number identifying number of items included in the same order.

    product_id: Unique product identifier.

    seller_id: Unique seller identifier.

    shipping_limit_date: Seller shipping limit date of handling the order to the logistic partner.

    price: Item price.

    freight_value: Item freight value (shipping cost).

4. olist_order_payments_dataset.csv

Contains details about payment methods and installments.

    order_id: Unique identifier of the order.

    payment_sequential: A customer may pay an order with more than one payment method.

    payment_type: Method of payment (credit_card, boleto, voucher, etc.).

    payment_installments: Number of installments chosen by the customer.

    payment_value: Total amount paid.

5. olist_products_dataset.csv

Detailed information about products sold by Olist.

    product_id: Unique product identifier.

    product_category_name: Root category of product (in Portuguese).

    product_name_lenght: Number of characters in the product name.

    product_description_lenght: Number of characters in the description.

    product_photos_qty: Number of product published photos.

    product_weight_g: Product weight measured in grams.

6. olist_sellers_dataset.csv

Contains information about the sellers who fulfilled orders on Olist.

    seller_id: Unique seller identifier.

    seller_zip_code_prefix: First 5 digits of seller zip code.

    seller_city: Seller city name.

    seller_state: Seller state.

7. olist_order_reviews_dataset.csv

Contains data from customer satisfaction surveys.

    review_id: Unique review identifier.

    order_id: Unique order identifier.

    review_score: Satisfaction score from 1 to 5.

    review_comment_title: Title of the review comment.

    review_comment_message: Review comment message.

8. product_category_name_translation.csv

A lookup table to translate category names to English.

    product_category_name: Name in Portuguese.

    product_category_name_english: Name in English.
    
---
### Key Design Choices
- Only **core business attributes** were kept — focusing on customers, sellers, products, orders, payments, and reviews.  
- **Timing fields**, **delivery durations**, and **geospatial coordinates (lat/lng)** were intentionally **excluded** to simplify the model.  
- Brazilian **cities and states** were retained for geographical insights.
