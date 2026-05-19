--HOW TO COPY THE DATA from one table to anther table
--------------------

SELECT * FROM EMP3

-- COPY ENTIRE TABLE DATA

SELECT
  *
INTO NEWEMP  -- NEWTABLE
FROM EMP3    -- EXISTING TABLE

------------------------------------
SELECT * FROM EMP3
SELECT * FROM NEWEMP

/*RESULT:
ENO	ENAME	SALARY	DNO
101	WARNER	12000	10
102	SMITH	14000	20
103	SCOOT	1600	30 */
--Now, Both the tables have same data as pasted above.

-----------------------------------------------
-- COPY SPECIFIC DATA

SELECT
  ENAME,SALARY
INTO NEWEMP1  -- NEWTABLE
FROM EMP3    -- EXISTING TABLE
WHERE DNO=10

select * from EMP3
/*RESULT:
ENO	ENAME	SALARY	DNO
101	WARNER	12000	10
102	SMITH	14000	20
103	SCOOT	1600	30*/
-----------------------------
select * from NEWEMP1

/*RESULT:
ENAME	SALARY
WARNER	12000*/
-- we got only specific columns into newtable.

---------------------------------
INSERT INTO NEWEMP1
SELECT ENAME,SALARY FROM EMP3
WHERE SALARY>16000

select * from newemp1
--Message:(0 rows affected), coz no emp have slary >16000 in this table.
========================================================

--- COPY ONLY STRUCTURE(NO DATA)

SELECT * 
INTO TEMP1 
FROM EMP3
WHERE 1=0

SELECT * 
INTO TEMP1
-----------
SELECT * FROM TEMP1

-- COPY WITH TRANSFORMATION

INSERT INTO TEMP1(Eno,SALARY)
SELECT Eno,SALARY*10 FROM EMP3

SELECT * FROM TEMP1

/*RESULT:
ENO	ENAME	SALARY	DNO
101	NULL	120000	NULL
102	NULL	140000	NULL
103	NULL	16000	NULL*/
--here only eno and new salary transformed are copied into the temp1. obsevre Emp3 table and know the difference.

select * from Emp3

/*
RESULT:
ENO	ENAME	SALARY	DNO
101	WARNER	12000	10
102	SMITH	14000	20
103	SCOOT	1600	30*/