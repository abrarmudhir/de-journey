-- For read-only access, an administrator can run:
USE ROLE ACCOUNTADMIN;

CREATE ROLE trust_center_viewer_role;

GRANT APPLICATION ROLE SNOWFLAKE.TRUST_CENTER_VIEWER
TO ROLE trust_center_viewer_role;

GRANT ROLE trust_center_viewer_role
TO USER <your_username>;

-- Then switch to that role in Snowsight:
USE ROLE trust_center_viewer_role;

-- For full Trust Center administration instead, grant:
GRANT APPLICATION ROLE SNOWFLAKE.TRUST_CENTER_ADMIN
TO ROLE trust_center_admin_role;