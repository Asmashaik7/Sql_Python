--cte_functions with diff scenarios
--Identifying duplicates rows using CTEs

--1. using distinct 

CREATE TABLE employs
(
EmpId INT,
EmpName VARCHAR(10),
Department VARCHAR(10),
Salary INT
);


INSERT INTO employs VALUES
(1, 'A', 'IT', 500000),
(2, 'B', 'IT', 600000),
(3, 'C', 'IT', 600000),
(4, 'D', 'HR', 400000),
(5, 'E', 'HR', 450000),
(1, 'A', 'IT', 500000),
(2, 'B', 'IT', 600000),
(3, 'C', 'IT', 600000),
(4, 'D', 'HR', 400000),
(5, 'E', 'HR', 450000)


SELECT *
FROM employs
---------------------------------------------
--1. using distinct
SELECT DISTINCT Department
FROM employs
/*
Department
HR
IT
*/--we got distinct dept
SELECT 
	DISTINCT *
FROM employs
-----------------------------------------------------------
-- 2. Identifying duplicates using CTE's
WITH emcte AS
(
	SELECT
		EmpId,
		EmpName,
		Department,
		Salary,
		ROW_NUMBER() OVER (PARTITION BY Department ORDER BY Salary DESC) AS RNO
	FROM employs
)
SELECT *
FROM emcte
/*
EmpId	EmpName	Department	Salary	RNO
5	E	HR	450000	1
5	E	HR	450000	2
4	D	HR	400000	3
4	D	HR	400000	4
2	B	IT	600000	1
3	C	IT	600000	2
2	B	IT	600000	3
3	C	IT	600000	4
1	A	IT	500000	5
1	A	IT	500000	6*/
--Here we are getting department wise grouping and numbering rows along with duplicates of different departments.

--If we partition all columns then we all can see duplicates.

--if we want to get only unique, we should select rrno=1.
WITH emcte AS
(
	SELECT
		EmpId,
		EmpName,
		Department,
		Salary,
		ROW_NUMBER() OVER (PARTITION BY EmpId,EmpName,Department, Salary ORDER BY Salary DESC) AS rrno
	FROM employs
)
SELECT * FROM emcte

/*
EmpId	EmpName	Department	Salary	rrno
1	A	IT	500000	1
1	A	IT	500000	2
2	B	IT	600000	1
2	B	IT	600000	2
3	C	IT	600000	1
3	C	IT	600000	2
4	D	HR	400000	1
4	D	HR	400000	2
5	E	HR	450000	1
5	E	HR	450000	2
*/

--------------------
--and now if we write rrno>1, then we get all duplicates.
WITH emcte AS
(
	SELECT
		EmpId,
		EmpName,
		Department,
		Salary,
		ROW_NUMBER() OVER (PARTITION BY EmpId,EmpName,Department, Salary ORDER BY Salary DESC) AS rrno
	FROM employs
)
SELECT * FROM emcte
WHERE rrno>1
/*
EmpId	EmpName	Department	Salary	rrno
1	A	IT	500000	2
2	B	IT	600000	2
3	C	IT	600000	2
4	D	HR	400000	2
5	E	HR	450000	2
*/

-----------
WITH emcte AS
(
	SELECT
		EmpId,
		EmpName,
		Department,
		Salary,
		ROW_NUMBER() OVER (PARTITION BY EmpId,EmpName,Department, Salary ORDER BY Salary DESC) AS rrno
	FROM employs
)
SELECT * FROM emcte
WHERE rrno=1
/*
EmpId	EmpName	Department	Salary	rrno
1	A	IT	500000	1
2	B	IT	600000	1
3	C	IT	600000	1
4	D	HR	400000	1
5	E	HR	450000	1
*/
--these are the unique once.
----------------
--Delete the duplicate rows using delete command(i.e: rrno>1)
WITH emcte AS
(
	SELECT
		EmpId,
		EmpName,
		Department,
		Salary,
		ROW_NUMBER() OVER (PARTITION BY EmpId,EmpName,Department, Salary ORDER BY Salary DESC) AS rrno
	FROM employs
)
DELETE FROM emcte
WHERE rrno>1
--(5 rows affected)

SELECT *
FROM employs
/*
EmpId	EmpName	Department	Salary
1	A	IT	500000
3	C	IT	600000
5	E	HR	450000
2	B	IT	600000
4	D	HR	400000
*/
--y we are getting the result not in order. bcoz, we didnt write order by in select clause.
WITH emcte AS
(
	SELECT
		EmpId,
		EmpName,
		Department,
		Salary,
		ROW_NUMBER() OVER (PARTITION BY EmpId,EmpName,Department, Salary ORDER BY Salary DESC) AS rrno
	FROM employs
)
SELECT * 
FROM employs
ORDER BY SALARY DESC

/*
EmpId	EmpName	Department	Salary
3	C	IT	600000
2	B	IT	600000
1	A	IT	500000
5	E	HR	450000
4	D	HR	400000
*/











---DROP TABLE employs
CREATE TABLE employs
(
EmpId INT,
EmpName VARCHAR(10),
Department VARCHAR(10),
Salary INT
);


INSERT INTO employs VALUES
(1, 'A', 'IT', 500000),
(2, 'B', 'IT', 600000),
(3, 'C', 'IT', 600000),
(4, 'D', 'HR', 400000),
(5, 'E', 'HR', 450000),
(1, 'A', 'IT', 500000),
(2, 'B', 'IT', 600000),
(3, 'C', 'IT', 600000),
(4, 'D', 'HR', 400000),
(5, 'E', 'HR', 450000)


SELECT
	EmpId, EmpName, Department, Salary,
	COUNT(*) AS total
FROM employs
GROUP BY EmpId, EmpName, Department, Salary
HAVING COUNT(*) > 1




SELECT Department
FROM employs

SELECT DISTINCT Department
FROM employs


WITH emcte AS
(
	SELECT
		Department,
		ROW_NUMBER() OVER (PARTITION BY Department ORDER BY Salary DESC) AS rrno
	FROM employs
)
DELETE FROM emcte
WHERE rrno>1


SELECT EmpId,EmpName,
FROM employs


SP_HELP employs


WITH emcte AS
(
	SELECT
		Department,
		ROW_NUMBER() OVER (PARTITION BY * ORDER BY Salary DESC) AS rrno
	FROM employs
)
SELECT * FROM emcte
WHERE rrno>1