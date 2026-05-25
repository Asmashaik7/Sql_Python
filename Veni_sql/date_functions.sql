--1. GETDATE(): IT RETURNS CURRENT DATE AND TIME

SELECT GETDATE() as today_date
/*Result
today_date
2026-05-25 10:17:05.693*/

--2.CURRENT_TIMESTAMP
SELECT CURRENT_TIMESTAMP
/*(No column name)
2026-05-25 10:19:23.110*/

--2. SYSDATETIME()
SELECT SYSDATETIME()
/* (No column name)
2026-05-25 10:18:17.9340453*/

--4. GETUTCDATE()

SELECT GETUTCDATE()
/*(No column name)
2026-05-25 04:49:23.110*/

--5.EXTRACT DATE PARTS

SELECT YEAR(GETDATE())
/*(No column name)
2026*/

--6
SELECT MONTH(GETDATE())
/*(No column name)
5*/

--7
SELECT DAY(GETDATE())
/*(No column name)
25*/

--8
DATEPART()  -- EXTRACT SPECIFIC PART

SELECT DATEPART(DAY, GETDATE())
/*(No column name)
25*/

SELECT DATEPART(MONTH, GETDATE())
/*(No column name)
5*/

SELECT DATEPART(YEAR, GETDATE())
/*(No column name)
2026*/


===============================================
-- DATE CALCULATION FUNCTIONS

--9. DATEADD -- ADD OR SUBTRACT DATES

-- ADD 5 DAYS

SELECT DATEADD(DAY,10, GETDATE())
/*(No column name)
2026-06-04 10:30:11.900*/

SELECT DATEADD(DAY,-5, GETDATE())
/*(No column name)
2026-05-20 10:30:32.510*/

SELECT DATEADD(MONTH,-1, GETDATE())
/*(No column name)
2026-04-25 10:30:59.923*/

SELECT DATEADD(YEAR,-1, GETDATE())
/*(No column name)
2025-05-25 10:30:59.923*/
======================================================
--10. DATEDIFF()  -- DIFFERENCE BETWEEN TWO DATES
/* DATEDIFF() needs 2 dates.Those dates can come from:

1. hardcoded values
2. GETDATE()
3. table columns
4. another date function */

--1. using hardcoded value
SELECT DATEDIFF(DAY,'2026-05-01','2026-05-20')
/*(No column name)
19*/

SELECT DATEDIFF(MONTH,'2026-03-01','2026-05-20')
/*(No column name)
        2*/


SELECT DATEDIFF(YEAR,'2020-03-01','2026-05-20')
/*(No column name)
6*/
-------------------------------
--2. using getdate()
select datediff(year,'2015-04-26',getdate())
/*
(No column name)
11
*/
-------------------------------
--3.table columns
select empname, datediff(year,DOB,getdate()) as Age
from Employee_DatePractice
/*
empname	Age
Ravi	28
Priya	31
Arjun	26
Sneha	29
Kiran	27
Anu	    30
Vikram	33
Meera	25*/

---------------------------------------
--4. using two columns
SELECT
    EmpName,
    DATEDIFF(YEAR,DOB,DOJ) AS AgeWhenJoined
FROM Employee_DatePractice;
--values are approximate unless corrected with birthday logic.
/*
EmpName	AgeWhenJoined
Ravi	24
Priya	25
Arjun	24
Sneha	28
Kiran	26
Anu	29
Vikram	30
Meera	24
*/
================================================
--EOMONTH() -- END OF MONTH

SELECT EOMONTH(GETDATE())
/*(No column name)
2026-05-31*/
=========================================
