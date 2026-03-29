-- Q1: Compare RANK vs DENSE_RANK vs ROW_NUMBER side by side
-- "Rank stores by total sales within each city"
WITH store_sales AS (
    SELECT
        store_number,
        store_name,
        city,
        ROUND(SUM(sale_dollars), 2) AS total_sales
    FROM `bigquery-public-data.iowa_liquor_sales.sales`
    WHERE date >= '2024-07-01'
    GROUP BY store_number, store_name, city
)
SELECT
    city,
    store_name,
    total_sales,
    ROW_NUMBER() OVER (PARTITION BY city ORDER BY total_sales DESC) AS row_num,
    RANK()       OVER (PARTITION BY city ORDER BY total_sales DESC) AS rank_val,
    DENSE_RANK() OVER (PARTITION BY city ORDER BY total_sales DESC) AS dense_rank_val
FROM store_sales
WHERE city IN ('DES MOINES', 'CEDAR RAPIDS')
ORDER BY city, row_num;

/*
  KEY DIFFERENCES (interview answer):
  - ROW_NUMBER: Always unique, sequential (1,2,3,4,5). No ties.
  - RANK:       Ties get same rank, then SKIPS (1,2,2,4,5). Gaps after ties.
  - DENSE_RANK: Ties get same rank, NO skip (1,2,2,3,4). No gaps.

  When to use each:
  - ROW_NUMBER: Pagination, selecting exactly N rows, deduplication
  - RANK:       When gaps matter (e.g., "3rd place" after two ties at 2nd)
  - DENSE_RANK: When you want consecutive ranks regardless of ties
*/
