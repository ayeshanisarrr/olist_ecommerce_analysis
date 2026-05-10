WITH category_revenue AS (
    SELECT
        COALESCE(t.column2, 'Unknown')                AS category_english,
        COUNT(DISTINCT o.order_id)                    AS total_orders,
        ROUND(SUM(oi.price), 2)                       AS total_revenue,
        ROUND(AVG(CAST(r.review_score AS FLOAT)), 2)  AS avg_review
    FROM olist_order_items_dataset oi
    JOIN olist_products_dataset p        
        ON oi.product_id = p.product_id
    JOIN olist_orders_dataset o          
        ON oi.order_id = o.order_id
    JOIN olist_order_reviews_dataset r   
        ON o.order_id = r.order_id
    LEFT JOIN product_category_name_translation t
        ON p.product_category_name = t.column1
    WHERE o.order_status = 'delivered'
    GROUP BY t.column2
)
SELECT
    category_english,
    total_orders,
    total_revenue,
    avg_review,
    RANK() OVER (ORDER BY total_revenue DESC) AS revenue_rank
FROM category_revenue
ORDER BY revenue_rank