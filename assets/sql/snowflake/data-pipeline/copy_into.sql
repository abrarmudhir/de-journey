COPY INTO logistics.shipments
FROM @harbr_internal_stage/shipments/
FILE_FORMAT = (FORMAT_NAME = 'harbr_csv_format');