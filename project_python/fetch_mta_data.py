import pandas as pd
import requests
import time

# API Endpoint
base_url = "https://data.ny.gov/resource/wujg-7c2s.json"

# Parameters
limit = 1000  # Max rows per request
offset = 0  # Start offset
all_data = []

# Date range filter (>= December 1, 2024)
date_filter = "$where=transit_timestamp >= '2024-12-01T00:00:00'"

while True:
    query_url = f"{base_url}?{date_filter}&$limit={limit}&$offset={offset}"
    response = requests.get(query_url)

    if response.status_code != 200:
        print(f"Error fetching data: {response.status_code}")
        break

    data = response.json()

    if not data:
        break  # Stop when no more data is returned

    all_data.extend(data)
    offset += limit  # Move to the next batch

    print(f"Fetched {len(data)} rows, offset now at {offset}")

    time.sleep(1)  # Avoid overwhelming the API

# Convert to DataFrame
df = pd.DataFrame(all_data)
print(f"Total rows fetched: {len(df)}")

# Save to CSV
df.to_csv("mta_ridership_dec2024.csv", index=False)
print("Dataset saved as mta_ridership_dec2024.csv")
