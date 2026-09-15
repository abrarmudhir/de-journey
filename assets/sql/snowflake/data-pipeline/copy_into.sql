COPY INTO logistics.shipments
FROM @harbr_internal_stage/shipments/
FILE_FORMAT = (FORMAT_NAME = 'harbr_csv_format');

COPY INTO logistics.shipments
FROM @harbr_internal_stage/shipments/
FILE_FORMAT = (FORMAT_NAME = 'harbr_csv_format')
VALIDATION_MODE = RETURN_ERRORS;