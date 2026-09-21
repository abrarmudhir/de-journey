SELECT
    shipment_id,
    region,
    delivery_days,
    region_rank
FROM (
    SELECT
        shipment_id,
        region,
        delivery_days,
        ROW_NUMBER() OVER (
            PARTITION BY region
            ORDER BY delivery_days, shipment_id
        ) AS region_rank
    FROM logistics.shipments
)
WHERE region = 'AMER'
  AND region_rank = 1;