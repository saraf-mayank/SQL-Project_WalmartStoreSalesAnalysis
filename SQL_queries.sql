CREATE DATABASE IF NOT EXISTS walmartSales;
USE walmartSales;

-- Data Cleaning
SELECT * FROM `Date`;
DESCRIBE sales;
SET SQL_SAFE_UPDATES = 0;

UPDATE sales
SET `Date` = STR_TO_DATE(Date, '%d-%m-%Y');

SET SQL_SAFE_UPDATES = 0;

SELECT `Date`
FROM sales
WHERE STR_TO_DATE(`Date`, '%d-%m-%Y') IS NULL;

ALTER TABLE sales
MODIFY COLUMN `Date` DATETIME NOT NULL;
ALTER TABLE sales
RENAME COLUMN `Date` to order_date;

ALTER TABLE sales
RENAME COLUMN `Invoice ID` to invoice_id;
ALTER TABLE sales
RENAME COLUMN `Branch` to branch;
ALTER TABLE sales
RENAME COLUMN `City` to city;
ALTER TABLE sales
RENAME COLUMN `Customer type` to customer_type;
ALTER TABLE sales
RENAME COLUMN `Gender` to gender;
ALTER TABLE sales
RENAME COLUMN `Product line` to product_line;
ALTER TABLE sales
RENAME COLUMN `Unit price` to unit_price;
ALTER TABLE sales
RENAME COLUMN `qunatity` to quantity;
ALTER TABLE sales
RENAME COLUMN `Tax 5%` to tax_pct;
ALTER TABLE sales
RENAME COLUMN `total` to total_revenue;
ALTER TABLE sales
RENAME COLUMN `Time` to order_time;
ALTER TABLE sales
RENAME COLUMN `paymnet` to payment_type;
ALTER TABLE sales
RENAME COLUMN `gross margin percentage` to gross_margin_pct;
ALTER TABLE sales
RENAME COLUMN `gross income` to gross_income;
ALTER TABLE sales
RENAME COLUMN `Rating` to rating;

COMMIT;


-- Add the time_of_day column
SELECT 
	order_time,
    (CASE
		WHEN order_time BETWEEN "00:00:00" AND "12:00:00" THEN "Morning"
        WHEN order_time BETWEEN "12:01:00" AND "16:00:00" THEN "Afternoon"
        ELSE "Evening"
	END) AS time_of_day
FROM sales;

ALTER TABLE sales ADD COLUMN time_of_day VARCHAR(20);
SET SQL_SAFE_UPDATES = 0;
UPDATE sales
SET time_of_day = (
	CASE
		WHEN order_time BETWEEN "00:00:00" AND "12:00:00" THEN "Morning"
        WHEN order_time BETWEEN "12:01:00" AND "16:00:00" THEN "Afternoon"
        ELSE "Evening"
	END
);


-- Add day_name column
SELECT
	order_date,
	DAYNAME(order_date) 
FROM sales;

ALTER TABLE sales ADD COLUMN day_name VARCHAR(10);

UPDATE sales
SET day_name = DAYNAME(order_date);


-- Add month name column
SELECT
	order_date,
		MONTHNAME(order_date)
FROM sales;

ALTER TABLE sales ADD COLUMN month_name VARCHAR (20);

UPDATE sales
SET month_name = MONTHNAME(order_date);


-- --------------------------------------------------------------------
-- ---------------------------- Generic ------------------------------
-- --------------------------------------------------------------------

-- How many unique cities does the data have?
SELECT 
	DISTINCT city
FROM sales;

-- In which city is each branch?
SELECT 
	DISTINCT city,
    branch
FROM sales;


-- --------------------------------------------------------------------
-- ---------------------------- Product -------------------------------
-- --------------------------------------------------------------------

-- How many unique product lines does the data have?
SELECT DISTINCT product_line
FROM sales;

-- What is the most common payment method
SELECT payment_type, 
		COUNT(payment_type) AS cnt
FROM sales
GROUP BY payment_type
ORDER BY cnt DESC;

-- What is the most selling product line
SELECT
	SUM(quantity) as qty,
    product_line
