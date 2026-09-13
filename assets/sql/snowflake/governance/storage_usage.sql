SELECT
    usage_date,
    ROUND(storage_bytes / POWER(1024, 3), 2) AS storage_gb,
    ROUND(failsafe_bytes / POWER(1024, 3), 2) AS failsafe_gb
FROM SNOWFLAKE.ACCOUNT_USAGE.STORAGE_USAGE
ORDER BY usage_date DESC
LIMIT 30;