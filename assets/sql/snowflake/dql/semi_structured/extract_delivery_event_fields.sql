SELECT
    shipment_id,
    event_timestamp,
    event_payload:carrier.name::STRING AS carrier_name,
    event_payload:destination.city::STRING AS city
FROM logistics.delivery_events
WHERE event_type = 'EXCEPTION'
  AND shipment_id = 'SHP-0008';