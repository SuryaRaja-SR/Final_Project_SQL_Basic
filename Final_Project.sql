# Selecting the database
USE guvi;

# Question 1 - 
# Write a query to get the customerid, full name of the customer and the present age of the customer
# Table required -> customers

SELECT CustomerID, CONCAT(Firstname, Lastname) Full_Name, TIMESTAMPDIFF(YEAR,date_of_birth,NOW()) Age
FROM customers;


# Question 2 - 
# Write a query to get the number of characters in first name and the respective count of customers 
# Table required -> customers

SELECT LENGTH(FirstName), COUNT(CustomerID)
FROM customers
GROUP BY LENGTH(FirstName);

# Question 3 - 
# Write a query to get the distinct number of customers from United States that made orders in 1st quarter of year 2021
# Table required -> customers and orders

SELECT DISTINCT(o.customerID) CustomerID, c.Country, QUARTER(o.orderdate) Quarter_No, YEAR(o.orderdate) Year_
FROM orders o
INNER JOIN customers c ON 
o.customerID = c.customerID
WHERE QUARTER(o.orderdate) = 1 AND YEAR(o.orderdate) = 2021 AND c.Country = 'United States';

# Question 4 - 
# Write a query to get the total number of orders made in year 2020 and 2021 every week

SELECT count(orderdate) No_of_Orders, Week(orderdate) Week, Year(orderdate) Year 
FROM orders
WHERE Year(orderdate) IN (2020, 2021)
GROUP BY week(orderdate), Year(orderdate);

# Question 5 - 
# Get the Description of customer along with the Customerid and Domain of their email
# The Final output should contain this columns Customerid, Domain of their email, Description.
# Get the details of description from the below attached sample output Description_ column.
# Sort the result by DateEntered desc, if date entered is same then CustomerId in ascending.

# Description Sample -
# Malcom Julian was born on 8th March 1985 has ordered 12 orders yet.

# Note- All letters are case sensetive take same case letters as given in sample output Description_. 
# Every Day value will have 'th' in front of it.
# Tables needed -> customers, orders 

SELECT o.CustomerID, c.Email, concat(c.FirstName, ' ', c.LastName, ' was born on ', Day(c.Date_of_Birth),'th ', Monthname(c.Date_of_Birth), ' ', Year(c.Date_of_Birth), ' has ordered ', Order_ID, ' orders yet') Description
FROM customers c
INNER JOIN (SELECT CustomerID, count(OrderID) Order_ID FROM orders GROUP BY CustomerID) o
ON c.CustomerID = o.CustomerID
ORDER BY c.DateEntered desc, o.CustomerID;

# Question 6 - 
# The company wants to see if the shippers are delivering the orders on weekends or not.
# So for that, they want to see the number of orders delivered on a particular weekday.
# Print DayName, count of orders delivered on that day in the descending order of count of orders.
# Tables needed -> products

SELECT Dayname(DeliveryDate) Day_of_Delivery, count(OrderID) Count_of_Orders 
FROM orders 
GROUP BY Dayname(DeliveryDate) 
ORDER BY count(OrderID) desc;

# Question 7 - 
# Write a query to find the average revenue for each order whose difference between 
# the order date and ship date is 3.
# Use the total order amount to calculate the revenue. 
# Print the order ID, customer ID, average revenue, and sort them in increasing order of the order ID.
# Tables needed -> orders

SELECT OrderID, CustomerID, ROUND(AVG(Total_order_amount),2) Average_Revenue
FROM orders 
WHERE Datediff(ShipDate, OrderDate) = 3
GROUP BY OrderID, CustomerID
ORDER By OrderID;

# Question 8 -
# Count the number of Suppliers based out of each Country.
# Print the following sentence:
# For Example : if the number of suppliers are more than 1 then print 
# 'There are 100 Suppliers from France' else print 'There is 1 Supplier from France'
# Order the output in ascending order of country.
# Note: All characters are case sensitive.
# Tables needed -> suppliers

SELECT Country, CASE WHEN No_of_Suppliers  > 1 THEN 'There are 100 Suppliers from France' ELSE 'There is 1 Supplier from France' END as Sentence  FROM (
SELECT Country, count(SupplierID) No_of_Suppliers 
FROM suppliers
GROUP BY Country ORDER BY Country) as T;








