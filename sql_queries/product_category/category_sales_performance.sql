-- Q4: Category performance - which liquor categories sell the most?
SELECT
    category_name,
    COUNT(*) AS transactions,
    SUM(bottles_sold) AS total_bottles,
    ROUND(SUM(sale_dollars), 2) AS total_revenue,
    ROUND(AVG(state_bottle_retail), 2) AS avg_bottle_price
FROM `bigquery-public-data.iowa_liquor_sales.sales`
WHERE date >= '2024-07-01'
GROUP BY category_name
ORDER BY total_revenue DESC
LIMIT 15;
