import pandas as pd

# Load the dataset
file_path = 'mta_ridership_dec2024.csv'
df = pd.read_csv(file_path)

# Display initial data information
print("Initial Data Info:")
print(df.info())

# Convert datetime column (to catch errors in timestamp format)
df['transit_timestamp'] = pd.to_datetime(df['transit_timestamp'], errors='coerce')

# Identify and remove rows with invalid timestamps
invalid_timestamps = df['transit_timestamp'].isnull().sum()
print(f"Number of rows with invalid timestamps: {invalid_timestamps}")
if invalid_timestamps > 0:
    df = df.dropna(subset=['transit_timestamp'])

# Convert ridership to numeric (handle errors)
df['ridership'] = pd.to_numeric(df['ridership'], errors='coerce')

# Check for and remove duplicate rows
duplicates_count = df.duplicated().sum()
print(f"Number of duplicate rows: {duplicates_count}")
if duplicates_count > 0:
    df = df.drop_duplicates()

# Check for missing values in essential fields
missing_values = df[['transit_timestamp', 'ridership']].isnull().sum()
print("Missing values in essential fields:\n", missing_values)

# Remove rows with missing essential fields
if missing_values['ridership'] > 0:
    initial_row_count = len(df)
    df = df.dropna(subset=['ridership'])
    removed_rows = initial_row_count - len(df)
    print(f"Removed {removed_rows} rows with missing ridership.")

# Reset index after cleaning
df.reset_index(drop=True, inplace=True)

# Display cleaned data information
print("Cleaned Data Info:")
print(df.info())

# Save the cleaned dataset to a new CSV file
cleaned_file_path = 'cleaned_mta_ridership_dec2024.csv'
df.to_csv(cleaned_file_path, index=False)
print(f"Cleaned dataset saved as {cleaned_file_path}")
