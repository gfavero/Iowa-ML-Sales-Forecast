-- Q4: Using ROW_NUMBER for "Top N per group" pattern
-- "Find the single best-selling day for each city"
WITH daily_city AS (
    SELECT
        city,
        date,
        ROUND(SUM(sale_dollars), 2) AS daily_sales,
        ROW_NUMBER() OVER (PARTITION BY city ORDER BY SUM(sale_dollars) DESC) AS rn
    FROM `bigquery-public-data.iowa_liquor_sales.sales`
    WHERE date >= '2024-07-01'
    GROUP BY city, date
)
SELECT city, date, daily_sales
FROM daily_city
WHERE rn = 1
ORDER BY daily_sales DESC
LIMIT 20;
