--TABLE VALUED FUNCTION(TVF)
--1. Inline TVF
--We are creating a function which is returning a TABLE,Returns rows and columns
-- We can RETURN a table using PARANTHESIS
/*
RETURNS TABLE
AS
RETURN
(
    SELECT ...
)

No BEGIN...END.

Just return a query directly.*/


CREATE FUNCTION dbo.fn_GetEmployees()
RETURNS TABLE
AS
RETURN
(
	SELECT EMPID,NAME FROM EMPLOYEES
	WHERE DEPARTMENT='IT'
)

SELECT * FROM dbo.fn_GetEmployees()
/*Results:
EMPID	NAME
1	A
2	B
3	C*/
==========================================================================
--2. Multi-Statement TVF
/*Here:

We create a table variable @Result
Insert rows into it
Return it

That's called a Multi-Statement Table-Valued Function.*/

CREATE FUNCTION dbo.fn_GetEmployeesbyDept(@Dept varchar(15))
RETURNS @Result TABLE
(
	EMPID INT,
	NAME VARCHAR(50)
)
AS
BEGIN
	INSERT INTO @Result
	SELECT EMPID,NAME FROM EMPLOYEES WHERE DEPARTMENT=@Dept

	RETURN
END

SELECT * FROM dbo.fn_GetEmployeesbyDept('HR')
/*Result:
EMPID	NAME
4	D
5	F*/
===================================

