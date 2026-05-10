SELECT
    payment_type,
    COUNT(DISTINCT order_id)            AS total_orders,
    ROUND(SUM(payment_value), 2)        AS total_value,
    ROUND(AVG(payment_installments), 1) AS avg_installments
FROM olist_order_payments_dataset
GROUP BY payment_type
ORDER BY total_value DESC