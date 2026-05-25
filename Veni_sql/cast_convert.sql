-- CAST AND CONVERT FUNCTIONS

SELECT CAST(123 AS varchar)+10
/* Result:
(No column name)
133*/

--firstname + lastname
select concat('Asma','shaik')
/*(No column name)
Asmashaik*/

select 'Asma'+'shaik'
/*(No column name)
Asmashaik*/

select 'firstname'+' '+'lastname'

/*(No column name)
Asma shaik*/

SELECT 123+10
/*(No column name)
133*/

SELECT '123'+10
/* (No column name)
133*/
--Because SQL Server sees '123' as a string but convertible to number.
--THIS IS called Implicit Conversion. SQL automatically converts datatype.
--One side is numeric:SQL converts '123' → 123

SELECT '123'+'10'
/*(No column name)
12310*/
--because SQL sees:left side → string
--right side → string, So + acts as:string concatenation

SELECT 'ABC' + 10
--Conversion failed- as ABC is not convertible, cannot become number..
--ERROR:Conversion failed when converting the varchar value 'ABC' to data type int.
 ======================================================================================
SELECT 
    ENAME,
    DNO
FROM EMP6

 select * from emp6
 /*
ENO	ENAME	SALARY	DNO
101	WARNER	12000	10
102	SMITH	14000	20
103	SCOOT	1600	30
NULL FINCH	18000	10*/
-------------------------------

SELECT 
    ENAME +'-'+ CAST(DNO AS varchar) AS ENAMEDNO
FROM EMP6
/*
ENAMEDNO
WARNER-10
SMITH-20
SCOOT-30
FINCH-10*/
=================================================================

SELECT 
   lower( ENAME) +'  '+ CAST(DNO AS varchar) AS ENAMEDNO
FROM EMP6
/*
ENAMEDNO
warner  10
smith  20
scoot  30
finch  10
*/

==========================================
--CONVERT
==========================================
-- It SUPPORTS FORMATTING( IMPORTANT FOR DATES)

--SYntax: CONVERT(DATATYPE,EXPRESSION,STYLE)- convert number into string datatype
--expression is the target DT
--CONVERT(new_datatype, value)
-------------------------------
-- to check the DT 
SELECT SQL_VARIANT_PROPERTY(123456,'BaseType')
/*
(No column name)
int
*/

SELECT CONVERT(VARCHAR,123456)
--here o/p looks same , but internally DT changed to VARCHAR.
/*
123456
*/
--And now check,
SELECT SQL_VARIANT_PROPERTY(CONVERT(VARCHAR,123456),'BaseType')
/*(No column name)
varchar*/
------------------------------------------------------------------
SELECT 'EMP-' + CONVERT(VARCHAR,123)
/*
EMP-123
*/
--here 123 DT is a varchar not int or numeric

SELECT 'EMP-' + 123
--ERROR: Conversion failed when converting the varchar value 'EMP-' to data type int.
-------------------------------------------------------
SELECT CONVERT(VARCHAR,GETDATE())
--Converts current date into text/string.
/*(No column name)
May 25 2026  3:55PM*/

--and check now
SELECT SQL_VARIANT_PROPERTY(CONVERT(VARCHAR,GETDATE()),'BaseType')
/*
(No column name)
varchar
*/
===================================================
SELECT GETDATE()
/*
2026-05-25 15:48:58.347
*/

SELECT CONVERT(VARCHAR,GETDATE(),103)
/*
(No column name)
25/05/2026
*/

SELECT CONVERT(VARCHAR,GETDATE(),105)
/*
(No column name)
25-05-2026

DIFFERENCES
CAST                CONVERT

SIMPLE              MORE FLEXIBLE
GENERAL CONVERSION  DATE FORMATTING
                    CONVERSION+FORMATTING

Style	Example
101	    05/26/2026
102	    2026.05.26
103	    26/05/2026
105	    26-05-2026
106	    26 May 2026
107	    May 26, 2026
120     YYYY-MM-DD

*/

SELECT FORMAT(GETDATE(),'dd-mm-yyyy')
/*(No column name)
25-18-2026*/