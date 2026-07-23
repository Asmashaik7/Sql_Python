/*Scenario

Manager:

"Show customers who have placed at least one order."

You have:

Customers and Orders.

IN

Think:

"Is this value present in the list?"

SELECT *
FROM Customers
WHERE CustomerID IN
(
    SELECT CustomerID
    FROM Orders
);
EXISTS

Think:

"Does at least one matching row exist?"

SELECT *
FROM Customers c
WHERE EXISTS
(
    SELECT 1
    FROM Orders o
    WHERE c.CustomerID = o.CustomerID
);
Difference (Interview)
IN → Compares values with a list.
EXISTS → Checks whether a matching row exists.
Performance
Small tables → Almost no difference.
Large tables → EXISTS is generally preferred because it can stop searching as soon as it finds the first match.
Remember
IN = List
EXISTS = Match Exists
Now practice.
-------------------------------------------
Tables

Customers

CustomerID	Name
1	    Asma
2	    Rahul
3	    John

Orders

OrderID	CustomerID
101	    1
102	    3
--------------------------------------
scenario: Show customers who have placed at least one order.
Q1
Write the query using IN.
select * from Customers
where customerID IN
    (select Customerid from orders)
--------------------------------------------------------
Q2
Write the same query using EXISTS.
select * from Customers c
where EXISTS
(SELECT 1 
from Orders o 
where c.customerid=o.customerid)

Q3

One-line answer:
When would you prefer EXISTS over IN?
based on the table size, may be i use exists for large tables. exists stops when it finds matching row.
it wont check all the table after finding a macthing one
*/
CREATE TABLE Customers
(
    CustomerID INT PRIMARY KEY,
    CustomerName VARCHAR(50),
    City VARCHAR(30)
);

INSERT INTO Customers
VALUES
(1,'Asma','Hyderabad'),
(2,'Rahul','Delhi'),
(3,'John','Mumbai'),
(4,'Sara','Chennai'),
(5,'David','Bangalore'),
(6,'Aisha','Hyderabad');

CREATE TABLE Orders
(
    OrderID INT PRIMARY KEY,
    CustomerID INT,
    ProductName VARCHAR(50),
    Amount INT,
    FOREIGN KEY (CustomerID) REFERENCES Customers(CustomerID)
);

INSERT INTO Orders
VALUES
(101,1,'Laptop',60000),
(102,1,'Mouse',800),
(103,3,'Keyboard',1500),
(104,5,'Monitor',12000),
(105,5,'Headphones',2500);

/*Notice:
Customer 1 has 2 orders.
Customer 3 has 1 order.
Customer 5 has 2 orders.
Customers 2, 4, and 6 have no orders.

This dataset is perfect for practicing IN and EXISTS.*/

/*Practice Questions (Run all in SSMS)
Level 1
Show customers who have placed at least one order using IN.*/
select customerid, customerName 
from customers 
where customerid IN(select customerid from Orders)
/*customerid	customerName
1	Asma
3	John
5	David*/

--Show the same result using EXISTS.
SELECT CustomerID, CustomerName
FROM Customers c
WHERE EXISTS
(
    SELECT 1
    FROM Orders o
    WHERE c.CustomerID = o.CustomerID
);
/*CustomerID	CustomerName
1	Asma
3	John
5	David*/
==================================pending-===================
Level 2
Show customers who have not placed any order using NOT IN.
select customerid, customerName 
from customers 
where customerid NOT IN(select customerid from Orders)
/*customerid	customerName
2	Rahul
4	Sara
6	Aisha*/

Show the same result using NOT EXISTS
SELECT CustomerID, CustomerName
FROM Customers c
WHERE NOT EXISTS
(
    SELECT 1
    FROM Orders o
    WHERE c.CustomerID = o.CustomerID
);

/*Suppose the Orders table becomes:

OrderID	CustomerID
101	1
102	NULL
103	3
104	5 Now run*/
SELECT CustomerID, CustomerName
FROM Customers
WHERE CustomerID NOT IN
(
    SELECT CustomerID
    FROM Orders
);
/*RESULT:
subquery returns (1, NULL, 3, 5)
Is 2 NOT IN (1, NULL, 3, 5)?
SQL doesn't know what NULL is. It means "unknown. 2 is definitely not in this list
TRUE ✅ → row returned
FALSE ❌ → row not returned
UNKNOWN ❌ → row not returned
o/p: (0 rows)
*/
=================================================================
Level 3
Display only the names of customers who placed orders.
select customerName 
from customers 
where customerID IN(select customerID from Orders)

or 

SELECT CustomerName
FROM Customers c
WHERE EXISTS
(
    SELECT 1
    FROM Orders o
    WHERE c.CustomerID = o.CustomerID
);

or 
select distinct customerName 
from customers c
left join orders o
where c.customerID=o.customerID

Display all order details along with the customer name.
SELECT
    o.OrderID,
    c.CustomerName,
    o.ProductName,
    o.Amount
