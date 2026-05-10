WITH customer_spend AS (
    SELECT
        o.customer_id,
        COUNT(DISTINCT o.order_id)                         AS total_orders,
        ROUND(SUM(oi.price), 2)                            AS total_spent,
        CONVERT(DATE, MAX(o.order_purchase_timestamp))     AS last_order_date
    FROM olist_orders_dataset o
    JOIN olist_order_items_dataset oi ON o.order_id = oi.order_id
    WHERE o.order_status = 'delivered'
    GROUP BY o.customer_id
)
SELECT
    customer_id,
    total_orders,
    total_spent,
    last_order_date,
    CASE
        WHEN total_spent >= 500 THEN 'High Value'
        WHEN total_spent >= 200 THEN 'Mid Value'
        ELSE 'Low Value'
    END AS customer_segment
FROM customer_spend
ORDER BY total_spent DESC