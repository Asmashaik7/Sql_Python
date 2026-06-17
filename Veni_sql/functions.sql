--SCALAR FUNCTION
--here we are creating a fucntion which is retrurning INT.
CREATE FUNCTION dbo.fn_GetBonus(@Salary INT)
RETURNS INT
AS
BEGIN
	RETURN (@Salary*10)/100
END

SELECT * FROM EMPLOYEES
/*Results:
EMPID	NAME	Department	Salary
1	A	IT	500000
2	B	IT	600000
3	C	IT	600000
4	D	HR	400000
5	F	HR	450000
*/

SELECT
	NAME,SALARY,dbo.fn_GetBonus(SALARY) AS Bonus
FROM EMPLOYEES
/*Results:
NAME	SALARY	Bonus
A	500000	50000
B	600000	60000
C	600000	60000
D	400000	40000
F	450000	45000
*/
--------------------------------------------
ALTER FUNCTION dbo.fn_GetBonus(@Salary INT)
RETURNS INT
AS
BEGIN
	RETURN (@Salary*10)
END

SELECT * FROM EMPLOYEES

SELECT
	EMPID,NAME,SALARY,dbo.fn_GetBonus(EMPID) AS MULTIEMP
FROM EMPLOYEES
--here we are chanigng the column name in the function and using it as is.
/*Results:
EMPID	NAME	SALARY	MULTIEMP
1	    A	    500000	10
2	    B	    600000	20
3	    C	    600000	30
4	    D	    400000	40
5	    F	    450000	50*/
---------------------------------------------------------------------
