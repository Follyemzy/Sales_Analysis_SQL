# 📊 Sales Analysis SQL Project

## Project Overview  
This project involves cleaning and analyzing transactional sales data to extract key business insights. Using SQL queries, the project explores sales trends, profitability, customer behavior, and operational efficiency based on the sales dataset.

## Dataset Description  
The dataset includes the following fields:

| Column Name       | Description                                  |
|-------------------|----------------------------------------------|
| Order_ID          | Unique identifier for each order             |
| Order_Date        | Date the order was placed (converted to DATE)|
| Order_Quantity    | Number of items ordered                       |
| Sales             | Total sales amount                            |
| Discount          | Discount applied to the order                 |
| Ship_Mode         | Mode of shipment (e.g., Standard, Express)  |
| Profit            | Profit earned from the order                  |
| Unit_Price        | Price per unit                                |
| Shipping_Cost     | Cost to ship the order                        |
| Customer_Name     | Name of the customer                          |
| Region            | Geographic region                             |
| Customer_Segment  | Customer category (e.g., Consumer, Corporate)|
| Product_Category  | Category of product sold                       |

## Data Cleaning Steps  
- Converted `Order_Date` from text to proper SQL `DATE` datatype.  
- Dropped the original text-based `Order_Date` column.  
- Renamed the converted date column to `Order_Date`.

## Business Questions Answered  
- Total sales per region  
- Top 5 most profitable customer segments  
- Monthly and yearly sales trends  
- Average discount per shipping mode  
- Profit-to-cost ratio by product category  
- Top 10 customers by total sales  
- Profit or loss after discounts  
- Regions with negative profits  
- Average shipping cost per product category  
- Trends in order quantities over time  
- Most frequently used shipping modes  
- Total sales and profits by product category  
- Total discounts given by region  
- Unit price variation across customer segments  
- Customers with highest profit-to-sales ratio  
- Dates with the highest number of orders  
- Average profit per order  
- Customer segment purchase patterns by product category  
- Average order size by region  
- Customer distribution by region and segment  
- Number of unique customers per region  

(Full SQL queries available in `sales_analysis in SQL`)


