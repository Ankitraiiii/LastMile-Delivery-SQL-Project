-- ================================================
-- Query 5: State-wise Delivery Performance
-- Purpose: Identify high SLA breach states for operations
-- Dataset: Olist Brazilian E-Commerce (Kaggle)
-- ================================================

SELECT 
    c.customer_state,
    COUNT(DISTINCT o.order_id)              AS total_orders,
    SUM(CASE 
        WHEN o.order_status = 'delivered' 
        THEN 1 ELSE 0 
    END)                                    AS delivered,
    SUM(CASE 
        WHEN o.order_status = 'canceled' 
        THEN 1 ELSE 0 
    END)                                    AS canceled,
    SUM(CASE 
        WHEN o.order_delivered_customer_date > o.order_estimated_delivery_date 
        THEN 1 ELSE 0 
    END)                                    AS sla_breached,
    ROUND(
        SUM(CASE 
            WHEN o.order_delivered_customer_date > o.order_estimated_delivery_date 
            THEN 1.0 ELSE 0 
        END) / COUNT(DISTINCT o.order_id) * 100, 2) AS sla_breach_pct
FROM olist_orders_dataset o
JOIN olist_customers_dataset c 
    ON o.customer_id = c.customer_id
GROUP BY c.customer_state
ORDER BY sla_breach_pct DESC;