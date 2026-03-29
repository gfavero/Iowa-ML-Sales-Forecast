-- Q1: Categorize stores by sales volume tier
SELECT
    store_number,
    store_name,
    city,
    ROUND(SUM(sale_dollars), 2) AS total_sales,
    CASE
        WHEN SUM(sale_dollars) >= 500000 THEN 'Enterprise'
        WHEN SUM(sale_dollars) >= 100000 THEN 'Large'
        WHEN SUM(sale_dollars) >= 25000  THEN 'Medium'
        ELSE 'Small'
    END AS store_tier,
    CASE
        WHEN SUM(sale_dollars) >= 500000 THEN 1
        WHEN SUM(sale_dollars) >= 100000 THEN 2
        WHEN SUM(sale_dollars) >= 25000  THEN 3
        ELSE 4
    END AS tier_rank
FROM `bigquery-public-data.iowa_liquor_sales.sales`
WHERE date >= '2024-07-01'
GROUP BY store_number, store_name, city
ORDER BY total_sales DESC
LIMIT 30;
