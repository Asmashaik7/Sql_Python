/*IF Conditions:
=============
In SQL Server, the IF condition is used to control the flow of execution in T-SQL (Transact-SQL). It allows you to run certain statements only when a condition evaluates to TRUE. This is essential for writing procedural logic inside scripts, stored procedures, and functions.

Types of IF Conditions in SQL Server
====================================
1)Simple IF

Executes a block of code if the condition is true.

IF condition
   statement
*/

IF (1 = 1)
    PRINT ' DJSHDSJHDSJHD TRUE Condition'
    SELECT * FROM EMP2

--As of now, we dont have EMP2 table in our DB.
/* RESULT
 DJSHDSJHDSJHD TRUE Condition
Msg 208, Level 16, State 1, Line 3
Invalid object name 'EMP2'.
*/
-----------------------------------------------------
Declare @Age INT=35

IF @Age >= 18
   Print 'Major'
-----------------------------------------------------
Declare @Age INT=17
IF @Age >= 18
   Print 'Major'
ELSE
   Print 'Minor'
/*RESULT
Minor
*/
---------------------------------------------------
SELECT * FROM EMPLOYEES
/*
EMPID	NAME	Department	Salary
1	A	IT	500000
2	B	IT	600000
3	C	IT	600000
4	D	HR	400000
5	F	HR	450000
*/
------------------------------------
/*2)IF…ELSE

Provides an alternative block if the condition is false.

IF Condition
   statement1
ELSE
   statement2
*/

declare @dept varchar(50)='HR' 
IF (@dept = 'HR')
BEGIN
    UPDATE employees SET Salary =Salary+1000 WHERE department = 'HR';
    PRINT 'Bonus updated for HR employees';
END

SELECT * FROM EMPLOYEES
-------------------------------------------------
Declare @Sal INT=59900

IF @Sal > 60000
BEGIN
    PRINT 'HIGH SALARY'
    PRINT 'EMPLOYEE ELIGIBLE FOR BONUS'
END

ELSE

BEGIN
   PRINT 'LOW SALARY'
   PRINT 'NOT ELIGIBLE FOR BONUS'
END
/*Messages
LOW SALARY
NOT ELIGIBLE FOR BONUS
*/
-------------------------------------------------
/*
3)IF.. ELSE with BEGIN … END (Multiple Statements)
Groups multiple statements under one condition.

IF Condition
BEGIN
     Statements1
     Statements2
END

ELSE

BEGIN
     Statements1
     Statements2
END

*/

declare @dept varchar(50)='HR' 
IF (@dept = 'HR')
BEGIN
    UPDATE employees SET Salary =Salary+1000 WHERE department = 'HR';
    PRINT 'Bonus updated for HR employees'
END
ELSE
BEGIN
    UPDATE employees SET Salary =Salary+1000 WHERE department = 'IT';
    PRINT 'Bonus updated for IT employees'
END
/* Result
EMPID	NAME	Department	Salary
1	A	IT	500000
2	B	IT	600000
3	C	IT	600000
4	D	HR	401000
5	F	HR	451000
*/
/*
(2 rows affected)
Bonus updated for HR employees

(5 rows affected)
*/

--lets undo this above update as it will affect many results which i have practiced earlier

UPDATE employees SET Salary =Salary-1000 WHERE department = 'HR';
select * from EMPLOYEES
/*
EMPID	NAME	Department	Salary
1	A	IT	500000
2	B	IT	600000
3	C	IT	600000
4	D	HR	400000
5	F	HR	450000
*/
----------------------------------------------



Declare @Age INT=30

IF @Age >= 20
BEGIN
   IF @Age>=18
      PRINT 'Eligible for Voting'
   ELSE
      PRINT 'Not Eligible for Voting'
END

ELSE
  PRINT 'MINOR'

/*Message
Eligible for Voting
*/
-------------------------------------
IF EXISTS (SELECT * FROM employees WHERE hire_date < '2020-01-01')
    PRINT 'Some employees hired before 2020'
ELSE
    PRINT 'No employees hired before 2020'

/*Message
Invalid column name 'hire_date'.
*/
------------------------------------------------------

/*4)Nested IF Condition
IF inside another IF


IF Condition1
BEGIN
    IF Condition2
       statement
    ELSE
       statement
END
*/

/*M,P,S,H,T,C
IF M>=35
   IF P>=35
      IF S>=35*/
-----------------------------------

Declare @Age INT=14

IF @Age >= 20
BEGIN
   IF @Age>=18
      PRINT 'Eligible for Voting'
   ELSE
      PRINT 'Not Eligible for Voting'
END

ELSE
  PRINT 'MINOR'

/*Message
MINOR
*/
----------------------
/*5)IF WITH EXISTS
Checks whether a subquery returns rows OR DATA.

IF EXISTS(subquery)
   Statement
*/
IF EXISTS(SELECT 1 FROM EMPLOYEES WHERE DEPARTMENT='IT')
   PRINT 'IT EMPLOYEES EXIST'

ELSE
   PRINT 'NO IT EMPLOYEES EXIST'
/*Messages
IT EMPLOYEES EXIST
*/
-------------------------------------
/*6)IF WITH NOT EXISTS
Checks whether no rows exist

IF NOT EXISTS(subquery)
   Statement*/

IF NOT EXISTS(SELECT 1 FROM EMPLOYEES WHERE DEPARTMENT='IT')
   PRINT 'NO IT EMPLOYEES EXIST'
/*
Commands completed successfully.
*/
-------------------------------------------------------
/*7)IF WITH LOGICAL OPERATORS(AND OR NOT)/ COMPARISON OPERATORS

What is EXISTS:
==============
Exists is used to check whether a query returns rows(data exists or not)
Note: It works with data inside tables, not database objects

Syntax:
    IF EXISTS(SELECT 1 FROM TABLE_NAME WHERE CONDITION)
    BEGIN
        -- LOGIC
    END
    */

IF EXISTS(SELECT 1 FROM EMPLOYEES WHERE EMPID=1)
   PRINT 'Employee exists'
ELSE
   PRINT 'Employee NOT exists'
/*Messages
Employee exists
*/
-------------------------------------------
/*CHECK OBJECT EXISTENCE
======================
TABLE
VIEWS
STORED PROCEDURES
FUNCTIONS
TRIGGERS
-- To check whether a database object exists or not

1) Using OBJECT_ID()
 IF OBJECT_ID('OBJECTNAME','OBJECTTYPE') IS NOT NULL


U     TABLE
V     VIEW
P     STORED PROCEDURE
FN    FUNCTION

IF OBJECT_ID('DBO.EMP','U') IS NOT NULL
   PRINT 'EMP TABLE IS EXISTED'
ELSE
    PRINT 'EMP TABLE IS NOT EXISTED'

2)USING SYS.OBJECTS

IF EXISTS(SELECT 1 FROM SYS.OBJECT WHERE NAME='OBJECTNAME')*/
