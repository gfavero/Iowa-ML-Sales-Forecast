-- -- Q3: Nested subqueries - Stores above the overall median
-- SELECT
--     store_number,
--     store_name,
--     total_sales
-- FROM (
--     SELECT
--         store_number,
--         store_name,
--         ROUND(SUM(sale_dollars), 2) AS total_sales,
--         PERCENTILE_CONT(SUM(sale_dollars), 0.5) OVER () AS median_sales
--     FROM `bigquery-public-data.iowa_liquor_sales.sales`
--     WHERE date >= '2024-07-01'
--     GROUP BY store_number, store_name
-- )
-- WHERE total_sales > median_sales
-- ORDER BY total_sales DESC
-- LIMIT 20;

-- Passo 1: Agrega as vendas por loja
WITH store_totals AS (
    SELECT
        store_number,
        store_name,
        ROUND(SUM(sale_dollars), 2) AS total_sales
    FROM `bigquery-public-data.iowa_liquor_sales.sales`
    WHERE date >= '2024-07-01'
    GROUP BY store_number, store_name
),

-- Passo 2: Calcula a mediana separadamente
overall_median AS (
    SELECT
        PERCENTILE_CONT(total_sales, 0.5) OVER () AS median_sales
    FROM store_totals
    LIMIT 1
)

-- Passo 3: Filtra lojas acima da mediana
SELECT
    s.store_number,
    s.store_name,
    s.total_sales
FROM store_totals s
CROSS JOIN overall_median m
WHERE s.total_sales > m.median_sales
ORDER BY s.total_sales DESC
LIMIT 20;
