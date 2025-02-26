-- 2b. What were the least busy days of the month?

SELECT DATE(transit_timestamp) AS date, SUM(ridership) AS total_ridership
FROM dec_2024_ridership
GROUP BY date
ORDER BY total_ridership ASC
LIMIT 5;
