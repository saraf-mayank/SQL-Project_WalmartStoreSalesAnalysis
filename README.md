# Walmart Store Sales Data Analysis

## About

This project explores the Walmart Store Sales data to understand top-performing branches and products, sales trends of different products, and customer behavior. The aim is to study how sales strategies can be improved and optimized. The dataset was obtained from the [the Kaggle Walmart Store Sales Forecasting Competition.](https://www.kaggle.com/c/walmart-recruiting-store-sales-forecasting)

In this recruiting competition, job-seekers are provided with historical sales data for 45 Walmart stores located in different regions. Each store contains many departments, and participants must project the sales for each department in each store. To add to the challenge, selected holiday markdown events are included in the dataset. These markdowns are known to affect sales, but it is challenging to predict which departments are affected and the extent of the impact.

## Project Objective

This project aims to obtain insight into Walmart's sales data to comprehend the various elements that influence sales at various locations.

## About Data

The dataset was obtained from the [the Kaggle Walmart Store Sales Forecasting Competition.](https://www.kaggle.com/c/walmart-recruiting-store-sales-forecasting) This dataset contains sales transactions from three different branches of Walmart, respectively located in Mandalay, Yangon, and Naypyitaw. The data contains 17 columns and 1000 rows.

| Column                  | Description                             | Data Type      |
| :---------------------- | :-------------------------------------- | :------------- |
| invoice_id              | Invoice of the sales made               | VARCHAR(30)    |
| branch                  | Branch at which sales were made         | VARCHAR(5)     |
| city                    | The location of the branch              | VARCHAR(30)    |
| customer_type           | The type of the customer                | VARCHAR(30)    |
| gender                  | Gender of the customer making purchase  | VARCHAR(10)    |
| product_line            | Product line of the product sold        | VARCHAR(100)   |
| unit_price              | The price of each product               | DECIMAL(10, 2) |
| quantity                | The amount of the product sold          | INT            |
| VAT                 | The amount of tax on the purchase       | FLOAT(6, 4)    |
| total                   | The total cost of the purchase          | DECIMAL(10, 2) |
| date                    | The date on which the purchase was made | DATE           |
| time                    | The time at which the purchase was made | TIMESTAMP      |
| payment_method                 | The total amount paid                   | DECIMAL(10, 2) |
| cogs                    | Cost Of Goods sold                      | DECIMAL(10, 2) |
| gross_margin_percentage | Gross margin percentage                 | FLOAT(11, 9)   |
| gross_income            | Gross Income                            | DECIMAL(10, 2) |
| rating                  | Rating                                  | FLOAT(2, 1)    |

## Analysis 

1. Product Analysis

> Analyze the data to identify the various product lines, the best-performing ones, and the ones that require improvement.

2. Sales Analysis

> The purpose of this analysis is to respond to the query on the product's sales trends. The outcome of this can be used to gauge how well each sales approach the company uses and what adjustments are necessary to increase sales.

3. Customer Analysis

> The purpose of this analysis is to identify the various customer segments, purchase patterns, and profitability of each segment.

## Approach Used

1. **Data Wrangling:** In this initial step, data is inspected to ensure that **NULL** and missing values are found, and data replacement techniques are applied to replace the missing or **NULL** values.

> 1. Build a database
> 2. Create the table and insert the data.
> 3. Select the columns where the values are null. We screened out null values when we created the tables, so there are no null entries in our database. Instead, each field is set to **NOT NULL**.

2. **Feature Engineering:** This will enable us to create some new columns out of the ones that already exist.

> 1. To provide insight into sales in the morning, afternoon, and evening, add a new column called `time_of_day`. This will assist in addressing the query of what time of day most sales occur.

> 2. To record the extracted days of the week on which the provided transaction occurred, add a new column called `day_name` (Mon, Tue, Wed, Thur, Fri). This will assist in addressing the query of which day of the week each branch is busiest.

> 3. Create a new column called `month_name` with the extracted months (Jan, Feb, Mar) of the year that the given transaction occurred. Assist in identifying the month with the most profit and sales for the year.

2. **Exploratory Data Analysis (EDA):** Exploratory data analysis is done to answer the listed questions and aims of the project.



## Business Questions To Answer

### Generic Question

1. How many unique cities does the data have?
2. In which city is each branch?

### Product

1. How many unique product lines does the data have?
2. What is the most common payment method?
3. What is the most selling product line?
4. What is the total revenue by month?
5. What month had the largest COGS?
6. What product line had the largest revenue?
5. What is the city with the largest revenue?
6. What product line had the largest VAT?
7. Fetch each product line and add a column to those product lines showing "Good", and "Bad". Good if it's greater than average sales
8. Which branch sold more products than the average product sold?
9. What is the most common product line by gender?
12. What is the average rating of each product line?

### Sales

1. Number of sales made at each time of the day per weekday
2. Which of the customer types brings the most revenue?
3. Which city has the largest tax percentage/ VAT (**Value Added Tax**)?
4. Which customer type pays the most in VAT?

### Customer

1. How many unique customer types does the data have?
2. How many unique payment methods does the data have?
3. What is the most common customer type?
4. Which customer type buys the most?
5. What is the gender of most of the customers?
6. What is the gender distribution per branch?
7. Which time of the day do customers give the most ratings?
8. Which time of the day do customers give the most ratings per branch?
9. Which day of the week has the best average ratings?
10. Which day of the week has the best average ratings per branch?


## Revenue And Profit Calculations

$ COGS = unitsPrice * quantity $

$ VAT = 5\% * COGS $

$VAT$ is added to the $COGS$ and this is what is billed to the customer.

$ total(gross_sales) = VAT + COGS $

$ grossProfit(grossIncome) = total(gross_sales) - COGS $

**Gross Margin** is gross profit expressed in percentage of the total(gross profit/revenue)

$ \text{Gross Margin} = \frac{\text{gross income}}{\text{total revenue}} $

<u>**Example with the first row in our DB:**</u>

**Data given:**

- $ \text{Unite Price} = 45.79 $
- $ \text{Quantity} = 7 $

$ COGS = 45.79 * 7 = 320.53 $

$ \text{VAT} = 5\% * COGS\\= 5\%  320.53 = 16.0265 $

$ total = VAT + COGS\\= 16.0265 + 320.53 = $336.5565$

$ \text{Gross Margin Percentage} = \frac{\text{gross income}}{\text{total revenue}}\\=\frac{16.0265}{336.5565} = 0.047619\\\approx 4.7619\% $

