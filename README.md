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
- Query_Steps_for_data_cleaning.sql
- Cleaned_Dataset.csv
- Uncleaned_Dataset.csv
- SQL_Queries.sql
- Uncleaned_Queries.sql
- churn_cleaned_dataset.png

##  Learning Outcomes:
-	Mastered MySQL query writing and data handling
- Gained hands-on experience in cleaning and analyzing real-world datasets
-	Strengthened skills for data analytics and database management roles

##  References:






