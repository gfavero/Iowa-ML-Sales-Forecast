-- Q3: HAVING - Cities with more than $1M in sales
SELECT
    city,
    ROUND(SUM(sale_dollars), 2) AS total_sales,
    COUNT(DISTINCT store_number) AS num_stores
FROM `bigquery-public-data.iowa_liquor_sales.sales`
WHERE date >= '2024-07-01'
GROUP BY city
HAVING SUM(sale_dollars) > 1000000
ORDER BY total_sales DESC;
