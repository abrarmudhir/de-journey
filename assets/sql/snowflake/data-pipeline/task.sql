CREATE TASK logistics.sync_shipments
    WAREHOUSE = compute_wh
    SCHEDULE = '5 MINUTE'
    WHEN SYSTEM$STREAM_HAS_DATA('logistics.staging_shipments_stream')
AS
    INSERT INTO logistics.shipments
    SELECT shipment_id, region, carrier, delivery_days
    FROM logistics.staging_shipments_stream
    WHERE METADATA$ACTION = 'INSERT';

CREATE TASK logistics.refresh_dashboard
    WAREHOUSE = harbr_wh
    SCHEDULE = 'USING CRON 0 6 * * * UTC'
AS
CALL logistics.refresh_ops_dashboard();