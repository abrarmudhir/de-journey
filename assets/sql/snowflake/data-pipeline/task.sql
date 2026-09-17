CREATE TASK logistics.sync_shipments
    WAREHOUSE = compute_wh
    SCHEDULE = '5 MINUTE'
    WHEN SYSTEM$STREAM_HAS_DATA('logistics.staging_shipments_stream')
AS
    INSERT INTO logistics.shipments
    SELECT shipment_id, region, carrier, delivery_days
    FROM logistics.staging_shipments_stream
    WHERE METADATA$ACTION = 'INSERT';