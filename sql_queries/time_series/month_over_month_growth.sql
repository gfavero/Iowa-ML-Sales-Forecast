-- Q3: LAG / LEAD - Month-over-month comparison
WITH monthly_sales AS (
    SELECT
        DATE_TRUNC(date, MONTH) AS sale_month,
        ROUND(SUM(sale_dollars), 2) AS total_sales
    FROM `bigquery-public-data.iowa_liquor_sales.sales`
    WHERE date >= '2024-07-01'
    GROUP BY sale_month
)
SELECT
    sale_month,
    total_sales,
    LAG(total_sales, 1) OVER (ORDER BY sale_month) AS prev_month_sales,
    LEAD(total_sales, 1) OVER (ORDER BY sale_month) AS next_month_sales,
    ROUND(total_sales - LAG(total_sales, 1) OVER (ORDER BY sale_month), 2) AS mom_change,
    ROUND(
        (total_sales - LAG(total_sales, 1) OVER (ORDER BY sale_month))
        / LAG(total_sales, 1) OVER (ORDER BY sale_month) * 100
    , 2) AS mom_pct_change
FROM monthly_sales
ORDER BY sale_month;
