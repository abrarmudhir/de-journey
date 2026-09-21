CREATE OR REPLACE FUNCTION logistics.delivery_tier(delivery_days NUMBER)
RETURNS VARCHAR
LANGUAGE SQL
AS
$$
    CASE
        WHEN delivery_days <= 3 THEN 'Fast'
        WHEN delivery_days <= 7 THEN 'Standard'
        ELSE 'Slow'
    END
$$;