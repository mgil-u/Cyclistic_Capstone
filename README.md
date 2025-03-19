# Cyclistic Capstone - Google Data Analytics Project  

## Project Overview  
Cyclistic is a bike-share company in Chicago. The goal of this analysis is to identify key insights into casual vs. member riders and provide data-driven recommendations to increase membership conversions.  

## Tools Used  
- R and SQL (Data Cleaning and Analysis)  
- Tableau (Visualizations and Dashboard)  
- Google Sheets (Data Storage)  

## Data Cleaning Process  
The raw dataset required extensive cleaning before analysis. The following steps were performed:  
- Removed duplicate entries  
- Standardized date and time formats  
- Filtered out incorrect ride durations (negative values, extreme outliers above 24 hours)  
- Created additional features, including day of the week and hour of the day for analysis  

Full R script for cleaning and analysis: [Cyclistic_Analysis.R](./Cyclistic_Analysis.R)  

## Key R Code Used  

# Load necessary libraries
library(tidyverse)

# Read and combine 12 monthly files
file_list <- list.files(pattern = "*.csv")
df_full <- bind_rows(lapply(file_list, read.csv))

# Filter and clean data
df_cleaned <- df_full %>%
  filter(ride_length > 0 & ride_length < 1440) %>% 
  drop_na()
For the full code, check: Cyclistic_Analysis.R

Key Findings
	•	Casual riders increase on weekends (43.9%), while members dominate weekdays (69.3%).
	•	Peak riding time for casual users is in the afternoon between 11 AM and 6 PM.
	•	Members use electric bikes more than casual users (51.5 percent).
	•	Trip durations are longer for casual users, averaging 18 minutes, compared to 10 minutes for members.

Business Recommendations
	1.	Implement weekend membership promotions to convert casual riders.
	2.	Launch targeted digital ads for frequent casual riders.
	3.	Partner with cafes, museums, and entertainment venues to offer discounts for members.

