/*----------------D2_2 Hands-on----------------
1) Virtual Warehouse usage and credit monitoring through UI and SQL 
2) Resource Monitors
----------------------------------------------*/

-- Set context
USE ROLE ACCOUNTADMIN;
USE WAREHOUSE COMPUTE_WH;
USE DATABASE SNOWFLAKE;
USE SCHEMA ACCOUNT_USAGE;

SELECT * FROM WAREHOUSE_METERING_HISTORY
WHERE WAREHOUSE_NAME = 'DATA_ANALYSIS_WAREHOUSE';

-- Total credits used grouped by warehouse
SELECT WAREHOUSE_NAME,
       SUM(CREDITS_USED) AS TOTAL_CREDITS_USED
FROM WAREHOUSE_METERING_HISTORY
WHERE START_TIME >= DATE_TRUNC(MONTH, CURRENT_DATE)
GROUP BY 1
ORDER BY 2 DESC;

-- Warehouse metering history using the Information Schema
SELECT *
FROM TABLE(INFORMATION_SCHEMA.WAREHOUSE_METERING_HISTORY(dateadd('days',-7,current_date())));

-- ============================================
-- Creating and Assigning Resource Monitors
-- ============================================

-- Create Resource Monitor
CREATE OR REPLACE RESOURCE MONITOR ONE_CREDIT_RM WITH CREDIT_QUOTA = 1 
 TRIGGERS 
 ON 50 PERCENT DO NOTIFY
 ON 90 PERCENT DO SUSPEND 
 ON 100 PERCENT DO SUSPEND_IMMEDIATE;

-- Resource Monitor object can be applied at account level 
-- ALTER ACCOUNT SET RESOURCE_MONITOR = "ACCOUNT_RESOURCE_MONITOR";

-- Create demonstration Virtual Warehouse
CREATE WAREHOUSE XXLARGE_WAREHOUSE
WAREHOUSE_SIZE = 'XXLARGE';

-- Apply resource monitor at virtual warehouse level 
ALTER WAREHOUSE XXLARGE_WAREHOUSE SET RESOURCE_MONITOR = "ONE_CREDIT_RM";

-- Attempt a query to confirm the warehouse has been suspended
SELECT * FROM SNOWFLAKE_SAMPLE_DATA.TPCH_SF1.CUSTOMER LIMIT 10;

-- Drop lesson resources
DROP WAREHOUSE XXLARGE_WAREHOUSE;
DROP RESOURCE MONITOR ONE_CREDIT_RM;