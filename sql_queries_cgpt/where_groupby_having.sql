-- SQL PRACTICE TASKS: GROUP BY | HAVING | DISTINCT | WHERE

-- 🔹 Table: employees
-- Columns: emp_id, name, department, salary, location

-- ✅ Task 1:
-- Show each department and total salary for that department.
SELECT department, SUM(salary) AS total_salary
FROM employees
GROUP BY department;

-- ✅ Task 2:
-- Get department names where total salary is more than 1,00,000.
SELECT department, SUM(salary) AS total_salary
FROM employees
GROUP BY department
HAVING total_salary > 100000;

-- ✅ Task 3:
-- List all unique locations from the employees table.
SELECT DISTINCT location
FROM employees;

-- ✅ Task 4:
-- Show average salary of each department only for employees from "Mumbai".
SELECT department, AVG(salary) AS avg_salary
FROM employees
WHERE location = 'Mumbai'
GROUP BY department;

-- ✅ Task 5:
-- Show all employee names who have salary > 60000.
SELECT name
FROM employees
WHERE salary > 60000;

-- ✅ Task 6:
-- Get all departments where average salary is more than 60,000.
SELECT department, AVG(salary) AS avg_salary
FROM employees
GROUP BY department
HAVING avg_salary > 60000;

-- ✅ Task 7:
-- Show total number of employees in each department.
SELECT department, COUNT(*) AS total_employees
FROM employees
GROUP BY department;

-- ✅ Task 8:
-- Show unique employee names from the table.
SELECT DISTINCT name
FROM employees;
