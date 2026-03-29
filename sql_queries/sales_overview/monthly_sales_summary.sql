-- Q2: Monthly sales summary
SELECT
    EXTRACT(YEAR FROM date) AS sale_year,
    EXTRACT(MONTH FROM date) AS sale_month,
    COUNT(*) AS num_transactions,
    ROUND(SUM(sale_dollars), 2) AS total_revenue,
    ROUND(AVG(sale_dollars), 2) AS avg_transaction_value
FROM `bigquery-public-data.iowa_liquor_sales.sales`
WHERE date >= '2024-07-01'
GROUP BY sale_year, sale_month
ORDER BY sale_year, sale_month;
