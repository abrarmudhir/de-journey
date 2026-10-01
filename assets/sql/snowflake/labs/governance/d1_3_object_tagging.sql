/*----------------D1_3 Hands-on----------------
1) Creating & Applying Object Tags
2) Object Tag Inheritance
3) Reading Tag Associations
----------------------------------------------*/

--GRANT CREATE TAG ON SCHEMA operations_db.operations_schema TO ROLE tag_admin;
--GRANT APPLY TAG ON ACCOUNT TO ROLE tag_admin;

USE ROLE accountadmin;
USE WAREHOUSE compute_wh; 

CREATE DATABASE security_objects_db;
CREATE SCHEMA security_objects_schema;

CREATE TAG business_unit;

-- Allowed String Values
CREATE OR REPLACE TAG business_unit allowed_values 'sales','HR','operations';

ALTER WAREHOUSE compute_wh SET TAG business_unit = 'engineering';

SELECT system$get_tag_allowed_values('security_objects_db.security_objects_schema.business_unit'); 

ALTER WAREHOUSE compute_wh SET TAG business_unit = 'sales';

ALTER TAG security_objects_db.security_objects_schema.business_unit ADD ALLOWED_VALUES 'engineering'; 

select system$get_tag_allowed_values('security_objects_db.security_objects_schema.business_unit');

-- Tag Inheritance
CREATE DATABASE operations_db TAG (business_unit = 'operations');

CREATE OR REPLACE SCHEMA operations_schema;

CREATE TABLE customer (
  ID NUMBER, 
  NAME STRING,
  EMAIL STRING,
  COUNTRY_CODE STRING
);

-- Reading Tag Associations
SELECT *
FROM TABLE (operations_db.information_schema.tag_references('customer', 'table'));

SELECT *
FROM snowflake.account_usage.tag_references;

SELECT *
FROM TABLE (operations_db.information_schema.tag_references('customer.id', 'column'));


CREATE OR REPLACE TAG security_objects_db.security_objects_schema.protected_data allowed_values 'PII';

ALTER TABLE customer ALTER COLUMN NAME SET TAG security_objects_db.security_objects_schema.protected_data = 'PII';

SELECT *
FROM TABLE (operations_db.information_schema.tag_references('customer.name', 'column'));

-- Remove hands-on databases
DROP DATABASE security_objects_db;
DROP DATABASE operations_db;
