--------------------------------------------------
-- Gold Layer: Enhanced Views with Window Functions
--------------------------------------------------
USE ecommerceDWH;
Go

--------------------------------------------------
-- Daily Orders, Revenue & Refunds View (Enhanced)
--------------------------------------------------
DROP VIEW IF EXISTS gold.maven_daily_orders_revenue;
GO

CREATE VIEW gold.maven_daily_orders_revenue AS
WITH orders_daily AS (
    SELECT
        CAST(created_at AS DATE) AS dt,
        COUNT(order_id) AS total_orders,
        SUM(price_usd) AS revenue_usd
    FROM silver.maven_orders
    GROUP BY CAST(created_at AS DATE)
),
items_daily AS (
    SELECT
        CAST(created_at AS DATE) AS dt,
        SUM(price_usd - cogs_usd) AS gross_profit_usd
    FROM silver.maven_items
    GROUP BY CAST(created_at AS DATE)
),
refunds_daily AS (
    SELECT
        CAST(created_at AS DATE) AS dt,
        COUNT(order_item_refund_id) AS refunds_count,
        SUM(refund_amount_usd) AS refunded_amount_usd
    FROM silver.maven_refunds
    GROUP BY CAST(created_at AS DATE)
)
SELECT
    o.dt AS order_date,
    COALESCE(r.refunds_count, 0) AS refunds_count,
    o.total_orders,
    o.revenue_usd,
    i.gross_profit_usd,
    COALESCE(r.refunded_amount_usd, 0) AS refunded_usd,
    o.revenue_usd - COALESCE(r.refunded_amount_usd, 0) AS net_revenue_usd,
    i.gross_profit_usd - COALESCE(r.refunded_amount_usd, 0) AS net_profit_usd,

    -- Cumulative metrics
    SUM(o.revenue_usd - COALESCE(r.refunded_amount_usd, 0)) OVER (ORDER BY o.dt) AS cumulative_net_revenue,
    SUM(i.gross_profit_usd - COALESCE(r.refunded_amount_usd, 0)) OVER (ORDER BY o.dt) AS cumulative_net_profit,

    -- Ranking by daily revenue
    ROW_NUMBER() OVER (ORDER BY o.revenue_usd DESC) AS rank_by_revenue,
    RANK() OVER (ORDER BY o.revenue_usd DESC) AS rank_by_revenue_ties

FROM orders_daily o
LEFT JOIN items_daily i ON o.dt = i.dt
LEFT JOIN refunds_daily r ON o.dt = r.dt;
GO

--------------------------------------------------
-- Products Performance and Insights (Enhanced)
--------------------------------------------------
DROP VIEW IF EXISTS gold.maven_products_performance;
GO

CREATE VIEW gold.maven_products_performance AS
SELECT
    p.product_id,
    p.product_name,

    -- Sales metrics
    COUNT(i.order_item_id) AS items_sold,
    COUNT(DISTINCT i.order_id) AS orders_count,

    -- Revenue & cost
    SUM(i.price_usd) AS revenue_usd,
    SUM(i.cogs_usd) AS cogs_usd,

    -- Gross profit in KUSD
    CAST(SUM(i.price_usd - i.cogs_usd)/1000.0 AS DECIMAL(10,2)) AS gross_profit_kusd,

    -- Returns
    COUNT(r.order_item_refund_id) AS items_returned,
    CAST(COUNT(r.order_item_refund_id) * 1.0 / NULLIF(COUNT(i.order_item_id),0) * 100 AS DECIMAL(5,2)) AS return_percentage,

    -- Ranking & quintiles
    ROW_NUMBER() OVER (ORDER BY COUNT(i.order_item_id) DESC) AS rank_by_items_sold,
    RANK() OVER (ORDER BY SUM(i.price_usd) DESC) AS rank_by_revenue,
    NTILE(5) OVER (ORDER BY SUM(i.price_usd) DESC) AS revenue_quintile

FROM silver.maven_items i
JOIN silver.maven_products p ON i.product_id = p.product_id
LEFT JOIN silver.maven_refunds r ON i.order_item_id = r.order_item_id
GROUP BY p.product_id, p.product_name;
GO

--------------------------------------------------
-- Marketing Funnel (Enhanced)
--------------------------------------------------
DROP VIEW IF EXISTS gold.maven_marketing_funnel;
GO

CREATE VIEW gold.maven_marketing_funnel AS
SELECT
    s.utm_source,
    COUNT(DISTINCT s.website_session_id) AS sessions,
    COUNT(DISTINCT o.order_id) AS orders,
    CAST(COUNT(DISTINCT o.order_id) * 1.0 / NULLIF(COUNT(DISTINCT s.website_session_id),0) * 100 AS DECIMAL(5,2)) AS conversion_rate_percentage,

    -- Cumulative sessions and orders per source
    SUM(COUNT(DISTINCT s.website_session_id)) OVER (PARTITION BY s.utm_source ORDER BY s.utm_source) AS cumulative_sessions,
    SUM(COUNT(DISTINCT o.order_id)) OVER (PARTITION BY s.utm_source ORDER BY s.utm_source) AS cumulative_orders,

    -- Rank per utm_source by orders
    ROW_NUMBER() OVER (PARTITION BY s.utm_source ORDER BY COUNT(DISTINCT o.order_id) DESC) AS rank_per_source

FROM silver.maven_sessions s
LEFT JOIN silver.maven_orders o ON s.website_session_id = o.website_session_id
GROUP BY s.utm_source;
GO
