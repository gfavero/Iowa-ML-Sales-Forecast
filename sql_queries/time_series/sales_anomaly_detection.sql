-- Q3: Moving average with variance - detect anomalies
WITH monthly_sales AS (
    SELECT
        DATE_TRUNC(date, MONTH) AS sale_month,
        ROUND(SUM(sale_dollars), 2) AS total_sales
    FROM `bigquery-public-data.iowa_liquor_sales.sales`
    WHERE date >= '2024-01-01'
    GROUP BY sale_month
)
SELECT
    sale_month,
    total_sales,
    ROUND(AVG(total_sales) OVER w, 2) AS sma_3,
    ROUND(STDDEV(total_sales) OVER w, 2) AS std_3,
    CASE
        WHEN total_sales > AVG(total_sales) OVER w + 2 * STDDEV(total_sales) OVER w THEN 'SPIKE'
        WHEN total_sales < AVG(total_sales) OVER w - 2 * STDDEV(total_sales) OVER w THEN 'DIP'
        ELSE 'NORMAL'
    END AS anomaly_flag
FROM monthly_sales
WINDOW w AS (ORDER BY sale_month ROWS BETWEEN 2 PRECEDING AND CURRENT ROW)
ORDER BY sale_month;
