-- Q5: PERCENT_RANK and CUME_DIST - percentile calculations
WITH store_sales AS (
    SELECT
        store_number,
        store_name,
        ROUND(SUM(sale_dollars), 2) AS total_sales
    FROM `bigquery-public-data.iowa_liquor_sales.sales`
    WHERE date >= '2024-07-01'
    GROUP BY store_number, store_name
)
SELECT
    store_name,
    total_sales,
    ROUND(PERCENT_RANK() OVER (ORDER BY total_sales) * 100, 2) AS percentile,
    ROUND(CUME_DIST() OVER (ORDER BY total_sales) * 100, 2) AS cumulative_dist
FROM store_sales
ORDER BY total_sales DESC
LIMIT 20;
