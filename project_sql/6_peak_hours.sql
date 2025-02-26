-- 6. What were the peak vs. off-peak hours for subway usage?

SELECT EXTRACT(HOUR FROM transit_timestamp) AS hour, SUM(ridership) AS total_ridership
FROM dec_2024_ridership
GROUP BY hour
ORDER BY total_ridership DESC;
