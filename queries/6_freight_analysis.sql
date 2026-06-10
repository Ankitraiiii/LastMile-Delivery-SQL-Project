-- ================================================
-- Query 6: Freight vs Order Value Analysis
-- Purpose: Analyze delivery performance by freight category
-- Dataset: Olist Brazilian E-Commerce (Kaggle)
-- ================================================

SELECT 
    CASE 
        WHEN i.freight_value > i.price       
        THEN 'Freight > Order Value'
        WHEN i.freight_value > i.price * 0.5 
        THEN 'High Freight (>50%)'
        WHEN i.freight_value > i.price * 0.2 
        THEN 'Medium Freight (20-50%)'
        ELSE 'Low Freight (<20%)'
    END                                      AS freight_category,
    COUNT(*)                                 AS total_orders,
    ROUND(AVG(i.price), 2)                   AS avg_price,
    ROUND(AVG(i.freight_value), 2)           AS avg_freight,
    ROUND(AVG(
        DATEDIFF(DAY,
            o.order_purchase_timestamp,
            o.order_delivered_customer_date)
    ), 1)                                    AS avg_delivery_days,
    SUM(CASE 
        WHEN o.order_delivered_customer_date > o.order_estimated_delivery_date 
        THEN 1 ELSE 0 
    END)                                     AS sla_breached
FROM olist_order_items_dataset i
JOIN olist_orders_dataset o 
    ON i.order_id = o.order_id
WHERE o.order_delivered_customer_date IS NOT NULL
GROUP BY 
    CASE 
        WHEN i.freight_value > i.price       
        THEN 'Freight > Order Value'
        WHEN i.freight_value > i.price * 0.5 
        THEN 'High Freight (>50%)'
        WHEN i.freight_value > i.price * 0.2 
        THEN 'Medium Freight (20-50%)'
        ELSE 'Low Freight (<20%)'
    END
ORDER BY avg_delivery_days DESC;