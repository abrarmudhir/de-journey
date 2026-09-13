SELECT
    user_name,
    event_timestamp,
    client_ip,
    authentication_method,
    error_code,
    error_message
FROM SNOWFLAKE.ACCOUNT_USAGE.LOGIN_HISTORY
WHERE event_timestamp >= DATEADD('day', -90, CURRENT_TIMESTAMP())
  AND client_ip NOT LIKE '203.0.113.%'
ORDER BY event_timestamp DESC;