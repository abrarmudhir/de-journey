SELECT
    shipment_id,
    region,
    delivery_days,
    DENSE_RANK() OVER (
        PARTITION BY region
        ORDER BY delivery_days
    ) AS regional_rank
FROM logistics.shipments;