-- Q2: Conditional aggregation - pivot monthly sales into columns
SELECT
    city,
    ROUND(SUM(CASE WHEN EXTRACT(MONTH FROM date) = 7  THEN sale_dollars ELSE 0 END), 2) AS jul_sales,
    ROUND(SUM(CASE WHEN EXTRACT(MONTH FROM date) = 8  THEN sale_dollars ELSE 0 END), 2) AS aug_sales,
    ROUND(SUM(CASE WHEN EXTRACT(MONTH FROM date) = 9  THEN sale_dollars ELSE 0 END), 2) AS sep_sales,
    ROUND(SUM(CASE WHEN EXTRACT(MONTH FROM date) = 10 THEN sale_dollars ELSE 0 END), 2) AS oct_sales,
    ROUND(SUM(CASE WHEN EXTRACT(MONTH FROM date) = 11 THEN sale_dollars ELSE 0 END), 2) AS nov_sales,
    ROUND(SUM(CASE WHEN EXTRACT(MONTH FROM date) = 12 THEN sale_dollars ELSE 0 END), 2) AS dec_sales
FROM `bigquery-public-data.iowa_liquor_sales.sales`
WHERE date >= '2024-07-01' AND date < '2025-01-01'
GROUP BY city
ORDER BY dec_sales DESC
LIMIT 15;
