# Cyclistic Capstone - Data Analysis in R
# Google Data Analytics Professional Certificate Capstone Project

# Step 1: Load Required Libraries
library(tidyverse)

# Step 2: Set Working Directory (Modify the Path Based on Your System)
setwd("/Users/manuel/Documents/Data Analysis/Projects/Google Data Analytics Native Capstone/Cyclistic_Trip_Data")

# Step 3: Read & Combine 12 Monthly Files
# List all CSV files in the directory
file_list <- list.files(pattern = "*.csv")

# Read all CSVs and combine them into one dataframe
df_list <- lapply(file_list, read.csv)
df_full <- bind_rows(df_list)

# Step 4: Save Combined Dataset (Cyclistic Full Data)
write.csv(df_full, "Cyclistic_Full_Data.csv", row.names = FALSE)

# Step 5: Inspect Data
str(df_full)    # Check structure
head(df_full)   # View first few rows
summary(df_full) # Get summary statistics

# Step 6: Data Cleaning (Cyclistic Cleaned Data)
# Remove missing values
df_cleaned <- df_full %>%
  drop_na()

# Remove duplicate ride entries
df_cleaned <- df_cleaned %>%
  distinct()

# Convert date-time columns to correct format
df_cleaned$started_at <- as.POSIXct(df_cleaned$started_at, format="%Y-%m-%d %H:%M:%S")
df_cleaned$ended_at <- as.POSIXct(df_cleaned$ended_at, format="%Y-%m-%d %H:%M:%S")

# Create additional time-based features
df_cleaned$ride_length <- as.numeric(difftime(df_cleaned$ended_at, df_cleaned$started_at, units = "mins"))
df_cleaned$hour_of_day <- format(df_cleaned$started_at, "%H") %>% as.numeric()
df_cleaned$day_of_week <- weekdays(df_cleaned$started_at)

# Remove rides with negative or extreme ride durations (>24 hours)
df_cleaned <- df_cleaned %>%
  filter(ride_length > 0 & ride_length < 1440)

# Convert day_of_week into an ordered factor for better analysis
df_cleaned$day_of_week <- factor(df_cleaned$day_of_week, 
                                 levels = c("Monday", "Tuesday", "Wednesday", "Thursday", "Friday", "Saturday", "Sunday"))

# Step 7: Save Cleaned Dataset
write.csv(df_cleaned, "Cyclistic_Cleaned.csv", row.names = FALSE)

# Step 8: Descriptive Analysis
# Count total rides by user type
trip_distribution <- df_cleaned %>%
  group_by(member_casual) %>%
  summarise(total_trips = n(),
            avg_trip_duration = mean(ride_length, na.rm = TRUE))

# Count trips by day of the week
trip_by_day <- df_cleaned %>%
  group_by(day_of_week, member_casual) %>%
  summarise(total_trips = n()) %>%
  mutate(percentage = (total_trips / sum(total_trips)) * 100)

# Step 9: Exploratory Analysis - Casual vs. Member Users
# Compare total trip distribution for weekdays vs. weekends
weekdays_df <- df_cleaned %>% filter(day_of_week %in% c("Monday", "Tuesday", "Wednesday", "Thursday"))
weekends_df <- df_cleaned %>% filter(day_of_week %in% c("Friday", "Saturday", "Sunday"))

trip_counts_weekdays <- weekdays_df %>%
  group_by(member_casual) %>%
  summarise(total_trips = n()) %>%
  mutate(percentage = (total_trips / sum(total_trips)) * 100)

trip_counts_weekends <- weekends_df %>%
  group_by(member_casual) %>%
  summarise(total_trips = n()) %>%
  mutate(percentage = (total_trips / sum(total_trips)) * 100)

# Step 10: Business Insights - Time of Day Analysis
# Compare Ride Distribution by Time of Day (9 PM - 4 AM vs. Rest of the Day)
late_night_df <- df_cleaned %>% filter(hour_of_day >= 21 | hour_of_day < 5)
day_evening_df <- df_cleaned %>% filter(hour_of_day >= 5 & hour_of_day < 21)

trip_counts_late_night <- late_night_df %>%
  group_by(member_casual) %>%
  summarise(total_trips = n()) %>%
  mutate(percentage = (total_trips / sum(total_trips)) * 100)

trip_counts_day_evening <- day_evening_df %>%
  group_by(member_casual) %>%
  summarise(total_trips = n()) %>%
  mutate(percentage = (total_trips / sum(total_trips)) * 100)

# Step 11: Bike Type Usage by Casual Riders (Weekdays vs. Weekends)
# Filter only casual riders
casual_weekdays_df <- weekdays_df %>% filter(member_casual == "casual")
casual_weekends_df <- weekends_df %>% filter(member_casual == "casual")

# Count bike type usage for weekdays
bike_type_weekdays <- casual_weekdays_df %>%
  group_by(rideable_type) %>%
  summarise(total_rides = n()) %>%
  mutate(percentage = (total_rides / sum(total_rides)) * 100)

# Count bike type usage for weekends
bike_type_weekends <- casual_weekends_df %>%
  group_by(rideable_type) %>%
  summarise(total_rides = n()) %>%
  mutate(percentage = (total_rides / sum(total_rides)) * 100)

# Step 12: Average Trip Duration for Members (Overall & 10 AM - 3 PM)
avg_duration_members_overall <- df_cleaned %>%
  filter(member_casual == "member") %>%
  summarise(avg_duration_minutes = mean(ride_length, na.rm = TRUE))

avg_duration_members_10to3 <- df_cleaned %>%
  filter(member_casual == "member" & hour_of_day >= 10 & hour_of_day < 15) %>%
  summarise(avg_duration_minutes = mean(ride_length, na.rm = TRUE))

# Step 13: Print Results
print(trip_distribution)
print(trip_by_day)
print(trip_counts_weekdays)
print(trip_counts_weekends)
print(trip_counts_late_night)
print(trip_counts_day_evening)
print(bike_type_weekdays)
print(bike_type_weekends)
print(avg_duration_members_overall)
print(avg_duration_members_10to3)

# End of Analysis