#  retail sales analysis sql project p1

## project overview 
**project title**: Retail sales Analysis
**Level**:Biggner
**Databases**:'startersql'

These project is designed to demonstrate SQL skills and technique typically used by data analysis to explore,clean, and analyze retail sales data,The project involves setting up a retail sales database,performing exploratary data analysis (EDA),and answering specific bussiness question through sql queries This project is ideal for those who are starting their journey in data analysis and want to build a solid foundation in SQL.

## Objective

1. **set up retail sales databases**: create and populate a ratail sales database with the provided sales data.
2. **data cleaning**: Identify and remove any records with missing or  null values:
3. **Exploratory data analysis (EDA)**: perform basic exploratory data analysis to understand the dataset.
4. **Businee Analysis**: Use SQL to answer specific business question and derive insight from the sales data. 


## Project structure 

### 1. database setup

- **database creation**: The project start by creating a database named 'startersql.
- **table creation**: A table named 'retail_sales' is created to store the sale data.The table structure includes columns for transaction ID, sale date,sale time,customer id ,gender , age, product category,quantity sold,price per unit,cost of good sold (cogs),and total sales amount.
  

 '''sql
 create database startersql;

 create TABLE retail_sales;
 (
    transactions_id int 
    sale_date date 
    sale_time time 
    customer_id int 
    gender varchar(15) 
    age int 
    category varchar(11) 
    quantity int 
    price_per_unit float 
    cogs float 
    total_sale float
);
'''
## 2 Data exploration and cleaning 
- **record count**: Determine the total number of records in the dataset.
- **customer count**:Find out how many unique cuatomers are in the dataset.
- **category count**: Identify all unique product category in the dataset.
- **null value check**: Check for anay null values in the dataset and delete records with missing data.
  
'''sql
select  count(*)from retail_sales;
select * from retail_sales where transactions_id is null;
select count(category) from retail_sales;
select count( distinct customer_id) as total_sales 
 from retail_sales;

select * from retail_sales;
where 
   transactions_id is null or sale_date is null
   or sale_date is null or gender is null
   or category is null or quantiy is null 
   or cogs is null or total_sale is null;
delete 
    from retail_sales
    where transactions_id is null 
    or sale_date is null 
    or sale_date is null
    or gender is null
    or category is null
    orquantiy is null 
    or cogs is null;
 ### data analysis & finding 
 The following sql queries  were developed to answer specific bussines question:
1.**write a sql query to retrevive all the columns from sales maade on 2022-11-05**
'''sql

select count(sale_date) from retail_sales where sale_date  = '2022-11-05';
'''

2.**wiret a query to retrevive all transaction where catrgory is clothing and the quantity is sold more then 10 in the month of nov 11-2022**
'''sql
SELECT *
FROM retail_sales
WHERE category = 'Clothing'
  AND quantiy>= 4
  AND MONTH(sale_date) = 11
  AND YEAR(sale_date) = 2022;

select count(category)
from retail_sales
where category = 'clothing'
and quantiy>=4 
and month(sale_date)= 11
and year(sale_date ) = 2022
'''

3.**write sql query to calculate the total_sales (total_sales) from each category**
'''sql
select 
  category,
  sum(total_sale) as net_sale,
  count(*)as total_orders
from retail_sales
group by category;
'''
4.**wirte a query to find an average of customer to pucrchase a item bueaty 'category'**
'''sql
select 
    round(avg(age) , 2)as average_age 
   from retail_sales 
where category  = 'beauty';  
'''
5,**wite a  query to find all transaction where total_sale  is greater then 1000**
 '''sql
  select * 
  from retail_sales
 where total_sale > 1000; 
'''

 6.**write a query to find total no of  transaction (tranaction_id) made each gender and each category**
 '''sql
 select gender,category,
 count(*) as total_transaction
 from retail_sales
 group by gender,category
 order by  category ;
 '''
 
 7.**WRITE A QUERY TO CALCULATE  THE AVERAGE SALES OF EACH MONTH.FIND OUT THE BEST SEALLING MONTH OF EACH YEAR**
 '''sql
 select 
 year,
 month ,avgerage_sale
 from 
( select 
    year(sale_date)as year,
   month(sale_date) as month,
   round (avg(total_sale) , 2) as avgerage_sale,
rank() over(partition by year(sale_date)
order by avg(total_sale)desc
 ) as ranking
from retail_sales
group by year,month) as t1
 where ranking = 1;
 '''
 
 8.**WRITE A QUERY TO FIND OUT THE TOP FIVE CUSTOMERS BASED  ON THE HIGHEST  TOATAL_SALE**
 '''sql
 select 
   customer_id,
   sum(total_sale) as sales
 from retail_sales
 group by customer_id
 order by sales desc
 limit 5; 
 '''
 
 9.**write a sql query to find a unique customer who purcahse item of each category**
 '''sql
 select 
  category, 
   count(distinct customer_id) as unique_customer 
 from retail_sales
 group by category;
 '''

10.**write a sql query to create each shift and number of order (example morning <=12 after noon between 12 & 17 evening > 17)**
'''sql
with hourly_sale
as 
( 
select *,
case 
 when hour(sale_date) <12 then 'morning'
 when hour (sale_date) between 12 and 17 then'evening' 
   else'afternoon'
  end as shift 
  from retail_sales
  )
  select 
  shift,
  count(*) as total_order
  from hourly_sale
  group by shift;
  '''
  

   




