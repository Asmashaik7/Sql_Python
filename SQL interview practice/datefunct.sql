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

🔥 Now let's combine them
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
/*Your manager asks:

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
    */

