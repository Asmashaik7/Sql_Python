-- Default, Check, PRIMARY KEY , COMPOSITE KEY constraints trail and errors
CREATE TABLE EMP_CONSTRAINTS
(ENO INT NOT NULL,
 ENAME VARCHAR(20) NOT NULL,
 SALARY INT CHECK(SALARY>=10000),
 ADDRESS VARCHAR(20) DEFAULT 'NA')

INSERT INTO EMP_CONSTRAINTS VALUES(101,'WARNER',12000,'HYD')
INSERT INTO EMP_CONSTRAINTS VALUES(102,'SMITH',14000,'BANG')
INSERT INTO EMP_CONSTRAINTS VALUES(103,'SCOOT',16000,'PUNE')
----------------------------------
-- We can also insert data in this way by giving specific column names. Here we are not giving ENO, which is not null. 
-- ERROR: Cannot insert the value NULL into column 'ENO'

INSERT INTO EMP_CONSTRAINTS(ENAME,SALARY,ADDRESS) VALUES('FINCH',18000,'HYD') 
------------------------------------
-- We are inserting salary <10000 in the table as we kept CHECK constraint on salary column. We get error
INSERT INTO EMP_CONSTRAINTS VALUES(104,'FINCH',8000,'HYD') 
-- ERROR: The INSERT statement conflicted with the CHECK constraint

-------------------------------------
INSERT INTO EMP_CONSTRAINTS VALUES(104,'FINCH',10000,'HYD') 
-- I ran the above INSERT 3 times. as we dont have any UNIQUE key and PK constarints its simply inserting the 104 row data.
SELECT * from EMP_CONSTRAINTS
-------------------------------------

-- We are inserting only 3 columns here. NOT giving ADDRESS column
INSERT INTO EMP_CONSTRAINTS(ENO,ENAME,SALARY) VALUES(105,'FINCH',18000)
-- Its taking DEFAULT value, NA in it.THATS the use of default constraint.

-----------------------------------------
SELECT
   *
FROM EMP_CONSTRAINTS
===============================================================================================

SELECT * FROM EMP3

CREATE TABLE EMP3(ENO INT PRIMARY KEY,ENAME VARCHAR(20),SALARY INT,DNO INT)

INSERT INTO EMP3 VALUES(101,'WARNER',12000,10)
INSERT INTO EMP3 VALUES(102,'SMITH',14000,20)
INSERT INTO EMP3 VALUES(103,'SCOOT',1600,30)

SELECT * FROM EMP3

--We are trying to insert same ENO 102, which is a PK
INSERT INTO EMP3 VALUES(102,'FINCH',18000,10)
--ERROR: Violation of PRIMARY KEY constraint 'PK__EMP3__C190FFA95D5F9C23'. Cannot insert duplicate key in object 'dbo.EMP3'. The duplicate key value is (102).

----------------------------------------------------------------

--Wr are trying to insert NULL into PK, without adding anything in ENO.
INSERT INTO EMP3(ENAME,SALARY,DNO) VALUES('FINCH',18000,10)
--ERROR: Cannot insert the value NULL into column 'ENO', table

------------------------------------------------------------------
--WE are trying to give 2 columns PRIMARY KEY
CREATE TABLE EMP4(ENO INT PRIMARY KEY,ENAME VARCHAR(20),SALARY INT PRIMARY KEY,DNO INT)
--Cannot add multiple PRIMARY KEY constraints to table 'EMP4'

============================================================================================================
CREATE TABLE EMP6(ENO INT UNIQUE,ENAME VARCHAR(20),SALARY INT,DNO INT)

INSERT INTO EMP6 VALUES(101,'WARNER',12000,10)
INSERT INTO EMP6 VALUES(102,'SMITH',14000,20)
INSERT INTO EMP6 VALUES(103,'SCOOT',1600,30)
---------------------------------------------------------
--We are trying to insert same ENO ,which is an error as ENO has UNIQUE key constarint
INSERT INTO EMP6 VALUES(102,'FINCH',18000,10)
--Violation of UNIQUE KEY constraint 'UQ__EMP6__C190FFA8F2CB2D3C'. Cannot insert duplicate key in object 'dbo.EMP6'. The duplicate key value is (102).

----------------------------------------------------------

--WE are trying to insert a NULL value into ENO, which has a UNIQUE constarint.
INSERT INTO EMP6(ENAME,SALARY,DNO) VALUES('FINCH',18000,10)
-- It doent give ERROR as UNIQUE key constarints allow NULL value only ONCE.

-----------------------------------------------------------
-- NOW i tried to enter a NULL value in a UNIQUE key constrint for the second time. IT gives ERROR. it accepts NULL only once.
INSERT INTO EMP6(ENAME,SALARY,DNO) VALUES('STARCH',18000,10)
--ERROR:Violation of UNIQUE KEY constraint 'UQ__EMP6__C190FFA8F2CB2D3C'. Cannot insert duplicate key in object 'dbo.EMP6'. The duplicate key value is (<NULL>).
-------------------------------------------------------------
SELECT * FROM EMP6
------------------------------------
COMPOSITE KEY

CREATE TABLE EMP5(ENO INT,ENAME VARCHAR(20),SALARY INT PRIMARY KEY(ENO,SALARY),DNO INT)

