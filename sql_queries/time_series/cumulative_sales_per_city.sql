-- Q1: Running total of sales per city (cumulative sum)
WITH daily_city_sales AS (
    SELECT
        city,
        DATE_TRUNC(date, MONTH) AS sale_month,
        ROUND(SUM(sale_dollars), 2) AS monthly_sales
    FROM `bigquery-public-data.iowa_liquor_sales.sales`
    WHERE date >= '2024-07-01'
    GROUP BY city, sale_month
)
SELECT
    city,
    sale_month,
    monthly_sales,
    ROUND(SUM(monthly_sales) OVER (
        PARTITION BY city
        ORDER BY sale_month
        ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW
    ), 2) AS cumulative_sales,
    row_number() over (partition by city order by monthly_sales desc) as rn
FROM daily_city_sales
WHERE city IN ('DES MOINES', 'CEDAR RAPIDS', 'DAVENPORT')
ORDER BY city, sale_month;
