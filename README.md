#  E-Commerce Customer Churn Analysis (MySQL Project)

##  Overview 
This project focuses on cleaning and exploring a raw e-commerce customer dataset using MySQL.
It involves solving 18 analytical queries to prepare the data for churn analysis and future visualization.

## Objective:
To transform an uncleaned customer dataset into a structured, consistent format by handling missing values, 
correcting inconsistencies, and creating new columns. 
The goal is to identify churn patterns and support business decisions for customer retention.

##  Dataset Details:
-	Source: Provided by course instructor
-	Size: 5,642 rows × 20 columns (original)
-	Cleaned: 5,628 rows × 21 columns
-	Key Columns: Customer ID, Tenure, Satisfaction Score, Preferred Order Category,
  Hour Spent on App, Churn Status, Complaint Received, etc.

##  Data Preprocessing Steps:
-	Imputed missing values using AVG () and MODE
-	Removed outliers from “Warehouse to Home”
-	Standardized inconsistent entries (example “COD” → “Cash on Delivery”)
-	Renamed columns for clarity
-	Created new columns: Churn Status, Complaint Received, Distance
-	Dropped redundant columns: Churn, Complain

##  Data Exploration:
18 MySQL queries were used to analyze churn behavior, 
customer preferences and cashback trends.
Examples include:
- Average tenure of churned customers
- Top 3 order categories by cashback
-	City tier with highest churn for specific categories

##  Project Structure:
- README.md
- Project_Report.docx
- Queries_of_Data_preprocessing_and_exploration.sql
- Cleaned_Dataset.zip
- Queries_of_Uncleaned_dataset.sql
- churn_cleaned_dataset.png

##  Learning Outcomes:
-	Mastered MySQL query writing and data handling
- Gained hands-on experience in cleaning and analyzing real-world datasets
-	Strengthened skills for data analytics and database management roles

##  References:
Steps in data cleaning and exploration:
https://drive.google.com/file/d/1hSpaBnyamhp3O-n1CUa8nbUvmsySqxNs/view?usp=drive_link

cleaned dataset csv file:
https://drive.google.com/file/d/1DTdhh_iiZi1fevlKcVgwVA5cB0yi5EVt/view?usp=drive_link







