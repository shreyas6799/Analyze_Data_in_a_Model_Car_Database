USE mintclassics;

select *
from employees;
select *
from customers;
select *
from offices;
select *
from orderdetails;
select *
from orders;
select *
from payments;
select *
from productlines;
select *
from products;
select *
from warehouses;




#Data Understanding

#Inventory Overview

SELECT *
FROM products;

SELECT *
FROM orders;

SELECT *
FROM orderdetails;

# How many products are in inventory?
SELECT count(*) as total_products
FROM products;

#  What is the total quantity of products in stock?
SELECT sum(quantityInStock) as total_products_quantity
FROM products;

# What are the average, min, and max product prices?
SELECT avg(buyPrice) AS avg_price,
       min(buyPrice) AS min_price,
       max(buyPrice) AS max_price
FROM products;


#Categories and Suppliers

# How many product categories are there?
SELECT count(distinct(productLine)) AS product_categories
FROM products;

#Which suppliers provide which products?
SELECT  DISTINCT productVendor, productLine
FROM products
ORDER BY productVendor, productLine;



#🧾 Transactions

#What are the total sales over time (monthly)?
SELECT date_format(o.orderDate,'%M') as Order_Month,
	    sum(od.quantityOrdered * priceEach) as total_sales
FROM orders as o
JOIN orderdetails as od ON o.orderNumber = od.orderNumber
group by Order_Month;

#What are the top 5 best-selling products by units sold?
SELECT p.productName, 
	   SUM(od.quantityOrdered) AS units_sold
FROM products as p
JOIN orderdetails as od ON p.productCode = od.productCode
GROUP BY p.productName
ORDER BY units_sold DESC
LIMIT 5;

#Which products have never been sold?
SELECT p.productName
FROM products as p
LEFT JOIN orderdetails as od ON p.productCode = od.productCode
WHERE od.quantityOrdered is NULL;


#Customers & Employees

#How many customers are there in each country?
SELECT count(distinct customerNumber) as customerss, country
FROM customers
GROUP BY country;

#How many customers does each sales rep manage?
SELECT concat(e.firstName, ' ', e.lastName) as Sales_Representative,
       count(c.customerNumber) as customer_count, 
       c.salesRepEmployeeNumber
FROM customers as c
JOIN employees as e ON c.salesRepEmployeeNumber = e.employeeNumber
WHERE c.salesRepEmployeeNumber is not NULL
GROUP BY c.salesRepEmployeeNumber;

#Data Quality & Unknown Variables

#Are there NULL values in critical product fields?
SELECT *
FROM products
WHERE coalesce(productName , productLine, productScale, productVendor,
               productDescription , quantityInStock , warehouseCode, 
               buyPrice ,MSRP) is NULL;
               
#Are there duplicate product entries?
SELECT productCode
FROM products
group by productCode
HAVING COUNT(productCode) > 1;

#Are there fields with unclear or inconsistent values?” 
SELECT * 
FROM products
WHERE MSRP < buyPrice
OR quantityInStock < 0
OR  buyPrice <= 0 OR MSRP <= 0;



#Analysis Techniques

#Performance Analysis

# Which products have the highest turnover rate (sold vs. stock)?
SELECT p.productName,
	   sum(od.quantityOrdered)/p.quantityInStock as turnover_rate
FROM products as p
JOIN orderdetails AS od ON p.productCode = od.productCode
GROUP BY p.productName,p.quantityInStock
ORDER BY turnover_rate DESC
LIMIT 5;

#Which suppliers have the shortest and longest lead times ?
WITH vendor_lead_time as(
SELECT p.productVendor, ROUND(AVG(datediff(o.shippedDate, o.orderDate)), 1) as lead_time
FROM products as p
JOIN orderdetails as od ON p.productCode = od.productCode
JOIN orders as o ON od.orderNumber = o.orderNumber
GROUP BY p.productVendor)
SELECT *
FROM (
SELECT *
FROM vendor_lead_time
ORDER BY lead_time DESC
LIMIT 1) AS slowest_vendor

UNION ALL

SELECT *
FROM (
SELECT *
FROM vendor_lead_time
ORDER BY lead_time ASC
LIMIT 1) AS fastest_vendor;


#Transactions / Sales Overview
#How does inventory (or sales) change over time?
SELECT 
      date_format(o.orderDate, '%Y-%m') as months,
      count(DISTINCT o.orderNumber) as total_order,
      sum(od.quantityOrdered) as total_unit_sold,
      sum(od.quantityOrdered* od.priceEach) as revenue
FROM orders as o
JOIN orderdetails as od ON o.orderNumber = od.orderNumber
GROUP BY months
ORDER BY months ASC;

 #Are there seasonal patterns in demand?
 SELECT monthname(o.orderDate) as months,
        SUM(od.quantityOrdered) as unit_sold
 FROM orders as o
 JOIN orderdetails as od ON o.orderNumber = od.orderNumber
 GROUP BY months
 ORDER BY unit_sold DESC;
 
 #Problem Detection
#Which products had no sales in the past 6 months?
SELECT 
      p.productName, 
      p.productCode
FROM products as p
LEFT JOIN orderdetails as od ON p.productCode = od.productCode
LEFT JOIN orders as o ON od.orderNumber = o.orderNumber
GROUP BY  p.productName, p.productCode
HAVING max(o.orderDate) < curdate() - interval 6 month;

#Are there stockouts or overstock situations?
SELECT productName,quantityInStock
FROM products
WHERE quantityInStock = 0 
      OR quantityInStock > 10000;
      
# Insights and Conclusions

#Operational Improvements
# Which products should be restocked soon?
SELECT
      productName,
      quantityInStock
FROM products
WHERE quantityInStock < 1000 
ORDER BY quantityInStock asc;

#What low-performing products could be discontinued?
SELECT p.productName, 
       sum(od.quantityOrdered) as unit_sold
FROM products AS p 
LEFT JOIN orderdetails as od ON p.productCode = od.productCode
LEFT JOIN orders as o ON od.orderNumber = o.orderNumber
GROUP BY p.productName
ORDER BY unit_sold ASC
LIMIT 5;

# Which suppliers should be prioritized?
SELECT p.productVendor, sum(od.quantityOrdered) as unit_sold
FROM products as p
JOIN orderdetails as od ON p.productCode = od.productCode
GROUP BY p.productVendor
ORDER BY unit_sold DESC
LIMIT 5;

#Strategic Decisions
# Which product categories generate the most revenue?
SELECT productLine, 
       SUM(od.quantityOrdered*od.priceEach) as revenue
FROM products AS p
JOIN orderdetails AS od ON p.productCode = od.productCode
GROUP BY productLine
ORDER BY revenue DESC
LIMIT 5;

#Which products will run out before new stock arrives?
SELECT p.productCode,
       p.productName,
	   p.quantityInStock,
       ROUND(sum(od.quantityOrdered)/count(DISTINCT DATE_FORMAT(o.orderDate, '%Y-%m')), 2) as Avergae_Quantity_Per_Month,
       ROUND(p.quantityInStock/ROUND(sum(od.quantityOrdered)/count(DISTINCT DATE_FORMAT(o.orderDate, '%Y-%m')), 2), 1) as until_stockout
FROM products as p
JOIN orderdetails as od ON p.productCode = od.productCode
JOIN orders as o ON od.orderNumber = o.orderNumber
GROUP BY p.productCode, p.productName
ORDER BY  p.quantityInStock;
