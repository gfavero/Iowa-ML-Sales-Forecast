-- Analyze negative values: returns vs regular sales
SELECT
    CASE
        WHEN sale_dollars < 0 THEN 'Negative (Return?)'
        WHEN sale_dollars = 0 THEN 'Zero'
        ELSE 'Positive (Sale)'
    END AS sale_type,
    COUNT(*) AS num_transactions,
    ROUND(SUM(sale_dollars), 2) AS total_dollars,
    ROUND(SUM(bottles_sold), 2) AS total_bottles,
    ROUND(AVG(sale_dollars), 2) AS avg_dollars,
    ROUND(AVG(bottles_sold), 2) AS avg_bottles,
    MIN(date) AS earliest,
    MAX(date) AS latest
FROM `bigquery-public-data.iowa_liquor_sales.sales`
GROUP BY sale_type
ORDER BY sale_type
