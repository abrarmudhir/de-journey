CREATE STREAM shipments_stream
ON TABLE logistics.shipments;

CREATE STREAM delivery_events_stream
ON TABLE logistics.delivery_events
APPEND_ONLY = TRUE;