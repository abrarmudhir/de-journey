CREATE DYNAMIC TABLE logistics.delivery_summary
    TARGET_LAG = '1 hour'
    WAREHOUSE = harbr_wh
AS
SELECT
    region,
    COUNT(*) AS shipments,
    AVG(delivery_days) AS avg_days
FROM logistics.shipments
GROUP BY region;