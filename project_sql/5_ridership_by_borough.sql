-- 5. How does ridership vary by borough (Manhattan, Brooklyn, Queens, Bronx, Staten Island)?

SELECT borough, SUM(ridership) AS total_ridership
FROM dec_2024_ridership
GROUP BY borough
ORDER BY total_ridership DESC;
