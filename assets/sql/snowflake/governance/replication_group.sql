-- On the primary account
CREATE REPLICATION GROUP claro_replication_group
    OBJECT_TYPES = DATABASES
    ALLOWED_DATABASES = claro_db, claro_users_db
    ALLOWED_ACCOUNTS = claro.eu_west;

-- On the secondary account
CREATE REPLICATION GROUP claro_replication_group
    AS REPLICA OF claro.us_east.claro_replication_group;

-- Trigger a refresh
ALTER REPLICATION GROUP claro_replication_group REFRESH;