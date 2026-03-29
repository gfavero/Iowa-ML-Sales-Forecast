-- Q1: INNER JOIN (via subqueries) - Store totals joined with city averages
-- "Compare each store's sales against its city average"
WITH store_sales AS (
    SELECT
        store_number,
        store_name,
        city,
        ROUND(SUM(sale_dollars), 2) AS store_total_sales
    FROM `bigquery-public-data.iowa_liquor_sales.sales`
    WHERE date >= '2024-07-01'
    GROUP BY store_number, store_name, city
),
city_avg AS (
    SELECT
        city,
        ROUND(AVG(store_total_sales), 2) AS city_avg_sales,
        COUNT(*) AS stores_in_city
    FROM store_sales
    GROUP BY city
)
SELECT
    s.store_number,
    s.store_name,
    s.city,
    s.store_total_sales,
    c.city_avg_sales,
    c.stores_in_city,
    ROUND(s.store_total_sales - c.city_avg_sales, 2) AS diff_from_city_avg
FROM store_sales s
INNER JOIN city_avg c ON s.city = c.city
WHERE c.stores_in_city >= 3
ORDER BY diff_from_city_avg DESC
LIMIT 20;
