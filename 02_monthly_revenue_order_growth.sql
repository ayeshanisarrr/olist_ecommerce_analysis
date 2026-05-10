SELECT
    FORMAT(o.order_purchase_timestamp, 'yyyy-MM') AS month,
    COUNT(DISTINCT o.order_id)                     AS total_orders,
    ROUND(SUM(oi.price), 2)                        AS revenue,
    ROUND(SUM(oi.freight_value), 2)                AS freight_cost,
    ROUND(SUM(oi.price) / COUNT(DISTINCT o.order_id), 2) AS avg_order_value
FROM olist_orders_dataset o
JOIN olist_order_items_dataset oi ON o.order_id = oi.order_id
WHERE o.order_status = 'delivered'
GROUP BY FORMAT(o.order_purchase_timestamp, 'yyyy-MM')
ORDER BY month