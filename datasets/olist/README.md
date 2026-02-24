## Data Source
- **Dataset:** [Brazilian E-commerce Public Dataset by Olist](https://www.kaggle.com/datasets/olistbr/brazilian-ecommerce)  
- **Provider:** Olist (via Kaggle)  
- **Period:** 2016–2018  
- **Description:** A comprehensive dataset containing thousands of e-commerce orders from multiple Brazilian marketplaces, including customer, seller, product, payment, and review data.

### Key Design Choices
- Only **core business attributes** were kept — focusing on customers, sellers, products, orders, payments, and reviews.  
- **Timing fields**, **delivery durations**, and **geospatial coordinates (lat/lng)** were intentionally **excluded** to simplify the model.  
- Brazilian **cities and states** were retained for geographical insights.
