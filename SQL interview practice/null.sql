--NULL HANDLING

CREATE TABLE Customers_NULL
(
    CustomerID INT,
    CustomerName VARCHAR(50),
    Email VARCHAR(100),
    Phone VARCHAR(20)
);

INSERT INTO Customers_NULL
VALUES
(101, 'Ayesha', 'ayesha@email.com', '9876543210'),
(102, 'Rahul', 'rahul@email.com', NULL),
(103, 'Sara', 'sara@email.com', '9123456780'),
(104, 'Imran', 'imran@email.com', NULL),
(105, 'Priya', 'priya@email.com', '9988776655');

select * from Customers_NULL;

/*RESULT:
CustomerID	CustomerName	Email	            Phone
101	        Ayesha	        ayesha@email.com	9876543210
102     	Rahul	        rahul@email.com	    NULL
103     	Sara	        sara@email.com	    9123456780
104	        Imran	        imran@email.com	    NULL
105	        Priya	        priya@email.com	    9988776655

**First interview task

Your manager asks:

"Show me the CustomerID and CustomerName of customers whose phone number is missing."

Business requirement: Find customers where Phone is missing.*/

select CustomerID, CustomerName 
from Customers_NULL
where Phone IS NULL;
/*
CustomerID	CustomerName
102	Rahul
104	Imran
=============================================================================
Scenario 2 — Missing vs Available

Your manager now says:

"Now show me the customers who HAVE provided their phone number."

Write a query that returns:

CustomerID
CustomerName
Phone
*/
select CustomerID, CustomerName 
from Customers_NULL
where Phone IS NOT NULL;

/*
CustomerID	CustomerName
101	Ayesha
103	Sara
105	Priya
=========================================================================================

Scenario 3 — Handling NULL in a Calculation

Your manager gives you an order table:*/

CREATE TABLE Orders_NULL
(
    OrderID INT,
    CustomerID INT,
    Sales DECIMAL(10,2),
    Discount DECIMAL(10,2)
);


INSERT INTO Orders_NULL
VALUES
(1, 101, 1000, 100),
(2, 102, 1500, NULL),
(3, 103, 800, 50),
(4, 104, 2000, NULL),
(5, 105, 1200, 200);

SELECT *
FROM Orders_NULL;
/*
OrderID	CustomerID	Sales	Discount
1	    101	        1000.00	100.00
2	    102	        1500.00	NULL
3	    103	        800.00	50.00
4	    104	        2000.00	NULL
5	    105	        1200.00	200.00

Your manager says:
"Calculate the final amount for every order after discount."

Business rule:

Final Amount = Sales − Discount
*/

SELECT COALESCE(NULL, 0) from Orders_NULL;

SELECT Discount,
       COALESCE(Discount, 0) AS Discount_Handled
FROM Orders_NULL;
/*Discount	Discount_Handled
100.00	100.00
NULL	0.00
50.00	50.00
NULL	0.00
200.00	200.00*/


select orderID, CustomerID,sales,discount,
Sales - COALESCE(Discount, 0) AS  final_amt 
from orders_null;
/*
orderID	CustomerID	sales	discount	final_amt
1	101	1000.00	100.00	900.00
2	102	1500.00	NULL	1500.00
3	103	800.00	50.00	750.00
4	104	2000.00	NULL	2000.00
5	105	1200.00	200.00	1000.00*/