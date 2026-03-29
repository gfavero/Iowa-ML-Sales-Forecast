-- Q4: Moving average comparison - category trends
WITH cat_monthly AS (
    SELECT
        category_name,
        DATE_TRUNC(date, MONTH) AS sale_month,
        ROUND(SUM(sale_dollars), 2) AS monthly_sales
    FROM `bigquery-public-data.iowa_liquor_sales.sales`
    WHERE date >= '2024-01-01'
        AND category_name IN (
            'CANADIAN WHISKIES',
            'AMERICAN VODKAS',
            'STRAIGHT BOURBON WHISKIES',
            'TEQUILA'
        )
    GROUP BY category_name, sale_month
)
SELECT
    category_name,
    sale_month,
    monthly_sales,
    ROUND(AVG(monthly_sales) OVER (
        PARTITION BY category_name
        ORDER BY sale_month
        ROWS BETWEEN 2 PRECEDING AND CURRENT ROW
    ), 2) AS sma_3_month,
    ROUND(monthly_sales - AVG(monthly_sales) OVER (
        PARTITION BY category_name
        ORDER BY sale_month
        ROWS BETWEEN 2 PRECEDING AND CURRENT ROW
    ), 2) AS deviation_from_sma
FROM cat_monthly
ORDER BY category_name, sale_month;
