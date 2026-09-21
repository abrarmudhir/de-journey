-- Disable cached results so Snowflake actually executes the query
ALTER SESSION SET USE_CACHED_RESULT = FALSE;

-- Run the query to analyse in Query Profile
SELECT DISTINCT
    warehouse_name,
    carrier,
    delivery_status,
    AVG(weight_kg) OVER (
        PARTITION BY warehouse_name
        ORDER BY dispatch_date
    ) AS running_avg_weight
FROM logistics.shipments_large
WHERE YEAR(dispatch_date) = 2024
ORDER BY running_avg_weight DESC;