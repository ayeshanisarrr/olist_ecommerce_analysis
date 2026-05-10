WITH seller_metrics AS (
    SELECT
        s.seller_id,
        s.seller_city,
        s.seller_state,
        COUNT(DISTINCT o.order_id)                         AS total_orders,
        ROUND(SUM(oi.price), 2)                            AS total_revenue,
        ROUND(AVG(CAST(r.review_score AS FLOAT)), 2)       AS avg_rating
    FROM olist_sellers_dataset s
    JOIN olist_order_items_dataset oi  ON s.seller_id  = oi.seller_id
    JOIN olist_orders_dataset o        ON oi.order_id  = o.order_id
    JOIN olist_order_reviews_dataset r ON o.order_id   = r.order_id
    WHERE o.order_status = 'delivered'
    GROUP BY s.seller_id, s.seller_city, s.seller_state
)
SELECT
    seller_id,
    seller_city,
    seller_state,
    total_orders,
    total_revenue,
    avg_rating,
    RANK() OVER (ORDER BY total_revenue DESC) AS revenue_rank
FROM seller_metrics
ORDER BY revenue_rank