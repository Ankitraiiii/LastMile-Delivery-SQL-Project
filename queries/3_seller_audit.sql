-- ================================================
-- Query 3: Seller Performance Audit
-- Purpose: Rank sellers by shipping breach rate
-- Dataset: Olist Brazilian E-Commerce (Kaggle)
-- ================================================

SELECT 
    i.seller_id,
    s.seller_city,
    s.seller_state,
    COUNT(DISTINCT i.order_id)              AS total_orders,
    ROUND(AVG(i.price), 2)                  AS avg_order_value,
    ROUND(AVG(i.freight_value), 2)          AS avg_freight,
    SUM(CASE 
        WHEN i.shipping_limit_date < GETDATE() 
         AND o.order_status != 'delivered'
        THEN 1 ELSE 0 
    END)                                    AS shipping_breaches,
    ROUND(
        SUM(CASE 
            WHEN i.shipping_limit_date < GETDATE() 
             AND o.order_status != 'delivered'
            THEN 1.0 ELSE 0 
        END) / COUNT(DISTINCT i.order_id) * 100, 2) AS breach_rate_pct
FROM olist_order_items_dataset i
JOIN olist_sellers_dataset s 
    ON i.seller_id = s.seller_id
JOIN olist_orders_dataset o 
    ON i.order_id = o.order_id
GROUP BY i.seller_id, s.seller_city, s.seller_state
ORDER BY breach_rate_pct DESC;