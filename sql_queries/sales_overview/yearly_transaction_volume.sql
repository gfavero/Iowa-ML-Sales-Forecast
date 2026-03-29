-- Total rows by year + grand total
SELECT
    CAST(EXTRACT(YEAR FROM date) AS STRING) AS year,
    COUNT(*) AS total_rows
FROM `bigquery-public-data.iowa_liquor_sales.sales`
GROUP BY year

UNION ALL

SELECT 'TOTAL', COUNT(*)
FROM `bigquery-public-data.iowa_liquor_sales.sales`

ORDER BY year
