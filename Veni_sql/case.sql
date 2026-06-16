/*In SQL Server, the CASE statement is a conditional expression used inside queries to return values based on conditions. CASE is used within SQL statements (like SELECT, UPDATE, ORDER BY) to apply conditional logic directly to data.

Why We Need CASE
================
-To apply conditional logic inside queries without writing separate procedures.

-To transform data values based on rules.

-To replace IF…ELSE in SELECT statements.

--To simplify complex queries by embedding decision-making directly in SQL.

Types of CASE Statements
========================
1. Simple CASE
Compares an expression to a set of values and returns the result for the first match.

Syntax:

CASE expression
    WHEN value1 THEN result1
    WHEN value2 THEN result2
    ...
    ELSE default_result
END

Ex:*/
select * from EMPLOYEES

SELECT name,
       CASE department
           WHEN 'HR' THEN 'Human Resources'
           WHEN 'IT' THEN 'Information Technology'
           ELSE 'Other'
       END AS dept_fullname
FROM employees;

/*Result:
name	dept_fullname
A	Information Technology
B	Information Technology
C	Information Technology
D	Human Resources
F	Human Resources */
=====================================================
/*2. Searched CASE
Evaluates multiple Boolean conditions and returns the result of the first true condition.

Syntax:
CASE
    WHEN condition1 THEN result1
    WHEN condition2 THEN result2
    ...
    ELSE default_result
END

Ex:*/

SELECT name, salary,
       CASE
           WHEN salary > 70000 THEN 'High'
           WHEN salary BETWEEN 40000 AND 70000 THEN 'Medium'
           ELSE 'Low'
       END AS salary_band
FROM employees
/*Result:
name	salary	salary_band
A	    500000	High
B	    600000	High
C	    600000	High
D	    400000	High
F	    450000	High
*/
===============================================
UPDATE employees
SET salary = 
    CASE 
        WHEN salary > 60000 THEN 72000
        ELSE 55000
    END
select * from employees
/*Result:
EMPID	NAME	Department	Salary
1	A	IT	72000
2	B	IT	72000
3	C	IT	72000
4	D	HR	72000
5	F	HR	72000
*/
-- lets undo this salary as , I used this same table for many topics practices, which affects their results.
UPDATE employees
SET salary =
    CASE name
        WHEN 'A' THEN 500000
        WHEN 'B' THEN 600000
        WHEN 'C' THEN 600000
        WHEN 'D' THEN 400000
        WHEN 'F' THEN 450000
    END;

select * from employees
/*Result:
EMPID	NAME	Department	Salary
1	A	IT	500000
2	B	IT	600000
3	C	IT	600000
4	D	HR	400000
5	F	HR	450000
*/

=======================================================
--Before testing an UPDATE, first run the CASE as a SELECT:This lets you preview the changes before modifying the table.
--It's a very common SQL practice and saves a lot of accidental updates.