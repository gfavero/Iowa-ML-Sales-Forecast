-- Q3: DISTINCT vs GROUP BY for deduplication
-- Using DISTINCT - simple column-level dedup
SELECT DISTINCT
    city,
    county
FROM `bigquery-public-data.iowa_liquor_sales.sales`
WHERE date >= '2024-07-01'
ORDER BY city
LIMIT 20;

-- Same result with GROUP BY
SELECT
    city,
    county
FROM `bigquery-public-data.iowa_liquor_sales.sales`
WHERE date >= '2024-07-01'
GROUP BY city, county
ORDER BY city
LIMIT 20;
