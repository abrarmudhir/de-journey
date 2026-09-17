-- Create or replace a standalone task
CREATE OR REPLACE TASK transform_delivery_summary

    -- Warehouse used to run the task
    WAREHOUSE = harbr_wh

    -- Run at 5 minutes past every hour, in UTC
    SCHEDULE = 'USING CRON 5 * * * * UTC'

AS

-- Insert unprocessed delivery events into the summary table
INSERT INTO delivery_summary

-- Select the required columns
SELECT
    shipment_id,
    status,
    updated_at

FROM delivery_events

-- Only process rows that have not yet been processed
WHERE processed = FALSE;