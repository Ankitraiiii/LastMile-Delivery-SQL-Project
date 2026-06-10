-- ================================================
-- Query 2: Late & Failed Orders (Exception Flagging)
-- Purpose: Identify and categorize delivery exceptions
-- Dataset: Olist Brazilian E-Commerce (Kaggle)
-- ================================================

SELECT 
    o.order_id,
    o.order_status,
    o.order_purchase_timestamp,
    o.order_delivered_customer_date,
    o.order_estimated_delivery_date,
    DATEDIFF(DAY,
        o.order_purchase_timestamp,
        o.order_delivered_customer_date)   AS total_delivery_days,
    i.price,
    i.freight_value,
    CASE
        WHEN o.order_status = 'delivered' 
         AND o.order_delivered_customer_date > o.order_estimated_delivery_date 
        THEN 'Late Delivery'
        WHEN o.order_status IN ('canceled','unavailable') 
        THEN 'Order Failed'
        WHEN o.order_delivered_customer_date IS NULL 
        THEN 'Not Yet Delivered'
        ELSE 'Normal'
    END                                    AS exception_type
FROM olist_orders_dataset o
JOIN olist_order_items_dataset i 
    ON o.order_id = i.order_id
WHERE o.order_status != 'delivered'
   OR o.order_delivered_customer_date > o.order_estimated_delivery_date
ORDER BY exception_type, total_delivery_days DESC;