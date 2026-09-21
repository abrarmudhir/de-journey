SELECT
    warehouse_name,
    usage_month,
    credits_used,
    SUM(credits_used) OVER (
        PARTITION BY warehouse_name
        ORDER BY usage_month
    ) AS running_total
FROM logistics.warehouse_usage
ORDER BY
    warehouse_name,
    usage_month;