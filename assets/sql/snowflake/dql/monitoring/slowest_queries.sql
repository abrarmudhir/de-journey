-- Find the 5 slowest queries by execution time
SELECT
    warehouse_name,
    execution_ms,
    bytes_scanned
FROM logistics.query_log
ORDER BY execution_ms DESC
LIMIT 5;