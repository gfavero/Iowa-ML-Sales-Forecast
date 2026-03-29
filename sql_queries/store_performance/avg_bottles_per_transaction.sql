-- Q5: Store performance - average bottles per transaction by store (min 100 transactions)
SELECT
    store_number,
    store_name,
    COUNT(*) AS num_transactions,
    ROUND(AVG(bottles_sold), 2) AS avg_bottles_per_txn,
    ROUND(SUM(sale_dollars), 2) AS total_sales
FROM `bigquery-public-data.iowa_liquor_sales.sales`
WHERE date >= '2024-07-01'
GROUP BY store_number, store_name
HAVING COUNT(*) >= 100
ORDER BY avg_bottles_per_txn DESC
LIMIT 20;

