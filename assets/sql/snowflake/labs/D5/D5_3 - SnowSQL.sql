/*----------------D5_3 Hands-on----------------
1) Configuring SnowSQL
2) Querying with SnowSQL
3) Variables in SnowSQL
SnowSQL Installers: https://developers.snowflake.com/snowsql/
----------------------------------------------*/

/*
To be executed on Powershell or Terminal
*/
cat .\autoupgrade
cat .\config
cat .\history

snowsql

snowsql -a <account_identifier>

/*
To be executed in SnowSQL interactive mode
*/
SELECT CURRENT_SESSION();

/*
To be executed on Powershell or Terminal
*/
snowsql -a <account_identifier> -u <username> -d SNOWFLAKE_SAMPLE_DATA -s TPCH_SF1 -r ACCOUNTADMIN -w COMPUTE_WH

snowsql -a <account_identifier> -u <username> -d SNOWFLAKE_SAMPLE_DATA -s TPCH_SF1 -r ACCOUNTADMIN -w COMPUTE_WH -q 'SELECT C_NAME, C_ADDRESS FROM CUSTOMER LIMIT 5'

cat C:\Users\Admin\Documents\test.sql 

snowsql -a <account_identifier> -u <username> -d SNOWFLAKE_SAMPLE_DATA -s TPCH_SF1 -r ACCOUNTADMIN -w COMPUTE_WH -f <path_to_test.sql>

snowsql -a <account_identifier> -u <username> -d SNOWFLAKE_SAMPLE_DATA -s TPCH_SF1 -r ACCOUNTADMIN -w COMPUTE_WH

/*
To be executed in SnowSQL interactive mode
*/
SELECT CURRENT_ROLE();

USE SCHEMA tpch_sf10;

SELECT COUNT(DISTINCT c_nationkey) FROM customer;

!help

!options

!set variable_substitution=true

!define table_name=customer

!variables

SELECT C_NAME, C_NATIONKEY, C_PHONE FROM &table_name LIMIT 10;

CREATE DATABASE demo_database;
CREATE SCHEMA demo_schema;
CREATE STAGE demo_stage;

PUT file://<path_to_users.sql> @demo_stage;

CREATE TABLE users (
id INT,
name STRING,
email STRING,
age INT
);

COPY INTO users FROM @demo_stage FILE_FORMAT = (TYPE = CSV);

SELECT * FROM users;

DROP DATABASE demo_database;