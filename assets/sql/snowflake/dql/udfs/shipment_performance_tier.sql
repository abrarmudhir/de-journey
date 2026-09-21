SELECT
    shipment_id,
    region,
    delivery_days,
    logistics.delivery_tier(delivery_days) AS performance_tier
FROM logistics.shipments;