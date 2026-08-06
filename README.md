# World-Layoffs-Project
World Layoffs Data Analysis
Project Overview

This project analyses global tech layoffs using a real-world dataset covering 1,800+ companies across 33 industries and 60 countries, spanning March 2020 to March 2023. The project is split into two parts: data cleaning and exploratory data analysis (EDA), both performed using MySQL.

The goal was to take a raw, inconsistent dataset, clean it into a reliable format, and then use SQL to uncover trends in layoffs by company, industry, country, and time period.

Data Cleaning
Steps taken to clean the raw dataset:

Created a backup table (layoffs_backup) before making any changes, to preserve the original raw data.
Identified and removed duplicate records using ROW_NUMBER() partitioned across all key columns (company, industry, location, layoffs figures, date, stage, country, funds raised), then deleted rows flagged as duplicates.
Standardised text fields — trimmed white spaces from company names and consolidated inconsistent industry naming.

Converted the date column from text to a proper DATE data type using STR_TO_DATE(), enabling accurate time-based analysis.


Exploratory Data Analysis
Key questions explored:

Identified the maximum number of employees laid off and highest percentage laid off, including companies that laid off 100% of staff. Aggregated total layoffs per company and ranked them in descending order. Grouped total layoffs by industry and by country to identify the most affected sectors and regions.
Aggregated total layoffs by year and by month to observe the overall trend across the dataset's time frame.
Used a Common Table Expression (CTE) combined with a window function (SUM() OVER ORDER BY) to calculate a rolling monthly total of layoffs across the full date range.
Used a CTE with DENSE_RANK() partitioned by year to identify the top 5 companies with the highest layoffs for each year in the dataset.
