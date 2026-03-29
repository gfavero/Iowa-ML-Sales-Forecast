-- Q2: Classic ROW_NUMBER deduplication pattern
-- "Keep only the first occurrence of each duplicate"
WITH ranked AS (
    SELECT
        *,
        ROW_NUMBER() OVER (
            PARTITION BY store_number, date, item_description
            ORDER BY invoice_and_item_number
        ) AS rn
    FROM `bigquery-public-data.iowa_liquor_sales.sales`
    WHERE date >= '2024-10-01'
)
SELECT *
FROM ranked
WHERE rn = 1
LIMIT 20;

/*
  INTERVIEW EXPLANATION:
  1. PARTITION BY defines what makes rows "duplicates"
  2. ORDER BY determines which row to keep (first invoice number)
  3. Filter rn = 1 keeps only the first occurrence
  4. In production, you'd INSERT INTO a clean table or use DELETE with a CTE
*/
