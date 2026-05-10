WITH customer_spend AS (
    SELECT
        o.customer_id,
        ROUND(SUM(oi.price), 2) AS total_spent
    FROM olist_orders_dataset o
    JOIN olist_order_items_dataset oi ON o.order_id = oi.order_id
    WHERE o.order_status = 'delivered'
    GROUP BY o.customer_id
),
segmented AS (
    SELECT
        customer_id,
        total_spent,
        CASE
            WHEN total_spent >= 500 THEN 'High Value'
            WHEN total_spent >= 200 THEN 'Mid Value'
            ELSE 'Low Value'
        END AS customer_segment
    FROM customer_spend
)
SELECT
    customer_segment,
    COUNT(*)                        AS total_customers,
    ROUND(SUM(total_spent), 2)      AS segment_revenue,
    ROUND(AVG(total_spent), 2)      AS avg_spend_per_customer
FROM segmented
GROUP BY customer_segment
ORDER BY segment_revenue DESC