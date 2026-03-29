-- Q3: Self-Join - Compare current month vs previous month sales per store
WITH monthly_store AS (
    SELECT
        store_number,
        store_name,
        EXTRACT(YEAR FROM date) AS yr,
        EXTRACT(MONTH FROM date) AS mo,
        ROUND(SUM(sale_dollars), 2) AS monthly_sales
    FROM `bigquery-public-data.iowa_liquor_sales.sales`
    WHERE date >= '2024-07-01'
    GROUP BY store_number, store_name, yr, mo
)
SELECT
    curr.store_number,
    curr.store_name,
    curr.yr AS current_year,
    curr.mo AS current_month,
    curr.monthly_sales AS current_sales,
    prev.monthly_sales AS previous_month_sales,
    ROUND(curr.monthly_sales - prev.monthly_sales, 2) AS mom_change,
    CASE
        WHEN prev.monthly_sales > 0
        THEN ROUND((curr.monthly_sales - prev.monthly_sales) / prev.monthly_sales * 100, 2)
        ELSE NULL
    END AS mom_pct_change
FROM monthly_store curr
INNER JOIN monthly_store prev
    ON curr.store_number = prev.store_number
    AND (curr.yr * 12 + curr.mo) = (prev.yr * 12 + prev.mo) + 1
ORDER BY curr.monthly_sales DESC
LIMIT 20;
