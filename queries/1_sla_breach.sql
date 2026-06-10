-- ================================================
-- Query 1: SLA Breach Detection
-- Purpose: Identify orders delivered after estimated date
-- Dataset: Olist Brazilian E-Commerce (Kaggle)
-- ================================================

SELECT 
    order_id,
    order_status,
    order_purchase_timestamp,
    order_estimated_delivery_date,
    order_delivered_customer_date,
    DATEDIFF(DAY, 
        order_estimated_delivery_date, 
        order_delivered_customer_date) AS delay_days,
    CASE 
        WHEN order_delivered_customer_date > order_estimated_delivery_date 
        THEN 'SLA BREACHED'
        ELSE 'On Time'
    END AS sla_status
FROM olist_orders_dataset
WHERE order_status = 'delivered'
  AND order_delivered_customer_date IS NOT NULL
ORDER BY delay_days DESC;