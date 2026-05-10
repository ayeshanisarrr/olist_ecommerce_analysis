WITH delivery_analysis AS (
    SELECT
        o.order_id,
        o.customer_id,
        DATEDIFF(day,
            o.order_estimated_delivery_date,
            o.order_delivered_customer_date)               AS delay_days,
        CASE
            WHEN o.order_delivered_customer_date
                 > o.order_estimated_delivery_date THEN 'Late'
            ELSE 'On Time'
        END                                                AS delivery_status,
        r.review_score
    FROM olist_orders_dataset o
    JOIN olist_order_reviews_dataset r ON o.order_id = r.order_id
    WHERE o.order_delivered_customer_date IS NOT NULL
)
SELECT
    delivery_status,
    COUNT(*)                                               AS total_orders,
    ROUND(AVG(CAST(review_score AS FLOAT)), 2)            AS avg_review_score,
    ROUND(AVG(CAST(delay_days AS FLOAT)), 1)              AS avg_delay_days
FROM delivery_analysis
GROUP BY delivery_status
ORDER BY avg_review_score DESC;