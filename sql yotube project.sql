-- SELECT * FROM startersql.retail_sales;
-- select 
--  count(*)
-- from retail_sales; 


-- select * from 
--  retail_sales
-- where transactions_id is null; 

--  data cleaning

-- select * from 
--  retail_sales 
--  where sale_date is null; 
 
 
-- select * from 
--  retail_sales 
--  where sale_time is null; 
 
 
-- select * from 
--  retail_sales
-- where transactions_id is null
-- or 
-- sale_date is null 
-- or 
-- sale_date is null
-- or
--  gender is null
--  or 
--  category is null
--  or
--  quantiy is null 
--  or
--  cogs is null
--  or
--  total_sale is null;

-- delete 
--     from retail_sales
--     where transactions_id is null
-- or 
-- sale_date is null 
-- or 
-- sale_date is null
-- or
--  gender is null
--  or 
--  category is null
--  or
--  quantiy is null 
--  or
--  cogs is null
select * from retail_sales;
--  or
--  total_sale is null;
 -- select * from retail_sales;
-- select count(category)
--  from retail_sales;
-- data exploration
-- select gender,customer_id,count(*) as duplicate 
-- from retail_sales
--  group by gender,customer_id
--  having count(*) >1;
-- select * from retail_sales;

--  how many sales we have ?

-- select count(*) as total_sales 
--  from retail_sales;
--  
  -- how many unique  coustomer we have ?
  
select count( distinct customer_id) as total_sales 
 from retail_sales;
 
 --  how manay unique category we phave ?
 
 select  distinct category  
 from retail_sales;
 
 -- 
 
 select * from retail_sales;


-- data analysis & bussiness key problem & answers?
-- my analysis & findiong ?
-- Q1 write a sql query to retrevive all the columns from sales maade on 202-11-05
--  Q2 wiret a query to retrevive all transaction where catrgory is clothing and the quantity is sold more then 10 in
--  the month of nov 10-2022 
-- Q3













-- write a sql query to retrevive all the columns from sales maade on 2022-11-05?

-- select * from retail_sales;


select count(sale_date)
from retail_sales 
where sale_date  = '2022-11-05';

-- Q2 wiret a query to retrevive all transaction where catrgory is clothing and the quantity is sold more then 10 in
--  the month of nov 11-2022 ?

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

-- Q3 write sql query to calculate the total_sales (total_sales) from each category ?

select 
  category,
  sum(total_sale) as net_sale,
  count(*)as total_orders
from retail_sales
group by category;


-- Q4 wirte a query to find an average of customer to pucrchase a item bueaty 'category' ?
select 
    round(avg(age) , 2)as average_age 
   from retail_sales 
 where category  = 'beauty';  
 
 
 -- Q5 wite a  query to find all transaction where total_sale  is greater then 1000 ?
 
 select * 
  from retail_sales
 where total_sale > 1000; 
 
 -- Q6 write a query to find total no of  transaction (tranaction_id) made each gender and each category ?
 
 
 select gender,category,
 count(*) as total_transaction
 from retail_sales
 group by gender,category
 order by  category ;
  
  select * from retail_sales;
  
  alter table retail_sales rename column quantiy to quantity;
 
 -- Q7  WRITE A QUERY TO CALCULATE  THE AVERAGE SALES OF EACH MONTH.FIND OUT THE BEST SEALLING MONTH OF EACH YEAR ?
 
 
select * from retail_sales; 

select 
 year,
 month ,avgerage_sale
 from 
( select 
    year(sale_date)as year,
   month(sale_date) as month,
   round (avg(total_sale) , 2) as avgerage_sale,
rank() over(partition by year(sale_date)order by avg(total_sale)desc
 ) as ranking
from retail_sales
group by year,month) as t1
 where ranking = 1;

-- order by year, avgerage_sale desc;

-- Q8 WRITE A QUERY TO FIND OUT THE TOP FIVE CUSTOMERS BASED  ON THE HIGHEST  TOATAL_SALE ?
 
 
 SELECT * FROM retail_sales;
 
 select 
   customer_id,
   sum(total_sale) as sales
 from retail_sales
 group by customer_id
 order by sales desc
 limit 5; 
 
 -- Q9 write a sql query to find a unique customer who purcahse item of each category ? 
 
 use startersql;
 
select 
  category, 
   count(distinct customer_id) as unique_customer 
 from retail_sales
 group by category;
 
 
 --  Q10 write a sql query to create each shift and number of order (example morning <=12 after noon between 12 & 17 evening > 17) ?

select * from retail_sales; 

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


 -- end of project 
