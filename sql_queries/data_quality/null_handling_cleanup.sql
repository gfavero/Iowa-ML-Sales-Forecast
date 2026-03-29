-- Q5: COALESCE and IFNULL - handling NULLs
SELECT
    store_number,
    store_name,
    COALESCE(city, 'UNKNOWN') AS city,
    COALESCE(county, 'UNKNOWN') AS county,
    COALESCE(address, 'NO ADDRESS') AS address,
    ROUND(SUM(sale_dollars), 2) AS total_sales
FROM `bigquery-public-data.iowa_liquor_sales.sales`
WHERE date >= '2024-07-01'
GROUP BY store_number, store_name, city, county, address
ORDER BY total_sales DESC
LIMIT 20;
