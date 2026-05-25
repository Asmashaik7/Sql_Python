--DISTINCT KEYWORD IS USED TO REMOVE DUPLICATE ROWS FROM THE SELECTED RESULT... 
--IT RETURNS UniQUE VALUES

SELECT 
  DNO
FROM EMP6
/*
DNO
10
20
30
10*/

SELECT * FROM EMP6
/*
ENO	ENAME	SALARY	DNO
101	WARNER	12000	10
102	SMITH	14000	20
103	SCOOT	1600	30
NULL	FINCH	18000	10*/

SELECT 
 DISTINCT DNO,ENAME
FROM EMP6
--We got 10 repeated despite giving distinct , coz distinct written in combination of DNO, ENAME
/*
DNO	ENAME
10	FINCH
10	WARNER
20	SMITH
30	SCOOT
*/
SELECT 
 DISTINCT ENAME
FROM EMP6

--If we want to check, then update the ename of 101 as FINCH and see.

UPDATE EMP6 
SET ENAME='WARNER' 
WHERE ENO=101
--Im not running this query

select * from emp6
/*
ENO	ENAME	SALARY	DNO
101	WARNER	12000	10
102	SMITH	14000	20
103	SCOOT	1600	30
NULL	FINCH	18000	10*/

SELECT 
  COUNT(DISTINCT DNO)
FROM EMP6
/*(No column name)
3*/

----------------
--Find departments having more than one employee.
SELECT 
DNO,
  COUNT(DNO) as emps_of_dept_count
FROM EMP6
GROUP BY DNO
HAVING COUNT(DNO)>1
/*
DNO	emps_of_dept_count
10	2*/
--Department 10 has 2 employees