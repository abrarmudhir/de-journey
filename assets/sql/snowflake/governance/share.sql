CREATE SHARE claro_credit_risk_share;

GRANT USAGE ON DATABASE credit_risk_db
TO SHARE claro_credit_risk_share;

GRANT USAGE ON SCHEMA credit_risk_db.analytics
TO SHARE claro_credit_risk_share;

GRANT SELECT ON TABLE credit_risk_db.analytics.risk_summary
TO SHARE claro_credit_risk_share;

ALTER SHARE claro_credit_risk_share
ADD ACCOUNTS = partner_bank.eu_west;