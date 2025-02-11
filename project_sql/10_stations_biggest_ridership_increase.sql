-- 10. Which stations had the biggest increase in ridership leading up to the holidays (comparing mid-December to pre-holiday periods)?

WITH top_stations AS (
    SELECT * FROM dec_2024_ridership
    WHERE station_complex IN (
        'Times Sq-42 St (N,Q,R,W,S,1,2,3,7)/42 St (A,C,E)', 'Grand Central-42 St (S,4,5,6,7)', '34 St-Herald Sq (B,D,F,M,N,Q,R,W)',
        '14 St-Union Sq (L,N,Q,R,W,4,5,6)', '34 St-Penn Station (A,C,E)', 'Fulton St (A,C,J,Z,2,3,4,5)',
        '34 St-Penn Station (1,2,3)', '47-50 Sts-Rockefeller Ctr (B,D,F,M)',
        '59 St-Columbus Circle (A,B,C,D,1)', 'Flushing-Main St (7)'
    )
),
mid_december AS (
    SELECT
        station_complex,
        SUM(ridership) AS mid_december_ridership
    FROM top_stations
    WHERE DATE(transit_timestamp) BETWEEN '2024-12-10' AND '2024-12-16'
    GROUP BY station_complex
),
pre_holiday AS (
    SELECT
        station_complex,
        SUM(ridership) AS pre_holiday_ridership
    FROM top_stations
    WHERE DATE(transit_timestamp) BETWEEN '2024-12-17' AND '2024-12-24'
    GROUP BY station_complex
)
SELECT
    pre_holiday.station_complex,
    mid_december_ridership,
    pre_holiday_ridership,
    (pre_holiday_ridership - mid_december_ridership) AS ridership_increase
FROM pre_holiday
JOIN mid_december ON pre_holiday.station_complex = mid_december.station_complex
ORDER BY ridership_increase DESC;
