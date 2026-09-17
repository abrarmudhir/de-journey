CREATE TASK build_summary
AFTER clean_events
AS
INSERT INTO harbr_db.logistics.delivery_summary
SELECT region, COUNT(*)
FROM harbr_db.logistics.staging_shipments
GROUP BY region;