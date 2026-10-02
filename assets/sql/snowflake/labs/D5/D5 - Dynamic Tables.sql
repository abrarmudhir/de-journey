USE ROLE ACCOUNTADMIN;

CREATE DATABASE IF NOT EXISTS dt_demo;
CREATE SCHEMA IF NOT EXISTS dt_demo.sales;
USE SCHEMA dt_demo.sales;

USE WAREHOUSE compute_wh;


-- Set up the raw source table

CREATE OR REPLACE TABLE raw_transactions (
    transaction_id      INT,
    customer_id         INT,
    product_id          INT,
    amount              FLOAT,
    status              STRING,       -- 'completed', 'refunded', 'pending'
    transaction_date    TIMESTAMP
);

INSERT INTO raw_transactions VALUES
    (1,  101, 10, 250.00,  'completed', '2024-01-15 09:00:00'),
    (2,  102, 11, 1500.00, 'completed', '2024-01-15 09:05:00'),
    (3,  103, 10, 80.00,   'completed', '2024-01-15 09:10:00'),
    (4,  101, 12, 1200.00, 'completed', '2024-01-15 09:15:00'),
    (5,  104, 11, 300.00,  'refunded',  '2024-01-15 09:20:00'),
    (6,  102, 13, 950.00,  'completed', '2024-01-15 09:25:00'),
    (7,  105, 10, 1800.00, 'completed', '2024-01-15 09:30:00'),
    (8,  103, 12, 450.00,  'pending',   '2024-01-15 09:35:00'),
    (9,  101, 11, 600.00,  'completed', '2024-01-15 09:40:00'),
    (10, 106, 13, 1100.00, 'completed', '2024-01-15 09:45:00');

SELECT * FROM raw_transactions;


-- First dynamic table: filter and clean the raw data

CREATE OR REPLACE DYNAMIC TABLE cleaned_transactions
    TARGET_LAG = '1 minute'
    WAREHOUSE = compute_wh
    REFRESH_MODE = AUTO
    INITIALIZE = ON_CREATE
AS
    SELECT
        transaction_id,
        customer_id,
        product_id,
        amount,
        transaction_date::DATE AS transaction_date
    FROM raw_transactions
    WHERE status = 'completed';

SELECT * FROM cleaned_transactions;


-- Second dynamic table: aggregate into a reporting-ready summary

CREATE OR REPLACE DYNAMIC TABLE customer_spend_summary
    TARGET_LAG = '1 minute'
    WAREHOUSE = compute_wh
    REFRESH_MODE = AUTO
    INITIALIZE = ON_CREATE
AS
    SELECT
        customer_id,
        COUNT(transaction_id)   AS total_transactions,
        SUM(amount)             AS total_spend,
        MAX(transaction_date)   AS last_transaction_date
    FROM cleaned_transactions
    GROUP BY customer_id;

SELECT * FROM customer_spend_summary
ORDER BY total_spend DESC;


-- Insert new rows and watch the pipeline respond

INSERT INTO raw_transactions VALUES
    (11, 107, 10, 2200.00, 'completed', '2024-01-15 10:00:00'),
    (12, 101, 11, 500.00,  'completed', '2024-01-15 10:05:00'),
    (13, 108, 12, 75.00,   'refunded',  '2024-01-15 10:10:00');  -- this one should be filtered out

SELECT * FROM cleaned_transactions ORDER BY transaction_id;
SELECT * FROM customer_spend_summary ORDER BY customer_id;

-- Manually trigger a refresh without waiting for the target lag
ALTER DYNAMIC TABLE cleaned_transactions REFRESH;
ALTER DYNAMIC TABLE customer_spend_summary REFRESH;


-- Monitor refresh history and current table state

SELECT *
FROM TABLE(INFORMATION_SCHEMA.DYNAMIC_TABLE_REFRESH_HISTORY(
    NAME => 'DT_DEMO.SALES.CLEANED_TRANSACTIONS'
))
ORDER BY REFRESH_START_TIME DESC;

SHOW DYNAMIC TABLES IN SCHEMA dt_demo.sales;


-- Pause and restart automated refreshes

ALTER DYNAMIC TABLE cleaned_transactions SUSPEND;
ALTER DYNAMIC TABLE customer_spend_summary SUSPEND;

SHOW DYNAMIC TABLES IN SCHEMA dt_demo.sales;

ALTER DYNAMIC TABLE cleaned_transactions RESUME;
ALTER DYNAMIC TABLE customer_spend_summary RESUME;


-- Remove all objects created in this hands-on

DROP DATABASE IF EXISTS dt_demo;
DROP WAREHOUSE IF EXISTS dt_demo_wh;