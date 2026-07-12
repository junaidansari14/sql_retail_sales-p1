# Retail Sales Analysis using SQL

## Project Overview

**Project Title:** Retail Sales Analysis

**Level:** Beginner

**Database:** `startersql`

This project demonstrates fundamental SQL skills used by data analysts to clean, explore, and analyze retail sales data. It covers database creation, data cleaning, exploratory data analysis (EDA), and business problem-solving using SQL queries.

This project is ideal for beginners who want to strengthen their SQL skills through real-world business scenarios.

---

# Objectives

- Create and set up a retail sales database.
- Import and organize retail sales data.
- Clean the dataset by identifying and removing missing or NULL values.
- Perform Exploratory Data Analysis (EDA).
- Answer business questions using SQL queries.
- Generate meaningful business insights from retail sales data.

---

# Database Setup

## Step 1: Create Database

```sql
CREATE DATABASE startersql;
```

---

## Step 2: Create Table

```sql
CREATE TABLE retail_sales (
    transactions_id INT,
    sale_date DATE,
    sale_time TIME,
    customer_id INT,
    gender VARCHAR(15),
    age INT,
    category VARCHAR(20),
    quantity INT,
    price_per_unit FLOAT,
    cogs FLOAT,
    total_sale FLOAT
);
```

---

# Data Exploration & Cleaning

## Total Number of Records

```sql
SELECT COUNT(*)
FROM retail_sales;
```

---

## Count Unique Customers

```sql
SELECT COUNT(DISTINCT customer_id) AS total_customers
FROM retail_sales;
```

---

## Find Unique Categories

```sql
SELECT DISTINCT category
FROM retail_sales;
```

---

## Check for NULL Values

```sql
SELECT *
FROM retail_sales
WHERE transactions_id IS NULL
   OR sale_date IS NULL
   OR sale_time IS NULL
   OR customer_id IS NULL
   OR gender IS NULL
   OR age IS NULL
   OR category IS NULL
   OR quantity IS NULL
   OR price_per_unit IS NULL
   OR cogs IS NULL
   OR total_sale IS NULL;
```

---

## Remove NULL Records

```sql
DELETE FROM retail_sales
WHERE transactions_id IS NULL
   OR sale_date IS NULL
   OR sale_time IS NULL
   OR customer_id IS NULL
   OR gender IS NULL
   OR age IS NULL
   OR category IS NULL
   OR quantity IS NULL
   OR price_per_unit IS NULL
   OR cogs IS NULL
   OR total_sale IS NULL;
```

---

# Business Analysis

## 1. Retrieve all sales made on 5th November 2022

```sql
SELECT *
FROM retail_sales
WHERE sale_date = '2022-11-05';
```

---

## 2. Retrieve all Clothing transactions where quantity sold is greater than or equal to 4 during November 2022

```sql
SELECT *
FROM retail_sales
WHERE category = 'Clothing'
  AND quantity >= 4
  AND MONTH(sale_date) = 11
  AND YEAR(sale_date) = 2022;
```

---

## 3. Calculate total sales and total orders for each category

```sql
SELECT
    category,
    SUM(total_sale) AS net_sales,
    COUNT(*) AS total_orders
FROM retail_sales
GROUP BY category;
```

---

## 4. Find the average age of customers who purchased products from the Beauty category

```sql
SELECT
    ROUND(AVG(age),2) AS average_age
FROM retail_sales
WHERE category = 'Beauty';
```

---

## 5. Retrieve all transactions where total sales are greater than 1000

```sql
SELECT *
FROM retail_sales
WHERE total_sale > 1000;
```

---

## 6. Find the total number of transactions made by each gender in each category

```sql
SELECT
    gender,
    category,
    COUNT(*) AS total_transactions
FROM retail_sales
GROUP BY gender, category
ORDER BY category;
```

---

## 7. Calculate the average monthly sales and identify the best-selling month of each year

```sql
SELECT
    year,
    month,
    average_sale
FROM
(
    SELECT
        YEAR(sale_date) AS year,
        MONTH(sale_date) AS month,
        ROUND(AVG(total_sale),2) AS average_sale,
        RANK() OVER(
            PARTITION BY YEAR(sale_date)
            ORDER BY AVG(total_sale) DESC
        ) AS ranking
    FROM retail_sales
    GROUP BY YEAR(sale_date), MONTH(sale_date)
) AS ranked_sales
WHERE ranking = 1;
```

---

## 8. Find the top 5 customers based on total sales

```sql
SELECT
    customer_id,
    SUM(total_sale) AS total_sales
FROM retail_sales
GROUP BY customer_id
ORDER BY total_sales DESC
LIMIT 5;
```

---

## 9. Find the number of unique customers in each category

```sql
SELECT
    category,
    COUNT(DISTINCT customer_id) AS unique_customers
FROM retail_sales
GROUP BY category;
```

---

## 10. Categorize sales into shifts and count total orders

- Morning → Before 12 PM
- Afternoon → 12 PM to 5 PM
- Evening → After 5 PM

```sql
WITH hourly_sales AS
(
SELECT *,
CASE
    WHEN HOUR(sale_time) < 12 THEN 'Morning'
    WHEN HOUR(sale_time) BETWEEN 12 AND 17 THEN 'Afternoon'
    ELSE 'Evening'
END AS shift
FROM retail_sales
)

SELECT
    shift,
    COUNT(*) AS total_orders
FROM hourly_sales
GROUP BY shift;
```

---

# Skills Demonstrated

- SQL
- Data Cleaning
- Data Exploration
- Aggregate Functions
- GROUP BY
- ORDER BY
- Window Functions
- Common Table Expressions (CTE)
- Date Functions
- Business Analysis

---

# Conclusion

This project demonstrates how SQL can be used to clean, analyze, and extract meaningful business insights from retail sales data. It covers essential SQL concepts commonly used by data analysts in real-world projects and serves as a strong beginner portfolio project.
