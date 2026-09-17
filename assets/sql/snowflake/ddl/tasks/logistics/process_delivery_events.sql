-- Create or replace a task that processes delivery events
CREATE OR REPLACE TASK logistics.process_delivery_events

    -- Warehouse used to run the task
    WAREHOUSE = compute_wh

    -- Check every 5 minutes
    SCHEDULE = '5 minute'

    -- Only run the task when the stream contains unconsumed change data
    WHEN SYSTEM$STREAM_HAS_DATA('logistics.delivery_events_stream')

AS

-- Insert the stream records into the processed events table
INSERT INTO logistics.processed_events

-- Read all available rows from the stream
SELECT *
FROM logistics.delivery_events_stream;