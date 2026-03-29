-- Q2: LEFT JOIN - All stores with their top-selling category (some might have NULL)
WITH store_category_sales AS (
    SELECT
        store_number,
        store_name,
        category_name,
        SUM(sale_dollars) AS category_sales,
        ROW_NUMBER() OVER (PARTITION BY store_number ORDER BY SUM(sale_dollars) DESC) AS rn
    FROM `bigquery-public-data.iowa_liquor_sales.sales`
    WHERE date >= '2024-07-01'
    GROUP BY store_number, store_name, category_name
),
all_stores AS (
    SELECT DISTINCT store_number, store_name, city
    FROM `bigquery-public-data.iowa_liquor_sales.sales`
    WHERE date >= '2024-07-01'
),
top_categories AS (
    SELECT store_number, category_name, category_sales
    FROM store_category_sales
    WHERE rn = 1
)
SELECT
    a.store_number,
    a.store_name,
    a.city,
    t.category_name AS top_category,
    t.category_sales
FROM all_stores a
LEFT JOIN top_categories t ON a.store_number = t.store_number
ORDER BY t.category_sales DESC NULLS LAST
LIMIT 20;
