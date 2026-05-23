create database JOINS

use JOINS

--EMP Table
CREATE TABLE EMP
(
    ENO INT,
    ENAME VARCHAR(20),
    SALARY INT,
    DNO INT
);

INSERT INTO EMP VALUES (101, 'WARNER', 12000, 10);

INSERT INTO EMP VALUES (102, 'SMITH', 14000, 20);

INSERT INTO EMP VALUES (103, 'SCOTT', 16000, 10);

INSERT INTO EMP VALUES (104, 'FINCH', 18000, 50);

INSERT INTO EMP VALUES (105, 'STARCH', 20000, 60);

select * from emp

/*Result:
ENO	ENAME	SALARY	DNO
101	WARNER	12000	10
102	SMITH	14000	20
103	SCOTT	16000	10
104	FINCH	18000	50
105	STARCH	20000	60 */

--DEPT Table
CREATE TABLE DEPT
(
    DNO INT,
    DNAME VARCHAR(20),
    LOCATION VARCHAR(20)
);

INSERT INTO DEPT VALUES (10, 'ADMIN', 'HYD');

INSERT INTO DEPT VALUES (20, 'SALES', 'CHENNAI');

INSERT INTO DEPT VALUES (30, 'DEV', 'BANG');

INSERT INTO DEPT VALUES (40, 'CLERK', 'PUNE');

select * from dept

/*Result:
DNO	DNAME	LOCATION
10	ADMIN	HYD
20	SALES	CHENNAI
30	DEV	    BANG
40	CLERK	PUNE */

--NOTE
--EMP have 10,20,50,60. It dont have 30,40
--DEPT have 10,20,30,40. Dont have 50 ,60 

--1. INNER JOIN: Returns only matching rows from both tables.
SELECT
    D.DNO,
    E.ENO,
    E.ENAME,
    E.SALARY,
    D.DNAME,
    D.LOCATION
FROM EMP E
INNER JOIN DEPT D
ON E.DNO = D.DNO;
--10 and 20 are common deptno's.

/*Result:
DNO	ENO	ENAME	SALARY	DNAME	LOCATION
10	101	WARNER	12000	ADMIN	HYD
20	102	SMITH	14000	SALES	CHENNAI
10	103	SCOTT	16000	ADMIN	HYD*/
==========================================================

--2. LEFT JOIN: This returns all rows from LEFT table (EMP) and matching rows from RIGHT table (DEPT).
--EMP rows with DNO values 10,20,50,60 will all be shown.
--If matching department data is not available,then DEPT columns like DNAME and LOCATION will show NULL.

SELECT
    E.DNO,
    E.ENO,
    E.ENAME,
    D.DNAME,
    D.LOCATION
FROM EMP E
LEFT JOIN DEPT D
ON E.DNO = D.DNO;
--Im selecting DNO for my understanding

/*Result:
DNO	ENO	ENAME	DNAME	LOCATION
10	101	WARNER	ADMIN	HYD
20	102	SMITH	SALES	CHENNAI
10	103	SCOTT	ADMIN	HYD
50	104	FINCH	NULL	NULL
60	105	STARCH	NULL	NULL*/

===================================================
--NOTE
--EMP have 10,20,50,60. It dont have 30,40
--DEPT have 10,20,30,40. Dont have 50 ,60 
===========================================
--3. RIGHT JOIN: It returns all rows from RIGHT table (DEPT). Mathching rows from the left table. (10,20)
-- DEPT rows with 10,20,30,40 will be shown.
-- 10 and 20 from the EMP table shown.
--Non matching columns(E.name and salary will shown NULL) of 30 and 40 DNO from EMP table.

SELECT
    D.DNO,
    E.ENAME,
    D.DNAME,
    D.LOCATION
FROM EMP E
RIGHT JOIN DEPT D
ON E.DNO = D.DNO;

/* Result:
DNO	ENAME	DNAME	LOCATION
10	WARNER	ADMIN	HYD
10	SCOTT	ADMIN	HYD
20	SMITH	SALES	CHENNAI
30	NULL	DEV	    BANG
40	NULL	CLERK	PUNE */

========================================
--4. FULL OUTER JOIN: All rows from both tables.
/*EMP Result:
ENO	ENAME	SALARY	DNO
101	WARNER	12000	10
102	SMITH	14000	20
103	SCOTT	16000	10
104	FINCH	18000	50
105	STARCH	20000	60 */

/*DEPT Result:
DNO	DNAME	LOCATION
10	ADMIN	HYD
20	SALES	CHENNAI
30	DEV	    BANG
40	CLERK	PUNE */
SELECT
    E.DNO,
    E.ENAME,
    D.DNAME,
    D.LOCATION
FROM EMP E
FULL OUTER JOIN DEPT D
ON E.DNO = D.DNO;
