WITH seller_city AS (
    SELECT seller_id,
           CASE WHEN LOWER(LTRIM(RTRIM(seller_city))) IN
                ('sao paulo','sao  paulo','sao paluo','sao paulop','sao paulo - sp',
                 'são paulo','sp','sao paulo sp','sao paulo / sao paulo','sp / sp')
                THEN 'sao paulo'
                ELSE LOWER(LTRIM(RTRIM(seller_city))) END AS city
    FROM olist_sellers_dataset
)
SELECT TOP 10
    sc.city,
    COUNT(DISTINCT sc.seller_id) AS sellers,
    ROUND(SUM(oi.price), 2)      AS total_revenue
FROM seller_city sc
JOIN olist_order_items_dataset oi ON oi.seller_id = sc.seller_id
JOIN olist_orders_dataset o ON o.order_id = oi.order_id
WHERE o.order_status = 'delivered'
GROUP BY sc.city
ORDER BY total_revenue DESC;
