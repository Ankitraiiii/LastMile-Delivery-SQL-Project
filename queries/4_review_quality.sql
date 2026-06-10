-- ================================================
-- Query 4: Customer Review & Quality Analysis
-- Purpose: Correlate low review scores with late deliveries
-- Dataset: Olist Brazilian E-Commerce (Kaggle)
-- ================================================

SELECT 
    r.review_score,
    COUNT(*)                                AS total_reviews,
    ROUND(AVG(i.price), 2)                  AS avg_order_value,
    ROUND(AVG(
        DATEDIFF(DAY,
            o.order_purchase_timestamp,
            o.order_delivered_customer_date)
    ), 1)                                   AS avg_delivery_days,
    SUM(CASE 
        WHEN o.order_delivered_customer_date > o.order_estimated_delivery_date 
        THEN 1 ELSE 0 
    END)                                    AS late_deliveries,
    ROUND(COUNT(*) * 100.0 / 
        SUM(COUNT(*)) OVER(), 2)            AS score_distribution_pct
FROM olist_order_reviews_dataset r
JOIN olist_orders_dataset o 
    ON r.order_id = o.order_id
JOIN olist_order_items_dataset i 
    ON o.order_id = i.order_id
WHERE o.order_delivered_customer_date IS NOT NULL
GROUP BY r.review_score
ORDER BY r.review_score ASC;