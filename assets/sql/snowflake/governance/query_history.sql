SELECT
    query_text,
    warehouse_name,
    execution_time,
    bytes_scanned
FROM SNOWFLAKE.ACCOUNT_USAGE.QUERY_HISTORY
WHERE start_time >= DATEADD('day', -7, CURRENT_TIMESTAMP())
ORDER BY execution_time DESC
LIMIT 10;