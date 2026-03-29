-- Q1: 3-Month Simple Moving Average (SMA) of total sales
WITH monthly_sales AS (
    SELECT
        DATE_TRUNC(date, MONTH) AS sale_month,
        ROUND(SUM(sale_dollars), 2) AS total_sales
    FROM `bigquery-public-data.iowa_liquor_sales.sales`
    WHERE date >= '2024-01-01'
    GROUP BY sale_month
)
SELECT
    sale_month,
    total_sales,
    ROUND(AVG(total_sales) OVER (
        ORDER BY sale_month
        ROWS BETWEEN 2 PRECEDING AND CURRENT ROW
    ), 2) AS sma_3_month,
    ROUND(AVG(total_sales) OVER (
        ORDER BY sale_month
        ROWS BETWEEN 5 PRECEDING AND CURRENT ROW
    ), 2) AS sma_6_month
FROM monthly_sales
ORDER BY sale_month;
