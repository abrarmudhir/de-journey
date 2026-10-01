/*----------------D1 Multi-factor Authentication (MFA) Hands-on----------------
1) Authentication Policies
2) MFA Enrollment & Methods
3) MFA Recovery (ENROLL MFA, MINS_TO_BYPASS_MFA)
----------------------------------------------*/

-- ========== 1) Authentication Policies ==========

--  See which policy is set at the account level
SHOW AUTHENTICATION POLICIES ON ACCOUNT;

--  Create database and schema for the policy
CREATE DATABASE IF NOT EXISTS SECURITY;
CREATE SCHEMA IF NOT EXISTS SECURITY.POLICIES;

-- Create an authentication policy with desired MFA settings
CREATE OR REPLACE AUTHENTICATION POLICY SECURITY.POLICIES.MY_MFA_POLICY
  -- MFA_ENROLLMENT = REQUIRED | REQUIRED_PASSWORD_ONLY | OPTIONAL
  MFA_ENROLLMENT = REQUIRED_PASSWORD_ONLY
  MFA_POLICY = (ALLOWED_METHODS = ('PASSKEY', 'TOTP' ));

--  List all authentication policies in the account
SHOW AUTHENTICATION POLICIES;

--  Describe the policy to view MFA settings (MFA_ENROLLMENT, ALLOWED_METHODS, etc.)
DESCRIBE AUTHENTICATION POLICY MY_MFA_POLICY;

-- Apply the policy at account level (all users)

-- ALTER ACCOUNT SET AUTHENTICATION POLICY MY_MFA_POLICY;

-- Apply policy to individual USER

-- Create user
CREATE OR REPLACE USER MARTINA 
PASSWORD='temp' 
DEFAULT_ROLE = PUBLIC 
DEFAULT_WAREHOUSE='COMPUTE_WH' 
TYPE = PERSON;

-- Apply to a specific user
ALTER USER MARTINA SET AUTHENTICATION POLICY MY_MFA_POLICY;

-- ========== 2) MFA Enrollment & Methods ==========

--  Log out and setup a TOTP, then come back here

-- Inspect MFA settings for a user
SHOW MFA METHODS FOR USER MARTINA;

-- ========== 3) MFA Recovery (ENROLL MFA, MINS_TO_BYPASS_MFA) ==========

-- Permanently remove MFA for a user (use method name from SHOW MFA METHODS)
ALTER USER MARTINA REMOVE MFA METHOD TOTP_OCBP;

-- To unlock use the ENROLL MFA recovery procedure
ALTER USER MARTINA ENROLL MFA;

-- Temporarily disable MFA for a user (30 minutes)
ALTER USER MARTINA SET MINS_TO_BYPASS_MFA = 30;

-- Remove authentication policy from user or account
ALTER USER MARTINA UNSET AUTHENTICATION POLICY;


-- Clear-down lesson objects
DROP USER MARTINA; 
DROP DATABASE SECURITY;