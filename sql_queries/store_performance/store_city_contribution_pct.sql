-- Q2: Percent of total - each store's contribution to its city's sales
WITH store_sales AS (
    SELECT
        store_number,
        store_name,
        city,
        ROUND(SUM(sale_dollars), 2) AS store_total
    FROM `bigquery-public-data.iowa_liquor_sales.sales`
    WHERE date >= '2024-07-01'
    GROUP BY store_number, store_name, city
)
SELECT
    store_number,
    store_name,
    city,
    store_total,
    ROUND(SUM(store_total) OVER (PARTITION BY city), 2) AS city_total,
    ROUND(store_total / SUM(store_total) OVER (PARTITION BY city) * 100, 2) AS pct_of_city
FROM store_sales
ORDER BY city, pct_of_city DESC;
