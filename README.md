# Retail-Sales-Data-Analysis-using-SQL-Server

📘 Overview

This project demonstrates how SQL Server can be used to analyze retail sales data and generate actionable business insights.
It involves importing transactional data from a CSV file, performing data exploration, and applying SQL queries to understand customer behavior, product performance, and overall sales trends.

🗂️ Dataset

File: Sales.csv
This dataset contains retail transaction data with the following fields:

Column Name	Description
transactions_id	Unique ID for each transaction
sale_date	Date of sale
sale_time	Time of sale
customer_id	Unique ID of the customer
gender	Gender of the customer
age	Age of the customer
category	Product category (e.g., Clothing, Beauty, Electronics)
quantity	Number of items sold
price_per_unit	Price of a single item
cogs	Cost of goods sold
total_sale	Total revenue from the transaction
🧠 Project Objectives

Import and clean retail transaction data into SQL Server

Write SQL queries to explore and analyze sales trends

Identify key metrics such as:

Total and average sales per category

Customer demographics and buying patterns

Peak sales time and day trends

Profitability and cost analysis

⚙️ Tools and Technologies

Database: Microsoft SQL Server

Language: T-SQL (Transact-SQL)

Data Source: Retail Sales CSV file (Sales.csv)

🧾 Project Structure
├── Sales.csv               # Retail transaction dataset
├── SQLQuery1.sql           # SQL script for creating table, importing data, and analysis
└── README.md               # Project documentation

🚀 How to Run the Project

Open SQL Server Management Studio (SSMS).

Create a new database, e.g., RetailDB.

Run the SQL script to create the table:

CREATE TABLE retail_sales (
    transactions_id INT PRIMARY KEY,
    sale_date DATE,
    sale_time TIME,
    customer_id INT,
    gender VARCHAR(15),
    age INT,
    category VARCHAR(15),
    quantity INT,
    price_per_unit FLOAT,
    cogs FLOAT,
    total_sale FLOAT
);


Import data from Sales.csv:

BULK INSERT retail_sales
FROM 'C:\\path\\to\\Sales.csv'
WITH (
    FIRSTROW = 2,
    FIELDTERMINATOR = ',',
    ROWTERMINATOR = '\n'
);


Execute queries from SQLQuery1.sql to generate insights.

📊 Example Analysis Queries
-- Total sales by product category
SELECT category, SUM(total_sale) AS total_revenue
FROM retail_sales
GROUP BY category
ORDER BY total_revenue DESC;

-- Average sales by gender
SELECT gender, AVG(total_sale) AS avg_sale
FROM retail_sales
GROUP BY gender;

-- Peak sales hours
SELECT DATEPART(HOUR, sale_time) AS sale_hour, SUM(total_sale) AS total_sales
FROM retail_sales
GROUP BY DATEPART(HOUR, sale_time)
ORDER BY sale_hour;

📈 Insights You Can Derive

Top-performing product categories

Most profitable customer segments

Best time and day for sales activity

Relationship between cost and revenue

Key factors influencing total sales

🧩 Learning Outcomes

By completing this project, you’ll learn:

How to import CSV data into SQL Server

Writing complex SQL queries for data analysis

Using aggregate and window functions

Extracting business insights using SQL

🏁 Conclusion

This project highlights the power of SQL Server in analyzing real-world retail datasets.
It showcases how SQL can be used for data-driven decision making, enabling deeper understanding of sales performance and customer behavior.
