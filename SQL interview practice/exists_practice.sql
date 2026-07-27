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

select * from Customers;

CREATE TABLE Orders
(
    OrderID INT PRIMARY KEY,
    CustomerID INT,
    ProductName VARCHAR(50),
    Amount INT,
    FOREIGN KEY(CustomerID)
    REFERENCES Customers(CustomerID)
);

INSERT INTO Orders
VALUES
(101,1,'Laptop',60000),
(102,1,'Mouse',800),
(103,3,'Keyboard',1500),
(104,5,'Monitor',12000),
(105,5,'Headphones',2500);

/*
Question 1
Display the names of customers who have placed exactly 2 orders.*/

select CustomerName, count(o.orderId) as orders_count
from customers c
join orders o
on c.CustomerID=o.CustomerID
group by c.customerID,c.CustomerName
having count(o.orderId)=2
/*
CustomerName	orders_count
Asma	        2
David	        2*/

----------------------------------------------------------------------------------
--Customers with at least 2 orders
select CustomerName, count(o.orderId) as orders_count
from customers c
join orders o
on c.CustomerID=o.CustomerID
group by c.customerID,c.CustomerName
having count(o.orderId)>=2

/*
CustomerName	orders_count
Asma	        2
David	        2*/

/*  One important interview lesson

Whenever you see these requirements:

Exactly 2 orders
At least 2 orders
More than 5 employees
Less than 3 products
Customers with 10 or more purchases

Your brain should immediately think:

JOIN
→ GROUP BY
→ COUNT()
→ HAVING

Highest salary
Highest spending customer
Top-selling product
Most expensive item
Customer with maximum orders

Your brain should automatically think:

GROUP BY
→ Aggregate (SUM / COUNT / MAX ...)
→ ORDER BY ... DESC
→ TOP 1
*/
-----------------------------------------------------------------------
--Display the highest spending customer.

select top 1
    c.CustomerName,
    sum(o.amount) as total_Spent
from Customers c
join orders o
on c.customerID=o.customerID
group by 
    c.CustomerID,
    c.CustomerName
order by 
    sum(o.amount) desc
/*
CustomerName	total_Spent
Asma	60800*/

---------------------------------------------------------------------------
