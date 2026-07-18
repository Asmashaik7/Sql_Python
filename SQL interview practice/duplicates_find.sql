create database int_practice;
use int_practice
-- Create Table
CREATE TABLE Invoices (
    InvoiceID INT,
    CustomerID INT,
    Amount DECIMAL(10,2)
);

-- Insert Sample Data
INSERT INTO Invoices (InvoiceID, CustomerID, Amount)
VALUES
(101, 1, 500),
(102, 2, 700),
(101, 1, 500),
(103, 3, 900),
(104, 2, 600),
(104, 2, 600);

SELECT * FROM Invoices;
==============================================
/*Task
Now write the query that shows:
InvoiceID
CustomerID
Amount
ROW_NUMBER()*/
 select InvoiceID,
CustomerID,
Amount,
ROW_NUMBER() over(partition by InvoiceID order by InvoiceID) as RowNum
from Invoices

RESULT:
InvoiceID	CustomerID	Amount	RowNum
101	        1	        500.00	1
101	        1	        500.00	2
102	        2	        700.00	1
103	        3	        900.00	1
104	        2	        600.00	1
104	        2	        600.00	2

select * from
(
select InvoiceID,
CustomerID,
Amount,
ROW_NUMBER() over(partition by InvoiceID order by InvoiceID) as RowNum
from Invoices
) as t
where RowNum>1

/*RESULT:
InvoiceID	CustomerID	Amount	RowNum
101	        1	        500.00	2
104	        2	        600.00	2*/

select * from
(
select InvoiceID,
CustomerID,
Amount,
ROW_NUMBER() over(partition by InvoiceID order by InvoiceID) as RowNum
from Invoices
) as t
where RowNum>1

/*RESULT:
InvoiceID	CustomerID	Amount	RowNum
101	1	500.00	2
104	2	600.00	2*/
===========================
--deleting dupicate rows using DERIVED table
delete t 
from
(
select InvoiceID,
CustomerID,
Amount,
ROW_NUMBER() over(partition by InvoiceID order by InvoiceID) as RowNum
from Invoices
) as t
where RowNum>1

/*The DELETE t tells SQL Server:
"Delete the rows represented by the derived table alias t.*/

select * from Invoices

/*RESULT:
InvoiceID	CustomerID	Amount
102	            2	700.00
101	            1	500.00
103	            3	900.00
104	            2	600.00*/

======================================================================
--deleting dupicate rows using CTE
=======================================================================
with duplicateCTEs
as
(
    select InvoiceID,
    CustomerID,
     Amount,
     ROW_NUMBER() over(partition by InvoiceID order by InvoiceID) as RowNum
       from Invoices
   )
where RowNum>1
--to check the duplicates
select * from duplicateCTEs where RowNum>1

delete from duplicateCTEs where RowNum>1

==================================================
/*"How do you delete duplicates?"

A strong answer is:

Clarify what defines a duplicate.
Use ROW_NUMBER() with PARTITION BY.
Verify duplicates using SELECT.
Delete rows where RowNum > 1.
Validate the remaining data after deletion.

That's a complete, business-oriented answer

Approach	            Interview Frequency	        Easy to Read
CTE + DELETE	        ⭐⭐⭐⭐⭐ Very common	        ⭐⭐⭐⭐⭐
Derived Table + DELETE	⭐⭐⭐ Common	                 ⭐⭐⭐⭐
JOIN	                ⭐⭐⭐⭐ Common	            ⭐⭐⭐
Subquery	            ⭐⭐⭐ Common	                ⭐⭐⭐*/