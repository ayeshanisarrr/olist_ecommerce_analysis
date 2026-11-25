SELECT
    ROUND(SUM(oi.price), 2)                              AS total_revenue,
    COUNT(DISTINCT o.order_id)                           AS total_orders,
    COUNT(DISTINCT c.customer_unique_id)                 AS total_customers,
    ROUND(SUM(oi.price) / COUNT(DISTINCT o.order_id), 2) AS avg_order_value,
    ROUND(SUM(oi.freight_value), 2)                      AS total_freight_cost
FROM olist_orders_dataset o
JOIN olist_order_items_dataset oi ON o.order_id = oi.order_id
JOIN olist_customers_dataset c ON o.customer_id = c.customer_id
WHERE o.order_status = 'delivered';
