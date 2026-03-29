-- Q4: CROSS JOIN concept - Compare every category against the overall average
WITH category_stats AS (
    SELECT
        category_name,
        ROUND(AVG(sale_dollars), 2) AS cat_avg_sale,
        COUNT(*) AS cat_transactions
    FROM `bigquery-public-data.iowa_liquor_sales.sales`
    WHERE date >= '2024-07-01'
    GROUP BY category_name
    HAVING COUNT(*) >= 50
),
overall AS (
    SELECT 
        ROUND(AVG(sale_dollars), 2) AS overall_avg
    FROM `bigquery-public-data.iowa_liquor_sales.sales`
    WHERE date >= '2024-07-01'
)
SELECT
    c.category_name,
    c.cat_avg_sale,
    o.overall_avg,
    ROUND(c.cat_avg_sale - o.overall_avg, 2) AS diff_from_overall,
    c.cat_transactions
FROM category_stats c
CROSS JOIN overall o
ORDER BY diff_from_overall DESC
LIMIT 20;
