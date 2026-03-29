-- Q2: Moving average per city - smoothing out weekly noise
WITH weekly_city AS (
    SELECT
        city,
        DATE_TRUNC(date, WEEK) AS sale_week,
        ROUND(SUM(sale_dollars), 2) AS weekly_sales
    FROM `bigquery-public-data.iowa_liquor_sales.sales`
    WHERE date >= '2024-07-01'
        AND city IN ('DES MOINES', 'CEDAR RAPIDS', 'IOWA CITY')
    GROUP BY city, sale_week
)
SELECT
    city,
    sale_week,
    weekly_sales,
    ROUND(AVG(weekly_sales) OVER (
        PARTITION BY city
        ORDER BY sale_week
        ROWS BETWEEN 3 PRECEDING AND CURRENT ROW
    ), 2) AS sma_4_week
FROM weekly_city
ORDER BY city, sale_week;
