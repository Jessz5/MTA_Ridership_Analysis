-- 4b. What day of the week saw the lowest ridership?

SELECT
    TO_CHAR(transit_timestamp, 'Day') AS day_of_week,
    SUM(ridership) AS total_ridership
FROM dec_2024_ridership
GROUP BY day_of_week
ORDER BY total_ridership ASC
LIMIT 1;
