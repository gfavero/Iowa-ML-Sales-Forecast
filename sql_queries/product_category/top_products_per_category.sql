-- Q2: Top 3 selling products per category (classic interview question!)
WITH product_sales AS (
    SELECT
        category_name,
        item_description,
        SUM(bottles_sold) AS total_bottles,
        ROUND(SUM(sale_dollars), 2) AS total_revenue,
        DENSE_RANK() OVER (
            PARTITION BY category_name
            ORDER BY SUM(sale_dollars) DESC
        ) AS product_rank
    FROM `bigquery-public-data.iowa_liquor_sales.sales`
    WHERE date >= '2024-07-01'
    GROUP BY category_name, item_description
)
SELECT
    category_name,
    item_description,
    total_bottles,
    total_revenue,
    product_rank
FROM product_sales
WHERE product_rank <= 3
ORDER BY category_name, product_rank;
