-- 2a. What were the busiest days of the month?

SELECT DATE(transit_timestamp) AS date, SUM(ridership) AS total_ridership
FROM dec_2024_ridership
GROUP BY date
ORDER BY total_ridership DESC
LIMIT 5;
