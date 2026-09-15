SELECT *
FROM TABLE(
    INFORMATION_SCHEMA.COPY_HISTORY(
        TABLE_NAME => 'shipments',
        START_TIME => DATEADD(
            'hour',
            -24,
            CURRENT_TIMESTAMP()
        )
    )
);