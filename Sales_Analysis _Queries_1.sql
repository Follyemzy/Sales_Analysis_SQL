-- Sales Analysis SQL Project
-- Author: Folayemi O Akinbobola
-- Description: Data cleaning and business insights queries for sales data analysis
--Add a New Order_Date_Converted Column of Type DATE

ALTER TABLE sales_analysis
ADD Order_Date_Converted DATE;

--Populate It by Converting from the Text Column
UPDATE sales_analysis
SET Order_Date_Converted = TRY_CONVERT(DATE, Order_Date, 101);


SELECT TOP (1000) [Order_ID]
      ,[Order_Date]
      ,[Order_Quantity]
      ,[Sales]
      ,[Discount]
      ,[Ship_Mode]
      ,[Profit]
      ,[Unit_Price]
      ,[Shipping_Cost]
      ,[Customer_Name]
      ,[Region]
      ,[Customer_Segment]
      ,[Product_Category]
  FROM [sales_analysis].[dbo].[Sales_Analysis]


--Check for Failed Conversions

SELECT *
FROM sales_analysis
WHERE Order_Date_Converted IS NULL AND Order_Date IS NOT NULL;

SELECT *
FROM sales_analysis

 --Drop the original text column

ALTER TABLE sales_analysis DROP COLUMN Order_Date

SELECT *
FROM sales_analysis
-- Rename the new one to match old name
EXEC sp_rename 'sales_analysis.Order_Date_Converted', 'Order_Date', 'COLUMN';


--BUSINESS QUESTIONS AND SOLUTIONS 

SELECT *
FROM sales_analysis

--1 What is the total sales per region?

SELECT Region,ROUND(SUM(sales),2)total_sales
FROM Sales_Analysis
GROUP BY Region;

--2 Who are the top 5 most profitable customer segments?

SELECT Top 5 Customer_Segment,ROUND(SUM(Profit),2) AS total_profit
FROM Sales_Analysis
GROUP BY Customer_Segment
ORDER By total_profit DESC;

--3 How do monthly sales trend over time?

SELECT FORMAT(Order_Date,'yyy-MM'),
        ROUND(SUM(Sales),2) AS total_sales
FROM sales_analysis
GROUP BY  FORMAT(Order_Date,'yyy-MM')
ORDER BY FORMAT(Order_Date,'yyy-MM');

--4 How do monthly sales trend in Four years
SELECT FORMAT(Order_Date,'yyy'),
        ROUND(SUM(Sales),2) AS total_sales
FROM sales_analysis
GROUP BY  FORMAT(Order_Date,'yyy')
ORDER BY FORMAT(Order_Date,'yyy');

--5 What is the average discount given per shipping mode?
SELECT Ship_Mode,Round(AVG(Discount),4) AS AverageDiscount
FROM sales_analysis
GROUP BY Ship_Mode;


--6 Which product categories have the highest profit-to-cost ratio?

SELECT Product_Category,
        (SUM(Profit)/ SUM(Unit_Price+Shipping_Cost)) AS profit_ratio
FROM Sales_Analysis
GROUP BY  Product_Category
ORDER BY profit_ratio DESC;


--7 Who are the top 10 customers by total sales?

SELECT Top 10 Customer_Name,ROUND(SUM(Sales),2) AS total_sales
FROM sales_analysis
GROUP BY Customer_Name
ORDER BY total_sales DESC;

--8 Are we making a profit or loss after applying discounts?
SELECT 
   ROUND(SUM(Sales),2) AS Total_Sales,
    ROUND(SUM(Discount),2)AS Total_Discount,
    ROUND(SUM(Profit),2) AS Total_Profit,
    ROUND(SUM(Sales - Discount),2) AS Net_Revenue
FROM sales_analysis;

--9 Which regions are consistently losing money (negative profit)?

SELECT Region, ROUND(SUM(profit),2) as Negative_Profit
FROM Sales_Analysis 
Group BY Region
HAVING SUM(Profit) < 0
ORDER BY Negative_Profit


--10 What is the average shipping cost per product category?
SELECT Product_Category,
       AVG(Shipping_Cost) AS shipping_cost
FROM Sales_Analysis
GROUP BY Product_Category

--11 What is the trend of order quantity over time?



SELECT FORMAT(Order_Date,'yyy-MM') as Month,SUM(Order_Quantity) AS order_Quantity 
FROM sales_analysis
GROUP BY FORMAT(Order_Date,'yyy-MM')
ORDER BY Month;
--12 Which shipping mode is used most often?

SELECT Ship_Mode,COUNT(Ship_Mode) as count_shipmode
FROM sales_analysis
GROUP BY Ship_Mode;


--13 What is the total sales and profit for each product category?
SELECT Product_Category, ROUND(SUM(Sales),2) AS total_sales,ROUND(SUM(Profit),2)AS TotalProfit
FROM sales_analysis
GROUP BY  Product_Category


SELECT *
FROM sales_analysis

--14 How much discount is being given out in total per region?
SELECT ROUND(SUM(Discount),2) AS discount,Region
FROM sales_analysis
GROUP BY Region

--15 How does unit price vary across customer segments?
SELECT ROUND(SUM(Unit_Price),2)AS unit_price,Customer_Segment
FROM sales_analysis
GROUP BY Customer_Segment

--16 Which customers have the highest return (profit-to-sales ratio)?
SELECT Customer_Name,
      (SUM(Profit) / SUM(Sales))*100 AS ProfitToSalesRatio
FROM sales_analysis
GROUP BY Customer_Name
ORDER BY ProfitToSalesRatio DESC;

--17 Which dates or periods had the highest number of orders?
SELECT Order_Date, COUNT(Distinct Order_ID) Total_order
FROM sales_analysis
GROUP BY Order_Date
ORDER  BY Order_Date DESC;

--18 What is the average profit per order?
SELECT DISTINCT AVG(Profit) as AverageProfit
FROM sales_analysis

--19 are some customer segments more likely to buy specific product categories?

SELECT Customer_Segment,
    COUNT(*)AS Purchase_count, 
    Product_Category
FROM sales_analysis
GROUP BY Customer_Segment,Product_Category
ORDER BY Purchase_count DESC;

--20 What is the average order size (quantity) by region?
SELECT Region,
    AVG(Order_Quantity)AS avg_order_Quantity
FROM sales_analysis
Group BY Region 
ORDER BY avg_order_Quantity DESC;

--21 Customer Distribution by Region and Segment

SELECT 
    Region,
    Customer_Segment,
    COUNT(DISTINCT Customer_Name) AS customers
FROM sales_analysis
GROUP BY Region, Customer_Segment
ORDER BY customers DESC;

--22 How many unique customers are in each region?
SELECT Region,COUNT(DISTINCT Customer_Name) AS customers
FROM sales_analysis
Group BY Region 
ORDER BY customers DESC;


