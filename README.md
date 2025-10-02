# Walmart Sales Analysis
### Project Overview

This project analyzes Walmart sales data to uncover insights into sales performance, customer behavior, and payment trends. The analysis involves data cleaning, SQL queries for business questions, and Power BI visualizations.

[Dashboard screenshot](PNG)

![Screenshot 2025-05-16 154148](https://github.com/user-attachments/assets/3c691410-ec8f-47d0-9048-99ff8e33f910)


### Data Sources

Walmart_Sales Data: The primary dataset used for this analysis is the "walmart.csv" file, containing detailed information about each sales made by the company.


### Tools
- Python notebook - Data cleaning
- Mysql - data analysis
- Power BI - Visual report


 ### Data Processing Steps

#### Explore the Data
Goal: Conduct an initial data exploration to understand data distribution, check column names, types, and identify potential issues.
Analysis: Use functions like .info(), .describe(), and .head() to get a quick overview of the data structure and statistics.
 
#### Data Cleaning (Python)
1. Duplicate Handling: Identified and removed 51 duplicate records using "df.drop_duplicates()"

2. Null Value Treatment - "df.dropna(inplace=True)":

- Found 31 null values in both 'unit_price' and 'quantity' columns

- Removed nulls using df.dropna()

3. Data Type Conversion: Changed 'unit_price' from string to float

4. New Column Creation: Added 'total_price' by multiplying 'unit_price' with 'quantity'.

#### Load Data into MySQL 
Set Up Connections: Connect to MySQL using sqlalchemy and load the cleaned data into each database.

   #### SQL Analysis

   The cleaned data was analyzed in MySQL to answer key business questions using different methods like grouping, aggregation, subqueries and CTE:
   1. Payment Method Analysis: Different payment methods with transaction counts and quantities sold                                                                                      
   2. Product Performance: Highest rated category in each branch (Branch, category, average rating)
   3. Sales Timing: Busiest day for each branch based on transaction count (using date format)
   4. Payment Method Impact: Total quantity sold per payment method
   5. Regional Ratings: Average, minimum and maximum rating of categories for each city
   6. Profit Analysis: Total profit by category (unit price × quantity × profit margin), ordered highest to lowest
   7. Branch Preferences: Most common payment method for each branch
   8. Sales Shifts: Categorized sales into morning, afternoon, evening with invoice counts
   9. Performance Trends: Identified top 5 branches with highest revenue decrease ratio (2022 vs 2024)

       #### Power BI Visualizations
      Created interactive dashboards showing:
      - Quantity sold by payment method
      - Average total profit and revenue by category
      - Total unit price by category
      - Revenue decrease ratio by branch
      - Payment method ranking
      - Sales distribution by time of day
     
        ### Results and Insights

- Sales Insights: Key categories, branches with highest sales, and preferred payment methods.
- Profitability: Insights into the most profitable product categories and locations.
- Customer Behavior: Trends in ratings, payment preferences, and peak shopping hours.

  ### Future Enhancements
  
1. Add automated data pipeline
2. Incorporate more years of data for trend analysis
3. Implement predictive modeling for sales forecasting
  

   ### Data source
    Kaggle API Key 
   