FROM Customers c
INNER JOIN Orders o
ON c.CustomerID = o.CustomerID;
=========================================================
"Display only the customer names who ordered a Laptop."

Would you choose:

A. IN

B. EXISTS

C. JOIN

D. All of the above

Think about it before answering. There's an interesting discussion behind the correct choice. 😊

join

Good thinking! 👍 JOIN is definitely a correct solution.

For this particular question, though, the best interview answer is actually:

✅ D. All of the above

Let's see why.

Requirement

Display only the customer names who ordered a Laptop.

We only need:

CustomerName (from Customers)
Filter: customers who ordered Laptop

We are not displaying order details.

✅ Using JOIN
SELECT DISTINCT c.CustomerName
FROM Customers c
INNER JOIN Orders o
ON c.CustomerID = o.CustomerID
WHERE o.ProductName = 'Laptop';

Output:

CustomerName
Asma
✅ Using IN
SELECT CustomerName
FROM Customers
WHERE CustomerID IN
(
    SELECT CustomerID
    FROM Orders
    WHERE ProductName = 'Laptop'
);

Output:

CustomerName
Asma
✅ Using EXISTS
SELECT CustomerName
FROM Customers c
WHERE EXISTS
(
    SELECT 1
    FROM Orders o
    WHERE c.CustomerID = o.CustomerID
      AND o.ProductName = 'Laptop'
);

Output:

CustomerName
Asma
=====================================================================
Level 4 (Interview)
Show customers whose total order amount is greater than 10,000.
SELECT CustomerName
FROM Customers
WHERE CustomerID IN
(
    SELECT CustomerID
    FROM Orders
    GROUP BY CustomerID
    HAVING SUM(Amount) > 10000
);

--using EXISTS
SELECT CustomerName
FROM Customers
WHERE EXISTS
(
    SELECT 1
    FROM Orders o
    where c.CustomerID = o.CustomerID
    GROUP BY CustomerID
    HAVING SUM(o.Amount) > 10000
);

Show customers who have placed more than one order.

SELECT
    c.CustomerName,
    COUNT(*) AS TotalOrders
FROM Customers c
JOIN Orders o
ON c.CustomerID = o.CustomerID
GROUP BY c.CustomerID, c.CustomerName
HAVING COUNT(*) > 1;

============================================

Level 5 - Interview Question 1
🏢 Business Scenario
Your manager says:
"We want to identify our best customers. Show customers who have placed exactly 2 orders."

SELECT
    c.CustomerName,
    COUNT(*) AS TotalOrders
FROM Customers c
JOIN Orders o
ON c.CustomerID = o.CustomerID
GROUP BY c.CustomerID, c.CustomerName
HAVING COUNT(*) =2;

=============================================
Business Scenario
The Sales Manager wants to reward the companys highest-value customer.
Question:
Show the customer who has spent the highest total amount across all their orders.

SELECT top 1
    c.CustomerName,
    sum(amount) AS customer_Totalspent
FROM Customers c
JOIN Orders o
ON c.CustomerID = o.CustomerID
GROUP BY c.customerName,c.CustomerID
order by sum(amount) desc

==================================================
Interview Question 4
🏢 Business Scenario
The Sales Manager wants to launch a Laptop loyalty campaign.
Before sending promotional emails, they want to identify customers who have never purchased a Laptop.

Question

Display the names of customers who have never ordered a Laptop.
select customername
from customers c
where not exists
(select c.customerid 
from orders o
where c.customerid=o.customerid and o.productname='laptop'
)

============================================
SELECT 1 = NULL;
--SYNTAX ERROR--Incorrect syntax near '='.
SELECT 1 <> NULL;
--SYNTAX ERROR--Incorrect syntax near '<'.

================================================================
SELECT
    CASE
        WHEN 1 = NULL THEN 'TRUE'
        ELSE 'FALSE'
    END; 
--FALSE
=========================================================================
--CASE,WHEN
CREATE TABLE Employees
(
    EmpID INT PRIMARY KEY,
    EmpName VARCHAR(50),
    Department VARCHAR(30),
    Salary INT
);

INSERT INTO Employees
VALUES
(101,'Asma','IT',35000),
(102,'Rahul','HR',55000),
(103,'John','IT',85000),
(104,'Sara','Finance',45000),
(105,'David','HR',75000);

/*Scenario

Manager wants to categorize employees based on salary.

Salary < 50000 → Low
Salary between 50000 and 79999 → Medium
Salary >= 80000 → High
Q1

Write a query to display:

EmpID
EmpName
Salary
SalaryCategory

using CASE.

(No explanation. Just write the query.)*/
SELECT
    EmpID,
    EmpName,
    Salary,
   case
   when Salary < 50000 then'Low'
    when Salary> 50000 and salary <=79999 then'Medium'
    when Salary >= 80000 then 'High'
    end as salary_category
FROM Employees;
--"ELSE is executed when none of the WHEN conditions are true. If ELSE is omitted and no condition matches, SQL returns NULL."
--The important part is "returns NULL if ELSE is not provided