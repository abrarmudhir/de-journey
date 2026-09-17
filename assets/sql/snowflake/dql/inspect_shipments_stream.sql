SELECT
    product,
    quantity,
    METADATA$ACTION,
    METADATA$ISUPDATE,
    METADATA$ROW_ID
FROM shipments_stream;