-- Q4: Multiple CTEs - Funnel analysis
-- "Which counties have growing sales AND high store count?"
WITH monthly_county AS (
    SELECT
        county,
        DATE_TRUNC(date, MONTH) AS sale_month,
        ROUND(SUM(sale_dollars), 2) AS monthly_sales
    FROM `bigquery-public-data.iowa_liquor_sales.sales`
    WHERE date >= '2024-07-01'
    GROUP BY county, sale_month
),
county_trend AS (
    SELECT
        county,
        ROUND(AVG(monthly_sales), 2) AS avg_monthly,
        ROUND(
            (MAX(CASE WHEN sale_month = (SELECT MAX(sale_month) FROM monthly_county) THEN monthly_sales END) -
             MIN(CASE WHEN sale_month = (SELECT MIN(sale_month) FROM monthly_county) THEN monthly_sales END))
            / NULLIF(MIN(CASE WHEN sale_month = (SELECT MIN(sale_month) FROM monthly_county) THEN monthly_sales END), 0) * 100
        , 2) AS growth_pct
    FROM monthly_county
    GROUP BY county
),
county_stores AS (
    SELECT
        county,
        COUNT(DISTINCT store_number) AS num_stores
    FROM `bigquery-public-data.iowa_liquor_sales.sales`
    WHERE date >= '2024-07-01'
    GROUP BY county
)
SELECT
    ct.county,
    ct.avg_monthly,
    ct.growth_pct,
    cs.num_stores
FROM county_trend ct
JOIN county_stores cs ON ct.county = cs.county
WHERE ct.growth_pct > 0
    AND cs.num_stores >= 5
ORDER BY ct.growth_pct DESC
LIMIT 20;

/*
  CTE vs SUBQUERY - Interview Answer:
  - CTE: More readable, reusable within the query, named steps (self-documenting)
  - Subquery: Good for one-off filters, EXISTS/IN checks, scalar values
  - Performance: In most engines, CTEs and subqueries optimize similarly
  - BigQuery: CTEs are generally preferred for clarity; both compile to same execution plan
*/
