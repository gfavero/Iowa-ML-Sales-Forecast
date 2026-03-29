-- Q3: Flag weekend vs weekday sales patterns
SELECT
    CASE
        WHEN EXTRACT(DAYOFWEEK FROM date) IN (1, 7) THEN 'Weekend'
        ELSE 'Weekday'
    END AS day_type,
    COUNT(*) AS num_transactions,
    ROUND(SUM(sale_dollars), 2) AS total_sales,
    ROUND(AVG(sale_dollars), 2) AS avg_transaction,
    ROUND(AVG(bottles_sold), 2) AS avg_bottles
FROM `bigquery-public-data.iowa_liquor_sales.sales`
WHERE date >= '2024-07-01'
GROUP BY day_type;
