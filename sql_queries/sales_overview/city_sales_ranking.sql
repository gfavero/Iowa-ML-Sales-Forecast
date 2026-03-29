-- Q1: Total sales per city (Top 20)
SELECT
    city,
    COUNT(*) AS total_transactions,
    SUM(sale_dollars) AS total_sales,
    ROUND(AVG(sale_dollars), 2) AS avg_sale,
    SUM(bottles_sold) AS total_bottles
FROM `bigquery-public-data.iowa_liquor_sales.sales`
WHERE date >= '2024-07-01'
GROUP BY city
ORDER BY total_sales DESC
LIMIT 20;
