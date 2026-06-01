/*                                       JOIN               SUBQUERY
  fetch related data                       yes                no
  permance issue                           yes                no
  aggregation per row                       no                yes
  Exists logic                              no                yes*/
---------------------------
use JOINS
SELECT 
        * 
FROM EMP

 -- UPDATE ONLY IF RECORD EXISTS
 IF EXISTS(
    SELECT 1 FROM EMP WHERE DNO=10 -- this only checks whether the given query is THERE OR NOT. it dont retrive data
    )
    UPDATE EMP
    SET SALARY=15000
    WHERE DNO=10

    SELECT * FROM EMP WHERE DNO=10
/*
ENO	ENAME	SALARY	DNO
101	WARNER	15000	10
103	SCOTT	15000	10*/
-----------------------------------
    --if it exists then insert
    IF EXISTS(
    SELECT 1 FROM EMP WHERE DNO=10
    )
    
    INSERT INTO EMP VALUES(110,'JOHN',20000,10)

    select * from EMP
/*
ENO	ENAME	SALARY	DNO
101	WARNER	15000	10
102	SMITH	14000	20
103	SCOTT	15000	10
104	FINCH	18000	50
105	STARCH	20000	60
110	JOHN	20000	10
*/
----------------------------------------------------
    IF EXISTS (

      SELECT 1 FROM SYS.objects WHERE NAME='EMP' AND TYPE='U'
      )
      DROP TABLE EMP

      SELECT * FROM EMP
--sys.objects gives detaiks of all the tables,views, stored procedures 
--all OBJECTS details
--------------------------------------------------
EXEC  SP_HELP -- this is a system stored procedure. gives details of all the tables,views, stored procedures 
--all OBJECTS details


SELECT 
    COLUMNNAME
FROM TABLENAME T
WHERE EXISTS ( SELECT 1 FROM ANOTHER_TABLE A WHERE A.COLUMN=T.COLUMN)

-- TO CHECK IF RELATED DATA EXISTS OR NOT
-- FASTER FOR LARGE DATASETS(STOPS AFTER FIRST MATCH)
-- USED WITH CO-RELATED SUBQUERIES
-- HELPS AVOID DUPLICATES COMPARED TO JOINS
---------------------------------------------------------------------
USE SUB_QUERIES
SELECT * FROM DEPARTMENT
SELECT * FROM EMPLOYEES

SELECT 
   ENAME,
   ESALARY,
   DNO
FROM EMPLOYEES E
WHERE  EXISTS (SELECT 1 FROM DEPARTMENT AS D WHERE E.DNO=D.DNO)
/*ENAME	ESALARY	DNO
SUNIL	50000	10
SRI	20000	10
SHEWAG	60000	30
KOHLI	40000	20
WARNER	25000	20
SMITH	35000	20
VENKY	25000	30
STARC	25000	10
FINCH	12000	10
PANDYA	25000	30
MAXWELL	10000	10
*/
----------------------------------------------------------------------
SELECT 
   ENAME,
   ESALARY,
   DNO
FROM EMPLOYEES E
WHERE NOT  EXISTS (SELECT 1 FROM DEPARTMENT AS D WHERE E.DNO=D.DNO)

-- USE EXISTS WHEN YOU WANT TO CHECK "DOES AT LEAST ONE MATCHING RECORD EXIST?)

--- RETURNS EMPLOYEE DETAILS WHO HAVE AT LEAST ONE MATCHING RECORD

SELECT * FROM EMP WHERE DNO=10



EXEC SP_HELP 'EMP'-- This gives details of EMP table, all constraints.
select *