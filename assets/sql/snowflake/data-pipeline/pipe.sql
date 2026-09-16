CREATE PIPE harbr_events_pipe AS
COPY INTO logistics.delivery_events
FROM @harbr_s3_stage/events/
FILE_FORMAT = (FORMAT_NAME = 'harbr_json_format');