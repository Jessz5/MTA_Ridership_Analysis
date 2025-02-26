-- Use the \copy command for loading data when working in psql or pgAdmin locally.
-- This allows access to local file paths even if the PostgreSQL server is remote.
--\copy dec_2024_ridership FROM '/path/to/cleaned_mta_ridership_dec2024.csv' WITH (FORMAT csv, HEADER true, DELIMITER ',', ENCODING 'UTF8');

-- The COPY command should be used when the file is located on the server where PostgreSQL is running.
-- The following COPY command assumes the file is accessible from the server's file system.
COPY dec_2024_ridership
FROM '/path/to/cleaned_mta_ridership_dec2024.csv'
WITH (FORMAT csv, HEADER true, DELIMITER ',', ENCODING 'UTF8');
