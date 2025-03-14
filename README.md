## MTA December 2024 Ridership Analysis

This project analyzes MTA data from December 2024 to uncover trends in peak travel times, station activity, and commuting patterns throughout the holiday season. By analyzing key metrics such as ridership by borough, busiest stations, and holiday impacts, this study provides actionable insights for the MTA, local businesses, and commuters.

The analysis is based on the [MTA Subway Hourly Ridership (2020-2024)](https://data.ny.gov/Transportation/MTA-Subway-Hourly-Ridership-2020-2024/wujg-7c2s/about_data) dataset, available on DATA.NY.GOV, which includes detailed information on ridership counts, station complexes, boroughs, and timestamps.

 **SQL queries and Python scripts:** Explore the code behind the analysis in the [project_sql folder](/project_sql/) and [project_python folder](/project_python/).

## Key Questions
Here are the key questions explored through data analysis:

1. What was the total ridership for December 2024?
2. What were the busiest and least busy days of the month?
3. How does weekday ridership compare to weekends?
4. What day of the week saw the highest and lowest ridership?
5. How does ridership vary by borough (Manhattan, Brooklyn, Queens, Bronx, Staten Island)?
6. What were the peak vs. off-peak hours for subway usage?
7. What were the top 10 busiest subway stations in December?
8. What were the least busy stations?
9. How did ridership change around Christmas (Dec 25) and New Year's Eve (Dec 31)?
10. Which stations had the biggest increase in ridership leading up to the holidays (comparing mid-December to pre-holiday periods)?

## Tools I Used
For this project, I leveraged the following tools and technologies:
- **Python:** Created scripts for fetching and cleaning MTA Subway Hourly Ridership data—one script fetches data from the [API](https://data.ny.gov/resource/wujg-7c2s.json) and saves it as a CSV, while the other cleans it by correcting timestamps, removing duplicates, and handling missing values.
- **SQL (PostgreSQL):** Built a PostgreSQL database to store the dataset and wrote SQL queries to analyze ridership trends.
- **Visual Studio Code:** Used as the primary IDE for writing, executing, and managing project files.
- **Git & GitHub:** Implemented version control using Git to track changes in code and SQL queries. The project repository is hosted on GitHub for easy sharing and collaboration.
- **Tableau Public:** Created visualizations and combined them into a single dashboard to effectively communicate ridership trends and insights.

## The Analysis
Each query was designed to answer specific questions about MTA ridership in December 2024. Below is a breakdown of the analysis:

### 1. Total Ridership in December 2024

```sql
SELECT SUM(ridership) AS total_ridership
FROM dec_2024_ridership;
```

In December 2024, the MTA subway system recorded a total ridership of **97,422,983 rides**.

### 2. Busiest and Least Busy Days
```sql
-- Busiest days
SELECT DATE(transit_timestamp) AS date, SUM(ridership) AS total_ridership
FROM dec_2024_ridership
GROUP BY date
ORDER BY total_ridership DESC
LIMIT 5;

--Least busy days
SELECT DATE(transit_timestamp) AS date, SUM(ridership) AS total_ridership
FROM dec_2024_ridership
GROUP BY date
ORDER BY total_ridership ASC
LIMIT 5;
```

The busiest days in December 2024, based on total ridership, were:
* **2024-12-04**: 4,410,504 rides
* **2024-12-10**: 4,386,308 rides
* **2024-12-18**: 4,336,726 rides
* **2024-12-13**: 4,211,534 rides
* **2024-12-17**: 4,179,662 rides

The least busy days, based on ridership, were:
* **2024-12-25**: 1,406,821 rides
* **2024-12-08**: 1,835,451 rides
* **2024-12-01**: 1,908,324 rides
* **2024-12-22**: 2,074,407 rides
* **2024-12-29**: 2,131,916 rides

### 3. Weekday vs. Weekend Ridership
```sql
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
```

On average, **3.49 million rides** were taken on weekdays, compared to **2.30 million rides** on weekends. This represents a **52% higher ridership on weekdays**, highlighting the subway’s role as a primary mode of transportation for work and school-related commutes.

### 4. Highest and Lowest Ridership Days of the Week
```sql
--Highest ridership day
SELECT
    TO_CHAR(transit_timestamp, 'Day') AS day_of_week,
    SUM(ridership) AS total_ridership
FROM dec_2024_ridership
GROUP BY day_of_week
ORDER BY total_ridership DESC
LIMIT 1;

--Lowest ridership day
SELECT
    TO_CHAR(transit_timestamp, 'Day') AS day_of_week,
    SUM(ridership) AS total_ridership
FROM dec_2024_ridership
GROUP BY day_of_week
ORDER BY total_ridership ASC
LIMIT 1;
```

**Highest Ridership Day:** Tuesday, with **17,779,637 rides.**<br>
**Lowest Ridership Day:** Sunday, with **10,298,821 rides.**

### 5. Ridership by Borough
```sql
SELECT borough, SUM(ridership) AS total_ridership
FROM dec_2024_ridership
GROUP BY borough
ORDER BY total_ridership DESC;
```

Ridership across New York City’s boroughs revealed significant disparities, with Manhattan dominating subway usage:
* **Manhattan:** 55,933,124 rides
* **Brooklyn:** 20,898,378 rides
* **Queens:** 14,083,425 rides
* **Bronx:** 6,339,357 rides
* **Staten Island:** 168,699 rides

**Manhattan** saw **55,933,124 rides**, accounting for over **57% of total subway ridership**, highlighting its central role as a hub for work, tourism, and commerce.

### 6. Peak vs. Off-Peak Hours
```sql
SELECT EXTRACT(HOUR FROM transit_timestamp) AS hour, SUM(ridership) AS total_ridership
FROM dec_2024_ridership
GROUP BY hour
ORDER BY total_ridership DESC;
```

**Morning Rush Hours:**
* 8 AM: 6,776,808 rides
* 7 AM: 5,746,532 rides
* 9 AM: 5,246,062 rides

**Afternoon/Evening Rush Hours:**
* 5 PM: 9,058,724 rides
* 4 PM: 8,346,360 rides
* 3 PM: 7,717,297 rides
* 6 PM: 6,974,394 rides

**Early Morning Hours:**
* 3 AM: 211,212 rides
* 2 AM: 223,233 rides
* 1 AM: 406,157 rides
* 4 AM: 462,751 rides

The busiest periods were the morning rush hours (7 AM–9 AM) and afternoon/evening rush hours (3 PM–6 PM), with ridership peaking at 8 AM and 5 PM. In contrast, the lowest ridership occurred during the early morning hours (1 AM–4 AM).

### 7. Top 10 Busiest Stations
```sql
SELECT station_complex, SUM(ridership) AS total_ridership
FROM dec_2024_ridership
GROUP BY station_complex
ORDER BY total_ridership DESC
LIMIT 10;
```

The top 10 busiest subway stations in December 2024 were:
1. Times Sq-42 St (N,Q,R,W,S,1,2,3,7)/42 St (A,C,E)
2. Grand Central-42 St (S,4,5,6,7)
3. 34 St-Herald Sq (B,D,F,M,N,Q,R,W)
4. 14 St-Union Sq (L,N,Q,R,W,4,5,6)
5. 34 St-Penn Station (A,C,E)
6. Fulton St (A,C,J,Z,2,3,4,5)
7. 34 St-Penn Station (1,2,3)
8. 47-50 Sts-Rockefeller Ctr (B,D,F,M)
9. 59 St-Columbus Circle (A,B,C,D,1)
10. Flushing-Main St (7)

These stations are major transit hubs, serving as key connectors for commuters and tourists.

### 8. Least Busy Stations
```sql
SELECT station_complex, SUM(ridership) AS total_ridership
FROM dec_2024_ridership
GROUP BY station_complex
ORDER BY total_ridership ASC
LIMIT 10;
```

The least busy subway stations in December 2024 were:
1. Beach 105 St (A,S)
2. Broad Channel (A,S)
3. Beach 98 St (A,S)
4. Beach 90 St (A,S)
5. Rockaway Park-Beach 116 St (A,S)
6. Beach 36 St (A)
7. Tompkinsville (SIR)
8. Cypress Hills (J)
9. Aqueduct Racetrack (A)
10. Beach 44 St (A)

These stations are located in less densely populated areas.

### 9. Ridership Around Christmas and New Year's Eve
```sql
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
```

Ridership dropped significantly on **Christmas Day**, with a **55% decrease** compared to the daily average, reflecting the impact of holiday closures and reduced commuting.

|    Date    | Total Ridership | Percent Change |
|------------|-----------------|---------------:|
| 2024-12-23 | 3,055,215       | -2.78          |
| 2024-12-24 | 2,584,746       | -17.75         |
| 2024-12-25 | 1,406,821       | -55.23         |
| 2024-12-29 | 2,131,916       | -32.16         |
| 2024-12-30 | 3,361,833       |  6.97          |
| 2024-12-31 | 2,897,552       | -7.80          |

### 10. Stations with the Biggest Ridership Increase Leading Up to the Holidays
```sql
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
```

The top stations with the biggest increase in ridership from mid-December to pre-holiday periods were:
1. Times Sq-42 St (N,Q,R,W,S,1,2,3,7)/42 St (A,C,E)
2. 34 St-Herald Sq (B,D,F,M,N,Q,R,W)
3. Flushing-Main St (7)
4. 47-50 Sts-Rockefeller Ctr (B,D,F,M)
5. 34 St-Penn Station (1,2,3)
6. 59 St-Columbus Circle (A,B,C,D,1)
7. 34 St-Penn Station (A,C,E)
8. 14 St-Union Sq (L,N,Q,R,W,4,5,6)
9. Fulton St (A,C,J,Z,2,3,4,5)
10. Grand Central-42 St (S,4,5,6,7)

These stations likely saw increased traffic due to holiday shopping, tourism, and year-end events.

## Tableau Dashboard
<img src="MTA Ridership Dashboard.png" style="width: 30%; height: 30%; max-width: none; display: block;">

[View Dashboard on Tableau Public](https://public.tableau.com/views/MTASubwayRidershipDecember2024/Dashboard?:language=en-US&:sid=&:redirect=auth&:display_count=n&:origin=viz_share_link)

## Conclusion
This analysis of MTA ridership data for December 2024 offers valuable insights into how New Yorkers and visitors navigate the city during the holiday season. Key findings include:

* **Total Ridership:** Over **97 million rides** were taken on the subway in December 2024.
* **Busiest Days:** Tuesdays had the highest overall ridership in December, with Wednesday, **December 4th**, being the single busiest day.
* **Weekday vs. Weekend Ridership:** Weekdays averaged **3.49 million rides per day**, compared to **2.30 million rides** on weekends.
* **Borough Trends:** **Manhattan** dominated ridership, accounting for over **57% of total ridership**, followed by **Brooklyn** and **Queens**. **Staten Island** had the lowest ridership, consistent with its smaller subway network.
* **Peak Hours:** Morning rush hours (**7 AM - 9 AM**) and afternoon/evening rush hours (**3 PM - 6 PM**) were the busiest, with 8 AM and 5 PM being the peak times, while early morning hours (**1 AM - 4 AM**) saw the lowest ridership.
* **Station Activity:** Major transit hubs like **Times Square** and **Grand Central** were the busiest, while stations in less densely populated areas saw minimal activity.
* **Holiday Impact:** Ridership dropped significantly on **Christmas Day**, with a **55% decrease** compared to the daily average. New Year's Eve also saw a 7.8% decrease, reflecting reduced commuting during major holidays.
* **Pre-Holiday Ridership Trends:** In the days leading up to the holidays, ridership at stations like **Times Square** and **34 St-Herald Sq** increased, likely due to holiday shopping and tourism.

## Business Impact
These insights provide actionable recommendations for the **MTA**, **businesses**, and **commuters**:

#### For the MTA:
* **Optimize Train Schedules:** Increase frequency during rush hours (**7 AM - 9 AM**) & (**3 PM - 6 PM**) and reduce service during early morning hours (**1 AM - 4 AM**) to improve operational efficiency.
* **Resource Allocation:** Focus staffing and maintenance efforts on high-traffic stations like **Times Square** and **Grand Central**.
* **Holiday Planning:** Adjust schedules during holidays (e.g., **Christmas Day and New Year's Eve**) to better align with lower ridership.

#### For Businesses:
* **Marketing:** Run promotions near busy stations (e.g., **Times Square**) during peak hours to attract commuters.
* **Staffing:** Schedule more staff during pre-holiday periods to handle increased customer traffic.
* **Location Strategy:** Use ridership data to identify high-traffic areas for new business opportunities or pop-up events, particularly during the holiday season.

#### For Commuters:
* **Travel Planning:** If possible, avoid rush hours (**7 AM - 9 AM and 3 PM - 6 PM**) to reduce congestion and plan trips during low-ridership periods (e.g., late mornings or early afternoons) for a more comfortable experience.
