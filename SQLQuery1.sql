
create table retail_sales (
	transactions_id	int primary key,
	sale_date date,
	sale_time time,	
	customer_id	int,
	gender varchar(15) ,
	age	int,
	category varchar(15), 	
	quantiy	int,
	price_per_unit float,
	cogs float,
	total_sale float
);


set dateformat dmy
bulk insert retail_sales
from 'C:\Users\Shivam agarwal\Downloads\project\Sales.csv'
  with (
	firstrow = 2,	
	fieldterminator = ',',
	rowterminator = '\n'
	);


select * from retail_sales

select count(*) from retail_sales

-- Data cleaning

select * from retail_sales
where transactions_id is null
	or sale_date is null
	or sale_time is null 	
	or customer_id	is null
	or gender is null 
	or category is null	
	or quantity	is null
	or cogs is null
	or total_sale is null

-- Changing the column name
EXEC sp_rename 'retail_sales.quantiy', 'quantity', 'COLUMN';


delete from retail_sales
where transactions_id is null
	or sale_date is null
	or sale_time is null 	
	or customer_id	is null
	or gender is null 
	or category is null	
	or quantity	is null
	or cogs is null
	or total_sale is null


-- Data Exploration



-- How many sales we have?

select count(transactions_id) as total_sales
from retail_sales

-- How many unique customers we have ?

select count(distinct customer_id) from retail_sales

-- Data Analysis & Business Key Problems & Answers


-- Q.1 Write a SQL query to retrieve all columns for sales made on '2022-11-05'

select * from retail_sales
where sale_date like '2022-11-05'


-- Q.2 Write a SQL query to retrieve all transactions where the category is 'Clothing' and the quantity sold is more than or equal to 4 in the month of Nov-2022

select * from retail_sales
where category = 'clothing' 
	  and quantity >= 4 
	  and month(sale_date) = 11
	  and year(sale_date) = 2022


-- Q.3 Write a SQL query to calculate the total sales (total_sale) for each category.

select category , sum(total_sale) as total_sales
from  retail_sales
group by category


-- Q.4 Write a SQL query to find the average age of customers who purchased items from the 'Beauty' category.

select avg(age) as Average_age
from retail_sales
where category = 'Beauty'


-- Q.5 Write a SQL query to find all transactions where the total_sale is greater than 1000.

select * from retail_sales
where total_sale > 1000


-- Q.6 Write a SQL query to find the total number of transactions (transaction_id) made by each gender in each category.

select Category , gender ,count(transactions_id) as total_trans
from retail_sales
group by  Category , gender
order by total_trans desc


-- Q.7 Write a SQL query to calculate the average sale for each month. Find out best selling month in each year

select * from (
select  year(sale_date) as year , 
		month(sale_date) as month ,
		avg(total_sale) as average ,
		rank() over (partition by year(sale_date) order by avg(total_sale) desc) as rank
from retail_sales
group by  year(sale_date)  , month(sale_date)
) t1
where rank = 1 


-- Q.8 Write a SQL query to find the top 5 customers based on the highest total sales 

select top 5 customer_id , sum(total_sale) as total_sales
from retail_sales
group by customer_id
order by total_sales desc


-- Q.9 Write a SQL query to find the number of unique customers who purchased items from each category.

select category ,  count(distinct customer_id) as unique_customer
from retail_sales
group by category


-- Q.10 Write a SQL query to create each shift and number of orders (Example Morning <=12, Afternoon Between 12 & 17, Evening >17)

with cte as (
select * , 
case 
	when datepart(hour , sale_time) < 12 then 'Morning'
	when datepart(hour , sale_time) between 12 and 17 then 'Afternoon'
	else 'Evening'
  end as shift
from retail_sales
)
select shift , count(*) as total_orders
from cte
group by shift