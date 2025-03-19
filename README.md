# Cyclistic Capstone - Google Data Analytics Project  

## Table of Contents
1. [Project Overview](#project-overview)  
2. [Tools Used](#tools-used)  
3. [Data Cleaning Process](#data-cleaning-process)  
4. [Key R Code Used](#key-r-code-used)  
5. [Key Findings](#key-findings)  
6. [Business Recommendations](#business-recommendations)  
7. [Project Files & Links](#project-files--links)  
8. [Contact](#contact)  

---

## **Project Overview**  
Cyclistic is a bike-share company in Chicago. The goal of this analysis is to identify key insights into **casual vs. member riders** and provide **data-driven recommendations** to increase **membership conversions**.  

This project is part of the **Google Data Analytics Professional Certificate Capstone**.  

---

## **Tools Used**  
- **R & SQL** - Data Cleaning and Analysis  
- **Tableau** - Data Visualization and Dashboard  
- **Google Sheets** - Exploratory Data Review  

---

## **Data Cleaning Process**  
The raw dataset required **extensive cleaning** before analysis. The following steps were performed:  
- **Merged 12 monthly CSV files** into a single dataset  
- **Removed duplicate entries**  
- **Standardized date and time formats**  
- **Filtered out incorrect ride durations** (negative values, extreme outliers >24 hours)  
- **Created additional features** (day_of_week, hour_of_day)  

**Full R script for cleaning and analysis:** 👉 [Cyclistic_Analysis.R](./Cyclistic_Analysis.R)  

---

## **Key R Code Used**  
The following **R code snippets** were used for data processing:  

### **Combining 12 Monthly CSV Files**
```r
# Load necessary libraries
library(tidyverse)

# Read and combine 12 monthly files
file_list <- list.files(pattern = "*.csv")
df_full <- bind_rows(lapply(file_list, read.csv))

# Remove duplicates & missing values
df_cleaned <- df_full %>%
  drop_na() %>%
  distinct()

# Convert timestamps & create new columns
df_cleaned$started_at <- as.POSIXct(df_cleaned$started_at, format="%Y-%m-%d %H:%M:%S")
df_cleaned$ended_at <- as.POSIXct(df_cleaned$ended_at, format="%Y-%m-%d %H:%M:%S")
df_cleaned$ride_length <- as.numeric(difftime(df_cleaned$ended_at, df_cleaned$started_at, units = "mins"))
df_cleaned$hour_of_day <- as.numeric(format(df_cleaned$started_at, "%H"))
df_cleaned$day_of_week <- weekdays(df_cleaned$started_at)

For the full R script, check: Cyclistic_Analysis.R

⸻

Key Findings
	•	Casual riders increase on weekends (43.9%), while members dominate weekdays (69.3%).
	•	Peak riding time for casual users is in the afternoon between 11 AM - 6 PM.
	•	Members use electric bikes more than casual users (51.5%).
	•	Trip durations are longer for casual users, averaging 18 minutes, compared to 10 minutes for members.

⸻

Business Recommendations
	1.	Weekend Membership Promotions
	•	Casual riders are most active on Fridays & Weekends (43.9%).
	•	Launch discounted weekend memberships to attract repeat users.
	2.	Targeted Digital Ads for Frequent Casual Riders
	•	Identify casual riders with frequent usage (3+ trips per month).
	•	Offer personalized promotions via email and app notifications.
	3.	“Ride & Experience” Membership Bundles
	•	Partner with cafes, museums, and entertainment venues to provide discounted experiences for members.
	•	Promote bundle packages (Bike + Coffee Discount, Bike + Museum Ticket, etc.) to casual riders.

⸻

Project Files & Links
	•	Final Report (PDF)
	•	Full R Code
	•	Tableau Dashboard

⸻

Contact

For questions, feedback, or collaboration opportunities, feel free to connect:
LinkedIn: https://www.linkedin.com/in/manuelegilu/

