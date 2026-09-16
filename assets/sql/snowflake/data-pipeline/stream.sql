CREATE STREAM shipments_stream
ON TABLE logistics.shipments;

CREATE STREAM delivery_events_stream
ON TABLE logistics.delivery_events
APPEND_ONLY = TRUE;

SELECT
    product,
    quantity,
    METADATA$ACTION,
    METADATA$ISUPDATE,
    METADATA$ROW_ID
FROM shipments_stream;