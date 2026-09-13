SELECT
    user_name,
    event_timestamp,
    reported_client_type,
    error_code,
    error_message
FROM SNOWFLAKE.ACCOUNT_USAGE.LOGIN_HISTORY
WHERE error_code IS NOT NULL
  AND event_timestamp >= DATEADD('day', -7, CURRENT_TIMESTAMP())
ORDER BY event_timestamp DESC;