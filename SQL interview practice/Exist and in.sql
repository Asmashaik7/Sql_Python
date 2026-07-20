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

--Show the same result using EXISTS.
select customerid, customerName 
from customers c
where EXISTS (select 1 from Orders o where c.customerid=o.customerid)

==================================pending-===================
Level 2
Show customers who have not placed any order using NOT IN.
Show the same result using NOT EXISTS.
Level 3
Display only the names of customers who placed orders.
Display all order details along with the customer name.
Level 4 (Interview)
Show customers whose total order amount is greater than 10,000.
Show customers who have placed more than one order.







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