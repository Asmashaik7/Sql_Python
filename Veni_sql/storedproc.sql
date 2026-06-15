--STORED PROCEDURES
/*
A stored procedure is a precompiled collection of SQL statements stored in the sql server database
that can be executed whenever needed.

--PERFORAMNCE IMPROVEMENT
--REDUCES NETWORK TRAFFIC
--SECURITY
--CODE REUSABILITY
--EASY MAINTENANCE

HOW TO CREATE A STORED PROCEDURE
================================

CREATE PROCEDURE PROCEDURENAME
AS
BEGIN
    -- SQL STATEMENTS
END

EXECUTE STOREPROCEDURE
======================
EXECUTE PROCEDURENAME

EXEC PROCEDURENAME
*/

==============================================================================
SELECT *

FROM EMPLOYEES
/*
EMPID	NAME	Department	Salary
1		A		IT	500000
2		B		IT	600000
3		C		IT	600000
4		D		HR	400000
5		F		HR	450000
*/
--------------------------------------
CREATE PROCEDURE EMP_DETAILS
AS
BEGIN
	SELECT * FROM EMPLOYEES

END

EXEC EMP_DETAILS
/*
EMPID	NAME	Department	Salary
1		A		IT	500000
2		B		IT	600000
3		C		IT	600000
4		D		HR	400000
5		F		HR	450000
*/
-----------------------------------
SELECT *

FROM EMPLOYEES WHERE NAME='A'
/*
EMPID	NAME	Department	Salary
1	A	IT	500000
*/
----------
ALTER PROCEDURE EMP_DETAILS
AS
BEGIN
	SELECT * FROM EMPLOYEES WHERE DEPARTMENT='IT'

END

EXEC EMP_DETAILS
/*
EMPID	NAME	Department	Salary
1	A	IT	500000
2	B	IT	600000
3	C	IT	600000
*/

DROP PROCEDURE EMP_DETAILS

----------------------------------------------
--- IF TABLE IS EXISTS DROP THAT TABLE, THEN RECREATE TABLE

