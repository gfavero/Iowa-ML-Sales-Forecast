-- Q4: Product price segmentation
SELECT
    CASE
        WHEN state_bottle_retail <= 10  THEN 'Budget (≤$10)'
        WHEN state_bottle_retail <= 25  THEN 'Mid-Range ($10-$25)'
        WHEN state_bottle_retail <= 50  THEN 'Premium ($25-$50)'
        WHEN state_bottle_retail <= 100 THEN 'Super Premium ($50-$100)'
        ELSE 'Ultra Premium (>$100)'
    END AS price_segment,
    COUNT(DISTINCT item_description) AS num_products,
    COUNT(*) AS total_transactions,
    ROUND(SUM(sale_dollars), 2) AS total_revenue,
    ROUND(SUM(sale_dollars) / SUM(SUM(sale_dollars)) OVER () * 100, 2) AS revenue_share_pct
FROM `bigquery-public-data.iowa_liquor_sales.sales`
WHERE date >= '2024-07-01'
GROUP BY price_segment
ORDER BY total_revenue DESC;
