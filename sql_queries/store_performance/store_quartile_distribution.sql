-- Q3: NTILE - Divide stores into quartiles by sales volume
WITH store_sales AS (
    SELECT
        store_number,
        store_name,
        city,
        ROUND(SUM(sale_dollars), 2) AS total_sales
    FROM `bigquery-public-data.iowa_liquor_sales.sales`
    WHERE date >= '2024-07-01'
    GROUP BY store_number, store_name, city
)
SELECT
    store_number,
    store_name,
    city,
    total_sales,
    NTILE(4) OVER (ORDER BY total_sales DESC) AS quartile,
    CASE NTILE(4) OVER (ORDER BY total_sales DESC)
        WHEN 1 THEN 'Top 25%'
        WHEN 2 THEN 'Upper Middle'
        WHEN 3 THEN 'Lower Middle'
        WHEN 4 THEN 'Bottom 25%'
    END AS performance_tier
FROM store_sales
ORDER BY total_sales DESC
LIMIT 30;
