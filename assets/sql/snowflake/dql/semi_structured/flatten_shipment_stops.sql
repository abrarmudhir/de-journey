SELECT
    shipment_id,
    event_timestamp,
    stop.value:city::STRING AS stop_city,
    stop.value:country::STRING AS stop_country
FROM logistics.delivery_events,
LATERAL FLATTEN(
    INPUT => event_payload:stops
) AS stop
WHERE event_type = 'PICKUP'
  AND shipment_id = 'SHP-0003';