SELECT 
     ROUND(SUM(oi.price), 2) AS total_revenue,
    (SELECT COUNT(customer_id) 
	FROM [olist].[dbo].[olist_customers_dataset]) AS total_orders,
    (SELECT COUNT(DISTINCT customer_unique_id) 
	FROM [olist].[dbo].[olist_customers_dataset]) AS total_Customers,
     ROUND(SUM(oi.price) / COUNT(DISTINCT o.order_id), 2) AS avg_order_value,
    ROUND(SUM(oi.freight_value), 2) AS total_freight_cost
FROM olist_orders_dataset o
JOIN olist_order_items_dataset oi ON o.order_id = oi.order_id
WHERE o.order_status = 'delivered'  