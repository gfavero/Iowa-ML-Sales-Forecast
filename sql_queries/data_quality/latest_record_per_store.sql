-- Q4: Dedup keeping the most recent record per store
-- "For each store, keep only the latest transaction info"
WITH latest_store_info AS (
    SELECT
        store_number,
        store_name,
        address,
        city,
        zip_code,
        ROW_NUMBER() OVER (
            PARTITION BY store_number
            ORDER BY date DESC
        ) AS rn
    FROM `bigquery-public-data.iowa_liquor_sales.sales`
    WHERE date >= '2024-07-01'
)
SELECT
    store_number,
    store_name,
    address,
    city,
    zip_code
FROM latest_store_info
WHERE rn = 1
ORDER BY store_number
LIMIT 20;
