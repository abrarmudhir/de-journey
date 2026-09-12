CREATE ALERT claro_failed_login_alert
    WAREHOUSE = claro_wh
    SCHEDULE = '60 MINUTE'
    IF (
        EXISTS (
            SELECT 1
            FROM SNOWFLAKE.ACCOUNT_USAGE.LOGIN_HISTORY
            WHERE error_code IS NOT NULL
              AND event_timestamp >= DATEADD(
                  'hour',
                  -1,
                  CURRENT_TIMESTAMP()
              )
        )
    )
    THEN CALL SYSTEM$SEND_SNOWFLAKE_NOTIFICATION(...);