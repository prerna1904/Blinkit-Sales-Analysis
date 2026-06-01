CREATE TABLE blinkit_sales (
    Order_ID VARCHAR(20),
    Customer_ID VARCHAR(20),
    Customer_Name VARCHAR(100),
    City VARCHAR(50),
    Category VARCHAR(50),
    Product_Name VARCHAR(100),
    Quantity INT,
    Unit_Price DECIMAL(10,2),
    Discount_Pct DECIMAL(5,2),
    Discount_Amount DECIMAL(10,2),
    Sales DECIMAL(10,2),
    Profit DECIMAL(10,2),
    Payment_Method VARCHAR(50),
    Order_Date DATE,
    Delivery_Time_Mins INT,
    Order_Status VARCHAR(20),
    Rating DECIMAL(3,1)
);

SELECT * FROM  blinkit_sales;

-- 1.Overall Business Summary
SELECT 
    COUNT(*) AS total_orders,
    SUM(sales) AS total_sales,
    SUM(profit) AS total_profit,
    ROUND(AVG(sales),2) AS avg_order_value,
    ROUND(AVG(rating),2) AS avg_rating
FROM blinkit_sales;

-- 2.Which product category is generating the most revenue?
SELECT 
    category,
    COUNT(*) AS total_orders,
    ROUND(SUM(sales),2) AS total_sales,
    ROUND(SUM(profit),2) AS total_profit
FROM blinkit_sales
GROUP BY category
ORDER BY total_sales DESC;

-- 3. Who are our top 10 highest spending customers?
SELECT 
    customer_id,
    customer_name,
    COUNT(*) AS total_orders,
    ROUND(SUM(sales),2) AS total_sales
FROM blinkit_sales
GROUP BY customer_id, customer_name
ORDER BY total_sales DESC
LIMIT 10;

-- 4.Which categories have total profit greater than 5000?
SELECT category,SUM(profit) AS total_profit
FROM blinkit_sales
GROUP BY category
HAVING SUM(profit) > 5000
ORDER BY total_profit DESC;

-- 5.How is each city performing in terms of sales and delivery?
SELECT
	CITY,
	COUNT(*) AS TOTAL_ORDERS,
	SUM(SALES) AS TOTAL_SALES,
	ROUND(AVG(DELIVERY_TIME_MINS),2) AS AVG_DELIVERY_MINS,
	ROUND(AVG(RATING),2) AS AVG_RATING
FROM BLINKIT_SALES
GROUP BY CITY
ORDER BY TOTAL_SALES DESC;

-- 6.What percentage of orders are delivered, cancelled, or returned?
SELECT  order_status,
    COUNT(*) AS total_orders,
    ROUND(COUNT(*) * 100.0 / SUM(COUNT(*)) OVER(), 2) AS percentage
FROM blinkit_sales
GROUP BY order_status
ORDER BY total_orders DESC;

-- 7.How are sales trending month by month?
SELECT 
    TO_CHAR(order_date, 'YYYY-MM-DD') AS month,
    COUNT(*) AS total_orders,
    ROUND(SUM(sales),2) AS total_sales
FROM blinkit_sales
GROUP BY TO_CHAR(order_date, 'YYYY-MM-DD')
ORDER BY month;

-- 8.What is the cumulative sales growth month by month?
SELECT 
    TO_CHAR(order_date, 'YYYY-MM') AS month,
    ROUND(SUM(sales),2) AS monthly_sales,
    ROUND(SUM(SUM(sales)) OVER(ORDER BY TO_CHAR(order_date, 'YYYY-MM')),2) AS running_total
FROM blinkit_sales
GROUP BY TO_CHAR(order_date, 'YYYY-MM')
ORDER BY month;

-- 9.What is the sales rank of each product within its category?
SELECT 
    category,
    product_name,
    ROUND(SUM(sales),2) AS total_sales,
    RANK() OVER(PARTITION BY category ORDER BY SUM(sales) DESC) AS sales_rank
FROM blinkit_sales
GROUP BY category, product_name
ORDER BY category, sales_rank;

-- 10.Which are the top 3 best selling products in each category?
SELECT * FROM (
    SELECT 
        category,
        product_name,
        ROUND(SUM(sales),2) AS total_sales,
        RANK() OVER(PARTITION BY category ORDER BY SUM(sales) DESC) AS sales_rank
    FROM blinkit_sales
    GROUP BY category, product_name
) AS ranked_products
WHERE sales_rank <= 3
ORDER BY category, sales_rank;

-- 11.Which categories have the highest return rates?
SELECT 
    category,
    COUNT(*) AS total_orders,
    SUM(CASE WHEN order_status = 'Returned' THEN 1 ELSE 0 END) AS returned_orders,
    ROUND(SUM(CASE WHEN order_status = 'Returned' THEN 1 ELSE 0 END) * 100.0 / COUNT(*), 2) AS return_rate_pct
FROM blinkit_sales
GROUP BY category
ORDER BY return_rate_pct DESC;

-- 12.Which payment method is most preferred by customers?
SELECT 
    payment_method,
    COUNT(*) AS total_orders,
    ROUND(SUM(sales),2) AS total_sales,
    ROUND(COUNT(*) * 100.0 / SUM(COUNT(*)) OVER(), 2) AS usage_percentage
FROM blinkit_sales
GROUP BY payment_method
ORDER BY total_orders DESC;
