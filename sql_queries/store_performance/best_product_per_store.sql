-- Q2: Correlated Subquery - Each store's best-selling product
SELECT
    s.store_number,
    s.store_name,
    s.item_description,
    s.total_item_sales
FROM (
    SELECT
        store_number,
        store_name,
        item_description,
        ROUND(SUM(sale_dollars), 2) AS total_item_sales,
        ROW_NUMBER() OVER (PARTITION BY store_number ORDER BY SUM(sale_dollars) DESC) AS rn
    FROM `bigquery-public-data.iowa_liquor_sales.sales`
    WHERE date >= '2024-07-01'
    GROUP BY store_number, store_name, item_description
) s
WHERE s.rn = 1
ORDER BY s.total_item_sales DESC
LIMIT 20;
