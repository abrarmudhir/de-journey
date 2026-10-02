-- =====================================================
-- Snowflake Parameter Precedence Demo
-- Demonstrates Account, User, Session, and Object
-- parameter hierarchy and overrides
-- =====================================================

-- =========================
-- Environment Setup
-- =========================
USE ROLE ACCOUNTADMIN;

CREATE DATABASE DEMO_DB;
CREATE SCHEMA DEMO_SCHEMA;

CREATE TABLE DEMO_TABLE 
(
  NAME STRING,
  AGE INT
);

-- =========================
-- Account Parameters
-- =========================

-- Change to enable Workspaces as default
ALTER ACCOUNT SET USE_WORKSPACES_FOR_SQL = always;

-- =========================
-- Session Parameters
-- =========================
ALTER ACCOUNT SET DATE_OUTPUT_FORMAT = 'YYYY/MM/DD';

ALTER USER admin SET DATE_OUTPUT_FORMAT = 'DD-MM-YYYY';

ALTER SESSION SET DATE_OUTPUT_FORMAT = 'MM, DD, YYYY';

-- Verify effective session setting
SELECT CURRENT_DATE();

-- =========================
-- Inspect Parameter Values
-- =========================
SHOW PARAMETERS;

SHOW PARAMETERS LIKE 'DATE_OUTPUT_FORMAT';

SHOW PARAMETERS IN ACCOUNT;

-- =========================
-- Object Parameters
-- =========================
ALTER DATABASE DEMO_DB SET DATA_RETENTION_TIME_IN_DAYS = 7;

ALTER SCHEMA DEMO_SCHEMA SET DATA_RETENTION_TIME_IN_DAYS = 5;

ALTER TABLE DEMO_TABLE SET DATA_RETENTION_TIME_IN_DAYS = 3;

CREATE TABLE SECOND_DEMO_TABLE 
(
  NAME STRING,
  AGE INT
);

SHOW PARAMETERS LIKE 'DATA_RETENTION_TIME_IN_DAYS' IN TABLE second_demo_table;

SHOW PARAMETERS LIKE 'DATA_RETENTION_TIME_IN_DAYS' IN TABLE demo_table;

-- =========================
-- Cleanup
-- =========================
DROP DATABASE DEMO_DB;