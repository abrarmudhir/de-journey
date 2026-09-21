SELECT
    region,
    delivery_status,
    COUNT(*) AS shipment_count,
    GROUPING(region) AS isregionagg,
    GROUPING(delivery_status) AS isstatusagg
FROM logistics.shipments
GROUP BY ROLLUP (
    region,
    delivery_status
)
ORDER BY
    region,
    delivery_status;