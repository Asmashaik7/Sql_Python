/* KCC-aggregate functions practice*/
--total customers in db
SELECT COUNT(*) AS TOTAL_CUSTOMERS FROM DBO.Customers 

--total customers in db
SELECT COUNT(CustomerName) FROM DBO.Customers 

SELECT COUNT(DISTINCT City) FROM DBO.Customers

SELECT COUNT(DISTINCT CookieName) AS Cookie_Count
FROM DBO.Product;

-- 3. Unique customers who placed orders
SELECT COUNT(DISTINCT CustomerID) AS unique_customers_with_orders
FROM Orders;

--Count total orders placed

SELECT COUNT(*) AS total_orders
FROM Orders;
--no of orders
SELECT COUNT(OrderID) AS no_of_orders
FROM DBO.Orders;

--Find number of unique customers who placed orders and print their names

SELECT CustomerName, COUNT(DISTINCT o.CustomerID) AS unique_customers_with_orders
FROM Orders o join Customers c on o.CustomerID=c.CustomerID
group by c.CustomerName;

--Orders + Order_Products

--Find total products sold (count all rows in Order_Products)

SELECT COUNT(*) AS total_products_sold
FROM DBO.Order_Product;

--Find total quantity of items sold (use SUM on Quantity column)

SELECT SUM(Quantity) AS total_quantity_sold
FROM Order_Product;

========================================
--Customers + Orders (JOIN Practice)

--Count how many orders each customer placed

SELECT c.CustomerName, COUNT(o.OrderID) AS total_orders
FROM Customers c
JOIN Orders o ON c.CustomerID = o.CustomerID
GROUP BY c.CustomerName;

--Find top 5 customers with the most orders

SELECT c.CustomerName, COUNT(o.OrderID) AS total_orders
FROM Customers c
JOIN Orders o ON c.CustomerID = o.CustomerID
GROUP BY c.CustomerName
ORDER BY total_orders DESC
OFFSET 0 ROWS FETCH NEXT 5 ROWS ONLY;

--or

SELECT top(5) c.CustomerName, COUNT(o.OrderID) AS total_orders
FROM Customers c
JOIN Orders o ON c.CustomerID = o.CustomerID
GROUP BY c.CustomerName
ORDER BY total_orders DESC;

--Find the total number of orders placed by each customer, but only show customers who have placed more than 2 orders.
SELECT C.CUSTOMERNAME, COUNT(O.ORDERID) AS TOTAL_NUMBER_OF_ORDERS 
FROM CUSTOMERS C 
JOIN ORDERS O ON C.CUSTOMERID=O.CUSTOMERID
GROUP BY C.CUSTOMERNAME
HAVING COUNT(O.ORDERID)>2;

--Find the total number of orders for each customer from California (CA),
--but only show customers who placed more than 3 orders.
select c.CustomerName, count(o.orderid) as Total_orders
from Customers c 
join orders o on c.CustomerID = o.CustomerID
where c.state='CA'
group by c.CustomerName
having count(o.orderid)>3;
