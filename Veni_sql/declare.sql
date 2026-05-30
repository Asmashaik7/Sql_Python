--What is a variable
--------------------
--A Variable is a temporary storage location used to hold a value during query execution.

--1. WHEN WE WANT TO REUSE VALUES
--2. WHEN WE ARE WORKING CONDITIONS
--3. WHEN WE ARE HANDLING DYNAMIC OR CHANGING VALUES
--4. FOR CALCULATIONS
--5. INSIDE STORED PROCEDURES


--When to Use Table Variables
--=======================
-- Data is small
-- Logic is simple
-- Used inside stored procedures/functions
-- Temporary and quick calculations

--HOW TO CREATE A VARIABLE
------------------------
--STEP 1 --> DECLARE A VARIABLE

 --DECLARE @VARIABLENAME DATATYPE
 --Ex:DECLARE @AGE INT

--STEP 2 --> ASSIGN A VALUE
 
--SET @VARIABLENAME=VALUE
--EX: SET @AGE =35
--We should execute both DECLARE and SET at a time, as it is a temp variable.
======================================
--VARIABLE IN CALCULATIONS
DECLARE @AGE INT
SET @AGE =35

SELECT @AGE AS AGE
/*
AGE
35
*/

DECLARE @A INT,@B INT
SET @A=10
SET @B=20
SELECT @A*@B
========================================
-- USING VARIABLE IN QUERY

DECLARE @SAL INT=450000

SELECT 
 *
FROM EMPLOYEES WHERE SALARY>@SAL
/*
EMPID	NAME	Department	Salary
1	A	IT	500000
2	B	IT	600000
3	C	IT	600000
*/
-------------------------------------------------
--when working woth conditions
DECLARE @MARKS INT =60--here if i change 60 to 30, if i run it takes 30 only. its temp variable and dont remember older values.

IF @MARKS >= 35
   PRINT 'PASS'
ELSE
   PRINT 'FAIL'
--o/p: PASS
===================================================================
--Using in DYNAMIC values

Declare @dept varchar(15)='HR'
select 
    *
    from department
    where dname =@dept
/*
DNO	DNAME	LOCATION
10	HR	HYD*/

========================================
/* TYPES OF VARIABLES

1)Local Variables  -- Start with @ and it is available only within the current batch/block/procedure
2)Global Variables  -- system variables sys related info-- start with @@ (@@VERSION,@@ROWCOUNT,@@ERROR,@IDENTITY)
3)Table Variables   -- To store multiple rows like a temporary table

1. local variables: all the above examples are local variables
2. global variables: 
rowcount-*/
select @@VERSION AS VERSION
/*VERSION
Microsoft SQL Server 2022 (RTM) - 16.0.1000.6 (X64)   Oct  8 2022 05:58:25   Copyright (C) 2022 Microsoft Corporation  Developer Edition (64-bit) on Windows 10 Home Single Language 10.0 <X64> (Build 26200: ) (Hypervisor) 
*/
-----------
--I want to update a sal and check how many rows are being affected?

use sphoorthiDB

select * from employees

update employees
set salary=salary+5000

select @@rowcount as Modified_salary

/*
Modified_salary
5
*/
--if i have 10 millions of data, thnr this global var @@rowcount is very helpful. we can know how many rows gt modeified.
@@ERROR
--gives last error
@@identity
--gives last updated row
-------------------------------------
--Table variable: It is helpful to store multiple rows like a temporary table.

DECLARE @TABLENAME TABLE(
     COLUMN1 DATATYPE,
     COLUMN2 DATATYPE ETC
   )

declare @empvar table(
        empid int,
        ename varchar(10)
        )

insert into @empvar values(101,'Asma'),(102,'Shaik')
select * from @empvar
/*
empid	ename
101	Asma
102	Shaik*/
--It exists during execution only
-----------------------------------------


