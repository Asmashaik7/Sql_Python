SELECT * FROM orders

/*before adding date column
order_id	customer_id	Amount
101	        1	        1200.00
102     	2       	800.00
103	        1       	2100.00
104     	3       	500.00
105	        3	        1500.00
*/

ALTER TABLE ORDERS add orderdate date
/* after adding a date column
order_id	customer_id	Amount	orderdate
101	1	1200.00	NULL
102	2	800.00	NULL
103	1	2100.00	NULL
104	3	500.00	NULL
105	3	1500.00	NULL*/

--updating orderdate with dates
UPDATE Orders
SET OrderDate = '2026-05-20'
WHERE order_id = 101;

UPDATE Orders
SET OrderDate = '2026-05-22'
WHERE order_id = 102;

UPDATE Orders
SET OrderDate = '2026-05-24'
WHERE order_id = 103;

UPDATE Orders
SET OrderDate = '2026-05-10'
WHERE order_id = 104;

UPDATE Orders
SET OrderDate = '2026-05-25'
WHERE order_id = 105;

select * from orders
/*after inserting dates in doj column
order_id	customer_id	Amount	orderdate
101	1	1200.00	2026-05-20
102	2	800.00	2026-05-22
103	1	2100.00	2026-05-24
104	3	500.00	2026-05-10
105	3	1500.00	2026-05-25*/
===================================================================================
--ASSIGNMENT

--- LAST 7 DAYS ORDERS
SELECT *
FROM Orders
WHERE OrderDate > DATEADD(DAY, -7, GETDATE());
/*order_id	customer_id	Amount	orderdate
101	1	1200.00	2026-05-20
102	2	800.00	2026-05-22
103	1	2100.00	2026-05-24
105	3	1500.00	2026-05-25
*/
--SQL simply displays:
--Today is 25th May. -7 means 19th May.all the rows which satisfy below 19th May will be displayed.
-- Either we have 1 row or many it displays records within that date. not exactly 7 records count.
--all rows after May 19
--only dates that actually exist in table.

SELECT * 
FROM ORDERS 
WHERE ORDERDATE >= DATEADD(DAY,-2,GETDATE())
/*
order_id	customer_id	Amount	orderdate
103	1	2100.00	2026-05-24
105	3	1500.00	2026-05-25*/
---------------------------------------------------------

-- CURRENT MONTH orders 
SELECT * 
FROM ORDERS 
WHERE MONTH(ORDERDATE) = MONTH(GETDATE())
--we only inserted MAY month data in the table. so its returning all records.

--lets update a record with another month
UPDATE Orders
SET OrderDate = '2026-04-15'
WHERE order_id = 104;

SELECT * 
FROM ORDERS 
WHERE MONTH(ORDERDATE) = MONTH(GETDATE())
/*
order_id	customer_id	Amount	orderdate
101	1	1200.00	2026-05-20
102	2	800.00	2026-05-22
103	1	2100.00	2026-05-24
105	3	1500.00	2026-05-25*/
--------------
SELECT * 
FROM ORDERS 
WHERE YEAR(ORDERDATE) = YEAR(GETDATE())
   AND MONTH(ORDERDATE) = MONTH(GETDATE())
/*
order_id	customer_id	Amount	orderdate
101	1	1200.00	2026-05-20
102	2	800.00	2026-05-22
103	1	2100.00	2026-05-24
105	3	1500.00	2026-05-25*/
--as we have only 2026 data, all records are displayed
-------------------------------------------------------------------