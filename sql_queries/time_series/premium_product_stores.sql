-- Q5: EXISTS subquery - Stores that sell premium products (bottle_retail > $50)
SELECT DISTINCT
    s.store_number,
    s.store_name,
    s.city
FROM `bigquery-public-data.iowa_liquor_sales.sales` s
WHERE s.date >= '2024-07-01'
    AND EXISTS (
        SELECT 1
        FROM `bigquery-public-data.iowa_liquor_sales.sales` p
        WHERE p.store_number = s.store_number
            AND p.date >= '2024-07-01'
            AND p.state_bottle_retail > 50
    )
ORDER BY s.store_name
LIMIT 20;
