SELECT
    warehouse_name,
    usage_month,
    credits_used,
    LAG(credits_used) OVER (
        PARTITION BY warehouse_name
        ORDER BY usage_month
    ) AS prev_month_credits,
    credits_used
        - LAG(credits_used) OVER (
            PARTITION BY warehouse_name
            ORDER BY usage_month
        ) AS mom_change
FROM logistics.warehouse_usage
ORDER BY
    warehouse_name,
    usage_month;