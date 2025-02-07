-- Create dec_2024_ridership table
CREATE TABLE dec_2024_ridership (
    transit_timestamp TIMESTAMP,
    transit_mode VARCHAR(50),
    station_complex_id VARCHAR(50),
    station_complex VARCHAR(255),
    borough VARCHAR(50),
    payment_method VARCHAR(50),
    fare_class_category VARCHAR(50),
    ridership NUMERIC(10,1),
    transfers NUMERIC(10,1),
    latitude NUMERIC(9,6),
    longitude NUMERIC(9,6),
    georeference TEXT
);
