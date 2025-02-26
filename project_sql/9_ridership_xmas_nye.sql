-- 9. How did ridership change around Christmas (Dec 25) and New Year's Eve (Dec 31)?

WITH daily_totals AS (
    SELECT
        DATE(transit_timestamp) AS date,
        SUM(ridership) AS total_ridership
    FROM dec_2024_ridership
    GROUP BY DATE(transit_timestamp)
),
avg_ridership AS (
    SELECT AVG(total_ridership) AS avg_daily_ridership FROM daily_totals
)
SELECT
    date,
    total_ridership,
    avg_daily_ridership,
    ROUND((total_ridership - avg_daily_ridership) / avg_daily_ridership * 100, 2) AS percent_change
FROM daily_totals
CROSS JOIN avg_ridership
WHERE date IN ('2024-12-23', '2024-12-24', '2024-12-25', '2024-12-29', '2024-12-30', '2024-12-31')
ORDER BY date;
