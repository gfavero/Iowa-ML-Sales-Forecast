-- Q5: COUNT duplicates across the dataset - data quality check
WITH dup_check AS (
    SELECT
        store_number,
        date,
        item_description,
        sale_dollars,
        bottles_sold,
        ROW_NUMBER() OVER (
            PARTITION BY store_number, date, item_description
            ORDER BY invoice_and_item_number
        ) AS rn
    FROM `bigquery-public-data.iowa_liquor_sales.sales`
    WHERE date >= '2024-07-01'
)
SELECT
    COUNT(*) AS total_rows,
    SUM(CASE WHEN rn = 1 THEN 1 ELSE 0 END) AS unique_rows,
    SUM(CASE WHEN rn > 1 THEN 1 ELSE 0 END) AS duplicate_rows,
    ROUND(SUM(CASE WHEN rn > 1 THEN 1 ELSE 0 END) / COUNT(*) * 100, 2) AS dup_percentage
FROM dup_check;
