-- Q1: CTE - Multi-step analysis pipeline
-- "Find stores that outperform their county average by more than 50%"
WITH store_totals AS (
    SELECT
        store_number,
        store_name,
        county,
        ROUND(SUM(sale_dollars), 2) AS store_sales
    FROM `bigquery-public-data.iowa_liquor_sales.sales`
    WHERE date >= '2024-07-01'
    GROUP BY store_number, store_name, county
),
county_averages AS (
    SELECT
        county,
        ROUND(AVG(store_sales), 2) AS avg_county_sales,
        COUNT(*) AS num_stores
    FROM store_totals
    GROUP BY county
)
SELECT
    st.store_name,
    st.county,
    st.store_sales,
    ca.avg_county_sales,
    ROUND((st.store_sales - ca.avg_county_sales) / ca.avg_county_sales * 100, 2) AS pct_above_avg
FROM store_totals st
JOIN county_averages ca ON st.county = ca.county
WHERE st.store_sales > ca.avg_county_sales * 1.5
    AND ca.num_stores >= 3
ORDER BY pct_above_avg DESC
LIMIT 20;
