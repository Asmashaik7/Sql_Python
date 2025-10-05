-- Syntax	                What it counts
-- COUNT(*)	            All rows (no condition)
-- COUNT(column)	        Non-NULL values of that column
-- COUNT(*) with WHERE	    Rows that meet the condition


--1. List all departments where at least 2 employees earn a salary greater than 90,000.
-- Expected Columns:
-- department
-- high_earners

SELECT department, COUNT(*) AS high_earners
FROM employees
WHERE salary > 90000
GROUP BY department
HAVING COUNT(*) >= 2;

-- ✅ Explanation:
-- WHERE salary > 90000 filters only high earners.
-- GROUP BY department groups the filtered rows.
-- COUNT(*) now counts only employees with salary > 90000.
-- HAVING COUNT(*) >= 2 keeps only departments with at least 2 such employees.

-- What does COUNT(*) mean?
-- COUNT(*) counts all rows in each group — regardless of what’s inside (name, salary, etc.).
-- It literally means:
-- ➤ "Count how many rows exist in that group."
-- You're saying:
-- “Group all employees by department, and only keep those departments that have 2 or more employees.”
-- 🔁 How to think of * in COUNT(*) logically:
-- You can't write conditions on the * directly — it’s just a shortcut to count rows.
-- If you want to count conditionally, use the WHERE clause before the grouping.

--Example 1: Count all employees per department
select department, count(*) as emp_count from employee group by department;
--This counts every row in each department.

--Example 2: Count only employees with salary > 90000 per department
select department,count(*) from employee where salary>90000 group by department;

-- Q2: Show the number of employees in each location who earn more than 70,000. 
select location,count(*) as emp_count from employees where salary>70000 group by location;

--  Follow-up to Q2:
-- Show number of employees in each location who earn more than 70,000, only if the count is 2 or more.
select location,count(*) as emp_count from employees where salary>70000 group by location having count(*)>=2;

-- --Q3: Departments with at least 2 employees earning less than 60,000?
select department,count(*) as emp_count from employees where salary<60000 group by department count(*)<=2;

--Q4: Show each location and number of employees, but only if the location has 3 or more different departments.
SELECT location, COUNT(DISTINCT name) AS emp_count
FROM employees
GROUP BY location
HAVING COUNT(DISTINCT department) >= 3;

 --Or if you want both: number of employees and number of departments:
 SELECT location,
       COUNT(DISTINCT name) AS emp_count,
       COUNT(DISTINCT department) AS dept_count
FROM employees
GROUP BY location
HAVING COUNT(DISTINCT department) >= 3;

--💼 SQL Challenge – Count + Group By + Having

--📌 Task:
--"Show each location and number of employees earning less than ₹70,000. Only include locations with more than 3 such employees."
select location,count(distinct name) from employees where salary<70000 group by location having count(distinct name)>3;

-- 🔥 SQL Challenge 2 – COUNT + GROUP BY + WHERE + HAVING
--📌 Task:
-- Show each department that has 2 or more employees earning more than ₹90,000.
select department,count(*) from employees where salary>90000 group by department having count(*)>=2;

--🔄 SQL Twist Challenge
--📌 Task:
--Show each department and location combination that has at least 2 employees earning more than ₹90,000.

select department,location, count(*) from employees where salary >90000 group by department,location having count(*)>=2;
---------------------------------------------------------------
-- 🧩 Question:
-- From a table named employees with columns
-- employee_id, name, department, salary, and location —
--👉 Write a query to show each location that has an average salary greater than ₹80,000, and display the location name and average salary (rounded to 2 decimals).

SELECT LOCATION, ROUND(AVG(SAL),2) AS AVG_SAL FROM EMPLOYEES GROUP BY LOCATION HAVING AVG(SAL)>80000;
-or
SELECT LOCATION, ROUND(AVG(SAL),2) FROM EMPLOYEES GROUP BY LOCATION HAVING AVG(SAL)>80000;

-- 💡 Explanation:
-- The alias is only used to rename a column in the output (for readability).
-- It doesn’t affect how SQL executes the query.
-- But, as you noticed —
-- we can’t use that alias in the HAVING clause (because it’s processed earlier).

-- 🧩 Question:
-- 👉 Write a query to show each department and location combination that has an average salary greater than ₹85,000.
-- Display:
-- department
-- location
-- average salary (rounded to 2 decimals)

SELECT DEPARTMENT, LOCATION, ROUND(AVG(SAL),2) AS AVG_SAL FROM EMPLOYEES GROUP BY DEPARTMENT AND LOCATION HAVING AVG(SAL)>85000;
-- 💡 Tip:
-- Whenever you group by multiple columns, just separate them by commas — never use AND or parentheses.

-- 🧩 Challenge (COUNT + AVG together):
-- From the employees table (employee_id, name, department, location, salary):
-- 👉 Show each department and location that satisfies both:
-- Average salary > ₹85,000
-- At least 3 employees
-- Display:
-- department
-- location
-- average salary (rounded to 2 decimals)
-- number of employees

SELECT DEPARTMENT, LOCATION, ROUND(AVG(SAL),2) AS AVG_SAL, COUNT(*) AS EMP_COUNT FROM EMPLOYEES
 GROUP BY DEPARTMENT, LOCATION 
 HAVING AVG(SAL)>85000 AND COUNT(*)>=3;
--GROUP BY department, location → groups employees by department + location combination.
-- AVG(sal) → calculates the average salary per group.
-- COUNT(*) → counts the number of employees in each group.
-- HAVING AVG(sal) > 85000 AND COUNT(*) >= 3 → filters groups where average salary > 85k and at least 3 employees.
-- ROUND(..., 2) → makes the average salary more readable.
