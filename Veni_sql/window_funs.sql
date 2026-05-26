--window functions: 
--1. ROW NUMBER

CREATE TABLE EMPLOYEES
  (
  EMPID INT,
  NAME VARCHAR(15),
  Department varchar(10),
  Salary INT
  )

  INSERT INTO EMPLOYEES VALUES
(1, 'A', 'IT',500000),
(2, 'B', 'IT',600000),
(3, 'C', 'IT',600000),
(4, 'D', 'HR',400000),
(5, 'F', 'HR',450000)

select * from EMPLOYEES
/*
EMPID	NAME	Department	Salary
1		A		IT		500000
2		B		IT		600000
3		C		IT		600000
4		D		HR		400000
5		F		HR		450000
*/

SELECT
   NAME,
   SALARY,
   ROW_NUMBER() OVER (ORDER BY SALARY DESC) AS RowNumber
FROM EMPLOYEES
/*Result:
NAME	SALARY	RowNumber
B		600000	1
C		600000	2
A		500000	3
F		450000	4
D		400000	5*/
--------------------------------------------------------
--by default order by is ASC
SELECT
   NAME,
   SALARY,
   ROW_NUMBER() OVER (ORDER BY SALARY ) AS RowNumber
FROM EMPLOYEES
/*
NAME	SALARY	RowNumber
D		400000	1
F		450000	2
A		500000	3
B		600000	4
C		600000	5*/


-----------------------------------
--using partition by(grouping )

SELECT
   NAME,
   SALARY,
   DEPARTMENT,
   ROW_NUMBER() OVER (PARTITION BY DEPARTMENT ORDER BY SALARY DESC ) AS RowNumber
FROM EMPLOYEES

/*
NAME SALARY	DEPARTMENT	RowNumber
F	450000	HR	1
D	400000	HR	2
B	600000	IT	1
C	600000	IT	2
A	500000	IT	3
*/
------------------------------------------------------
--using partition by using order by clause

SELECT
   NAME,
   SALARY,
   DEPARTMENT,
   ROW_NUMBER() OVER (PARTITION BY DEPARTMENT ORDER BY SALARY DESC ) AS RowNumber
FROM EMPLOYEES
order by name
--over all ordering by name here

/*NAME	SALARY	DEPARTMENT	RowNumber
A		500000	IT	3
B		600000	IT	1
C		600000	IT	2
D		400000	HR	2
F		450000	HR	1
*/
-----------------------------------------------------------
--RANK

SELECT
   NAME,
   SALARY,
   DEPARTMENT,
   RANK() OVER (  ORDER BY SALARY DESC ) AS RANK_Number
FROM EMPLOYEES
/*
NAME	SALARY	DEPARTMENT	RANK_Number
B		600000	IT			1
C		600000	IT			1
A		500000	IT			3
F		450000	HR			4
D		400000	HR			5
*/
-----------------------------------------------------------------
--DENSE RANK
SELECT
   NAME,
   SALARY,
   DEPARTMENT,
   DENSE_RANK() OVER (  ORDER BY SALARY DESC ) AS DENSERANK_Number
FROM EMPLOYEES

/*
NAME	SALARY	DEPARTMENT	DENSERANK_Number
B	600000	IT	1
C	600000	IT	1
A	500000	IT	2
F	450000	HR	3
D	400000	HR	4
*/
------------------------------------------------------
--NTILE
SELECT
   NAME,
   SALARY,
   DEPARTMENT,
   NTILE(2) OVER (  ORDER BY SALARY DESC ) AS TILE
FROM EMPLOYEES

/*
NAME	SALARY	DEPARTMENT	TILE
B		600000	IT		1
C		600000	IT		1
A		500000	IT		1
F		450000	HR		2
D		400000	HR		2
*/
/*
				ROW_NUMBER				RANK			DENSE_RANK
UNIQUENUMBERS     YES                    NO				 NO
HANDLES TIES       NO					YES              YES
SKIP Ranks          NO                   YES              NO  */



--TOP 2 SALARIES PER DEPARTMENT
select Department,
salary,
rank() over(partition by department order by salary desc)=2 as salary_orderwise
from EMPLOYEES


SELECT Department, Salary
FROM (
    SELECT 
        Department,
        Salary,
        RANK() OVER (PARTITION BY Department ORDER BY Salary DESC) AS rnk
    FROM EMPLOYEES
) t
WHERE rnk <= 2;
/*
Department	Salary
HR	450000
HR	400000
IT	600000
IT	600000
*/

------------------------------

SELECT Department, Salary
FROM (
    SELECT 
        Department,
        Salary,
        RANK() OVER (
            PARTITION BY Department
            ORDER BY Salary DESC
        ) AS rnk
    FROM EMPLOYEES
) t
WHERE rnk <= 2;

/*
Department	Salary
HR	450000
HR	400000
IT	600000
IT	600000
*/