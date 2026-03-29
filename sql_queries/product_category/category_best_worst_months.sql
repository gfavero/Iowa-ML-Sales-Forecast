-- Q4: FIRST_VALUE / LAST_VALUE - Best and worst month per category
WITH cat_monthly AS (
    SELECT
        category_name,
        DATE_TRUNC(date, MONTH) AS sale_month,
        ROUND(SUM(sale_dollars), 2) AS monthly_sales
    FROM `bigquery-public-data.iowa_liquor_sales.sales`
    WHERE date >= '2024-07-01'
    GROUP BY category_name, sale_month
)
SELECT DISTINCT
    category_name,
    FIRST_VALUE(sale_month) OVER (
        PARTITION BY category_name ORDER BY monthly_sales DESC
        ROWS BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING
    ) AS best_month,
    FIRST_VALUE(monthly_sales) OVER (
        PARTITION BY category_name ORDER BY monthly_sales DESC
        ROWS BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING
    ) AS best_month_sales,
    LAST_VALUE(sale_month) OVER (
        PARTITION BY category_name ORDER BY monthly_sales DESC
        ROWS BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING
    ) AS worst_month,
    LAST_VALUE(monthly_sales) OVER (
        PARTITION BY category_name ORDER BY monthly_sales DESC
        ROWS BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING
    ) AS worst_month_sales
FROM cat_monthly
ORDER BY best_month_sales DESC
LIMIT 15;

