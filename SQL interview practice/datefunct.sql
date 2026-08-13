/* DATE FUNCTIONS

Function				What it does							Easy memory
GETDATE()				Gives today's date + current time		What is now?
YEAR(date)				Extracts the year						Get year
MONTH(date)				Extracts the month number				Get month
DAY(date)				Extracts the day number					Get day
DATEPART(part, date)	Extracts a specific part of a date		Get a part
DATEDIFF(part, start, end)	Finds the difference between two dates			 far apart?
DATEADD(part, number, date)	Adds/subtracts time from a date					Move the date
EOMONTH(date)				Gives the last day of that month				Month end
The important distinction

YEAR, MONTH, DAY:

YEAR(OrderDate)
MONTH(OrderDate)
DAY(OrderDate)

These are simple ways to extract common date parts.

DATEPART() is more flexible:

DATEPART(QUARTER, OrderDate)
DATEPART(WEEK, OrderDate)
DATEPART(WEEKDAY, OrderDate)

So remember:

YEAR/MONTH/DAY → common parts
DATEPART → more specific parts

Your manager asks:

"Create a report for our orders. 
For each order, show the order year, order month, the quarter in which it was placed, how many days it took to deliver, 
and the last day of the order's month."*/

select OrderID,
year(OrderDate) as OrderYear,
month(OrderDate) as OrderMonth,
datepart(quarter,OrderDate) as OrderQuarter,
datediff(day,OrderDate,DeliveryDate) as days_to_deliver,
eomonth(OrderDate) as MonthEndDate
from date_orders;


/* Now let's combine them
Imagine you're a Junior Data Analyst at an e-commerce company.

You have an Orders table:

OrderID
OrderDate
DeliveryDate
CustomerID
Sales


Practice Table: Orders

Run this in SSMS:*/

CREATE TABLE date_Orders (
    OrderID INT,
    CustomerID INT,
    OrderDate DATE,
    Sales DECIMAL(10,2)
);

INSERT INTO date_Orders (OrderID, CustomerID, OrderDate, Sales)
VALUES
(101, 1001, '2026-08-10', 2500.00),
(102, 1002, '2026-08-05', 1800.00),
(103, 1003, '2026-07-25', 3200.00),
(104, 1004, '2026-07-15', 1500.00),
(105, 1005, '2026-06-20', 2750.00),
(106, 1006, '2026-08-01', 4200.00),
(107, 1007, '2026-07-10', 2100.00),
(108, 1008, '2026-05-30', 3500.00);

select * from date_Orders; 
/*
OrderID	CustomerID	OrderDate	Sales
101	1001	2026-08-10	2500.00
102	1002	2026-08-05	1800.00
103	1003	2026-07-25	3200.00
104	1004	2026-07-15	1500.00
105	1005	2026-06-20	2750.00
106	1006	2026-08-01	4200.00
107	1007	2026-07-10	2100.00
108	1008	2026-05-30	3500.00*/

/*What's the difference between DATEDIFF() and DATEADD()?

Think:

DATEDIFF → How far apart are two dates?

DATEDIFF(DAY, OrderDate, DeliveryDate)

DATEADD → Move a date forward/backward.

DATEADD(DAY, 30, OrderDate)

First, remember these two

GETDATE() → What is now?

GETDATE()

DATEADD() → Move a date

DATEADD(DAY, -30, GETDATE())    
 =========================================================   

Your task

Manager asks:

"Find all customers who placed orders in the last 30 days. Show OrderID, CustomerID, OrderDate and Sales."*/

select OrderID, 
CustomerID, 
OrderDate,
sales
from date_orders 
where OrderDate<dateadd(day,-30,getdate())
/*
OrderID	CustomerID	OrderDate	sales
105	1005	2026-06-20	2750.00
107	1007	2026-07-10	2100.00
108	1008	2026-05-30	3500.00 this is the mistake, gives output of orders whcih are less than 30 days. i kept comparison operator <, i ned to keep >= */
select OrderID, 
CustomerID, 
OrderDate,
sales
from date_orders 
where OrderDate>=dateadd(day,-30,getdate())
--now i will get the orders whcih are greater than the 14-july, whihc is 30 days minus date.
/*Result:
OrderID	CustomerID	OrderDate	sales
101	1001	2026-08-10	2500.00
102	1002	2026-08-05	1800.00
103	1003	2026-07-25	3200.00
104	1004	2026-07-15	1500.00
106	1006	2026-08-01	4200.00
====================================
Next Scenario — Future Dates

You're working with the same date_orders table.

Your manager asks:

"For every order, calculate the date that is exactly 7 days after the order was placed."

You need to show:

OrderID
OrderDate
ExpectedFollowUpDate*/

select OrderID,
OrderDate,
dateadd(day,7,orderdate)as ExpectedFollowUpDate
from date_orders

/*
OrderID	OrderDate	ExpectedFollowUpDate
101	2026-08-10	2026-08-17
102	2026-08-05	2026-08-12
103	2026-07-25	2026-08-01
104	2026-07-15	2026-07-22
105	2026-06-20	2026-06-27
106	2026-08-01	2026-08-08
107	2026-07-10	2026-07-17
108	2026-05-30	2026-06-06*/

========================================================================
ALTER TABLE date_orders
ADD DeliveryDate DATE;

UPDATE date_orders
SET DeliveryDate = CASE OrderID
    WHEN 101 THEN '2026-08-12'
    WHEN 102 THEN '2026-08-08'
    WHEN 103 THEN '2026-07-29'
    WHEN 104 THEN '2026-07-20'
    WHEN 105 THEN '2026-06-25'
    WHEN 106 THEN '2026-08-05'
    WHEN 107 THEN '2026-07-14'
    WHEN 108 THEN '2026-06-05'
END;

select * from date_orders;
/* Result:
OrderID	CustomerID	OrderDate	Sales	DeliveryDate
101	1001	2026-08-10	2500.00	2026-08-12
102	1002	2026-08-05	1800.00	2026-08-08
103	1003	2026-07-25	3200.00	2026-07-29
104	1004	2026-07-15	1500.00	2026-07-20
105	1005	2026-06-20	2750.00	2026-06-25
106	1006	2026-08-01	4200.00	2026-08-05
107	1007	2026-07-10	2100.00	2026-07-14
108	1008	2026-05-30	3500.00	2026-06-05

Calculate:

OrderID
OrderDate
DeliveryDate
DeliveryDays

The business question is:

"How many days did each order take to deliver?"
*/
select OrderID,
OrderDate,
DeliveryDate,
datediff(day,OrderDate,DeliveryDate) as DeliveryDays
from date_orders;
/*
OrderID	OrderDate	DeliveryDate	DeliveryDays
101	2026-08-10	2026-08-12	2
102	2026-08-05	2026-08-08	3
103	2026-07-25	2026-07-29	4
104	2026-07-15	2026-07-20	5
105	2026-06-20	2026-06-25	5
106	2026-08-01	2026-08-05	4
107	2026-07-10	2026-07-14	4
108	2026-05-30	2026-06-05	6


===============================================================================


*/
