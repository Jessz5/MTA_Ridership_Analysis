-- 3. How does weekday ridership compare to weekends?

SELECT
    CASE
        WHEN EXTRACT(DOW FROM transit_timestamp) IN (0,6) THEN 'Weekend'
        ELSE 'Weekday'
    END AS day_type,
    SUM(ridership) AS total_ridership
FROM dec_2024_ridership
GROUP BY day_type;
