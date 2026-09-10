SELECT
    user_name,
    query_id,
    query_start_time,
    direct_objects_accessed,
    base_objects_accessed
FROM SNOWFLAKE.ACCOUNT_USAGE.ACCESS_HISTORY
ORDER BY user_name, query_start_time DESC;