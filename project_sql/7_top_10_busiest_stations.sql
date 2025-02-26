-- 7. What were the top 10 busiest subway stations in December?

SELECT station_complex, SUM(ridership) AS total_ridership
FROM dec_2024_ridership
GROUP BY station_complex
ORDER BY total_ridership DESC
LIMIT 10;
