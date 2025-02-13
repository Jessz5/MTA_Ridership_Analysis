-- 3. How does weekday ridership compare to weekends?

SELECT
    day_type,
    AVG(daily_ridership) AS avg_ridership_per_day
FROM (
    SELECT
        DATE(transit_timestamp) AS date,
        CASE
            WHEN EXTRACT(DOW FROM transit_timestamp) IN (0,6) THEN 'Weekend'
            ELSE 'Weekday'
        END AS day_type,
        SUM(ridership) AS daily_ridership
    FROM dec_2024_ridership
    GROUP BY DATE(transit_timestamp), day_type
) AS daily_totals
GROUP BY day_type;
