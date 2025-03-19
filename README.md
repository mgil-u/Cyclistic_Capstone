# 🚴‍♂️ Cyclistic Capstone - Google Data Analytics Project  

## 📌 Project Overview  
Cyclistic is a bike-share company in Chicago. The goal of this analysis is to identify key insights into casual vs. member riders and provide data-driven recommendations to increase membership conversions.  

## 📊 Tools Used  
- **R & SQL** (Data Cleaning & Analysis)  
- **Tableau** (Visualizations & Dashboard)  
- **Google Sheets** (Data Storage)  

## 🔍 Data Cleaning Process  
The raw dataset required extensive cleaning before analysis. The following steps were performed:  
✔ Removed duplicate entries  
✔ Standardized date & time formats  
✔ Filtered out incorrect ride durations (negative values, extreme outliers >24 hours)  
✔ Created additional features (day_of_week, hour_of_day) for analysis  

📌 **Full R script for cleaning & analysis:** 👉 [Cyclistic_Analysis.R](./Cyclistic_Analysis.R)  

## 🚀 Key R Code Used  
```r
# Load necessary libraries
library(tidyverse)

# Read and combine 12 monthly files
file_list <- list.files(pattern = "*.csv")
df_full <- bind_rows(lapply(file_list, read.csv))

# Filter and clean data
df_cleaned <- df_full %>%
  filter(ride_length > 0 & ride_length < 1440) %>% 
  drop_na()
