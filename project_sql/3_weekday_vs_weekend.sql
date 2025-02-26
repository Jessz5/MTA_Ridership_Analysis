-- 3. How does weekday ridership compare to weekends?

WITH daily_totals AS (
    SELECT
        DATE(transit_timestamp) AS date,
        SUM(ridership) AS daily_ridership
    FROM dec_2024_ridership
    GROUP BY date
)

SELECT
    CASE
        WHEN EXTRACT(DOW FROM date) IN (0, 6) THEN 'Weekend'
        ELSE 'Weekday'
    END AS day_type,
    AVG(daily_ridership) AS avg_ridership_per_day
FROM daily_totals
GROUP BY day_type;
