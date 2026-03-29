-- Q1: Find duplicates - same store, same item, same date, same amount
-- Step 1: Identify potential duplicates
SELECT
    store_number,
    date,
    item_description,
    sale_dollars,
    COUNT(*) AS occurrence_count
FROM `bigquery-public-data.iowa_liquor_sales.sales`
WHERE date >= '2024-07-01'
GROUP BY store_number, date, item_description, sale_dollars
HAVING COUNT(*) > 1
ORDER BY occurrence_count DESC
LIMIT 20;
