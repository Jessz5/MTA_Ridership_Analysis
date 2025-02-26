-- 8. What were the least busy stations?

SELECT station_complex, SUM(ridership) AS total_ridership
FROM dec_2024_ridership
GROUP BY station_complex
ORDER BY total_ridership ASC
LIMIT 10;