FROM sales
GROUP BY product_line
ORDER BY qty DESC;

-- What is the total revenue by month
SELECT
	month_name AS month,
	Round(SUM(total_revenue),2)
FROM sales
GROUP BY month_name 
ORDER BY total_revenue;

-- What month had the largest COGS?
SELECT 
	month_name, 
    Round(SUM(cogs),2) as COGS
FROM sales
GROUP BY month_name
ORDER BY COGS DESC;

-- What product line had the largest revenue?
SELECT 
	product_line, 
    Round(SUM(total_revenue),2) as revenue
FROM sales
GROUP BY product_line
ORDER BY revenue DESC;

-- What is the city with the largest revenue?
SELECT 
	city, 
    Round(SUM(total_revenue),2) as revenue
FROM sales
GROUP BY city
ORDER BY revenue DESC;

-- What product line had the largest VAT?
SELECT 
	product_line, 
    Round(AVG(tax_pct),2) as vat
FROM sales
GROUP BY product_line
ORDER BY vat DESC;

-- Fetch each product line and add a column to those product line showing "Good", "Bad". Good if its greater than average sales

SELECT 
	product_line,
    CASE
		WHEN AVG(quantity)>
			(SELECT AVG(quantity) FROM sales)
		THEN 'Good'
        ELSE 'Bad'
	END AS remark
FROM sales
GROUP BY product_line;

-- Which branch sold more products than average product sold?

SELECT
    branch,
    AVG(quantity) AS avg_products_sold
FROM sales
GROUP BY branch
HAVING AVG(quantity) >
       (SELECT AVG(quantity) FROM sales);

-- What is the most common product line by gender
SELECT 
	gender,
	count(gender) as cnt, 
    product_line
FROM sales
GROUP BY gender, product_line
ORDER BY cnt DESC;

-- What is the average rating of each product line
SELECT product_line, ROUND(AVG(rating),1)
FROM sales
GROUP BY product_line;
		
-- --------------------------------------------------------------------
-- ---------------------------- Customer -------------------------------
-- --------------------------------------------------------------------

-- How many unique customer types does the data have?
SELECT 
	DISTINCT customer_type
FROM sales;

-- How many unique payment methods does the data have?
SELECT 
	DISTINCT payment_type
FROM sales;

-- Which is the most common customer type?
SELECT 
	customer_type,
    COUNT(customer_type)
FROM sales
GROUP BY customer_type;

-- Which customer type buys the most?
SELECT 
	customer_type,
    ROUND(SUM(total_revenue),2) AS most_buys
FROM sales
GROUP BY customer_type
ORDER BY most_buys DESC;

-- What is the gender of most of the customers?
SELECT 
	gender,
    COUNT(gender)
FROM sales
GROUP BY gender;

-- What is the gender distribution per branch?
SELECT
	branch,
    gender,
    count(gender) AS gender_dist
FROM sales
GROUP BY gender, branch
ORDER BY branch;

-- What is the average rating by gender type?

SELECT
	gender,
    ROUND(AVG(rating),1) AS avg_rating
FROM sales
GROUP BY gender;


-- --------------------------------------------------------------------
-- ---------------------------- Sales -------------------------------
-- --------------------------------------------------------------------

-- Number of sales made at each time of the day.
SELECT
	day_name,
    SUM(CASE WHEN time_of_day = 'Morning' THEN 1 ELSE 0 END) AS Morning,
    SUM(CASE WHEN time_of_day = 'Afternoon' THEN 1 ELSE 0 END) AS Afternoon,
    SUM(CASE WHEN time_of_day = 'Evening' THEN 1 ELSE 0 END) AS Evening
    FROM sales
    GROUP BY day_name
    ORDER BY FIELD(day_name,
  'Monday','Tuesday','Wednesday','Thursday','Friday','Saturday','Sunday');

-- Which of the customer types brings the most revenue?
SELECT 
	customer_type, 
    ROUND(SUM(total_revenue),2) AS revenue 
    FROM sales 
    GROUP BY customer_type 
    ORDER BY revenue DESC;

