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
COALESCE() — Definition

COALESCE() returns the first non-NULL value from a list of expressions. 
It is commonly used to handle NULL values by providing a fallback value.


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
5	105	1200.00	200.00	1000.00

Remember this pattern: COALESCE(column, replacement_value)
Use Discount; if it's NULL, use 0.

And it can be used inside calculations:

Sales - COALESCE(Discount, 0)
=======================================================================
--Next: ISNULL() vs COALESCE()
Scenario 4 — Missing Customer Phone

Your customer-support manager says:

"When we generate the customer report, don't show NULL for missing phone numbers. Show 'Not Provided' instead."*/
select *
from Customers_NULL;

select CustomerName,coalesce(Phone,'Not Provided') as Phone_status
from Customers_NULL;
/*
CustomerName	Phone_status
Ayesha	9876543210
Rahul	Not Provided
Sara	9123456780
Imran	Not Provided
Priya	9988776655

One small refinement for interviews

Don't say "COALESCE replaces the NULL in the table."

It doesn't actually change the stored data.

It returns a replacement value in the query result.
If you run:

SELECT
    OrderID,
    COALESCE(Discount, 0) AS Discount_Handled
FROM Orders_NULL;

You get:

OrderID	Discount_Handled
1	100
2	0
3	50

It looks like the NULL became 0.

But the actual table is still:

OrderID	Discount
1	100
2	NULL
3	50

If you run:

SELECT *
FROM Orders_NULL;

Order 2's Discount is still NULL.

🧠 So there are two different ideas

1. Handle NULL in a query

COALESCE(Discount, 0)

➡️ Changes the query result only.
➡️ Original table remains unchanged.

2. Actually change the stored data

That requires something like:

UPDATE Orders_NULL
SET Discount = 0
WHERE Discount IS NULL;

➡️ This really changes the table.

🎤 Interview tip

If an interviewer asks:

"Does COALESCE() update the NULL values in the table?"

You can say:

"No. COALESCE only handles NULL values in the query result. It doesn't modify the underlying table data unless it's used as part of an UPDATE statement."

And one more important point: NULL handling doesn't always mean replacing the data. Sometimes we simply filter NULLs with IS NULL / IS NOT NULL, sometimes we substitute a value with COALESCE(), and sometimes we leave NULL as it is but account for it correctly in calculations.

==========================================================================================
Scenario 5 — Best Available Contact

You're a Junior Data Analyst at an e-commerce company.

The customer-support team wants one contact value for every customer.

Their priority is:

Use PersonalPhone if available.
If PersonalPhone is NULL → use WorkPhone.
If both are NULL → use Email.
If all three are NULL → show 'No Contact'.
Create this table

Run in SSMS:*/

CREATE TABLE CustomerContact
(
    CustomerID INT,
    CustomerName VARCHAR(50),
    PersonalPhone VARCHAR(20),
    WorkPhone VARCHAR(20),
    Email VARCHAR(100)
);


INSERT INTO CustomerContact
VALUES
(101, 'Ayesha', '9876543210', '8888888888', 'ayesha@email.com'),
(102, 'Rahul', NULL, '8777777777', 'rahul@email.com'),
(103, 'Sara', NULL, NULL, 'sara@email.com'),
(104, 'Imran', NULL, NULL, NULL),
(105, 'Priya', '9999999999', NULL, 'priya@email.com');

SELECT *
FROM CustomerContact;

/*RESULT:
CustomerID	CustomerName	PersonalPhone	WorkPhone	Email
101	        Ayesha	        9876543210	    8888888888	ayesha@email.com
102	        Rahul	        NULL	        8777777777	rahul@email.com
103	        Sara	        NULL	        NULL	    sara@email.com
104	        Imran	        NULL	        NULL	    NULL
105	        Priya	        9999999999	    NULL	    priya@email.com

Business requirement

The manager asks:

"Show CustomerName and the best available contact using our priority order."
*/
select CustomerName,
coalesce(PersonalPhone,WorkPhone,Email,'No contact') as Best_contact
from CustomerContact;
/*
CustomerName	Best_contact
Ayesha	9876543210
Rahul	8777777777
Sara	sara@email.com
Imran	No contact
Priya	9999999999
*/

===============================================================

