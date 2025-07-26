-- 💼 Interview Q1.
-- From the employees table, list each department and the number of employees working in it.
-- Only include departments where the number of employees is between 3 and 5.

-- Expected Columns:
-- department
-- emp_count

select department, count(name) as emp_count from employees group by department having count(name) between 3 and 5

-- 🏢 Interview Q2.
-- In the employees table, show each location and the average salary, but only for locations where the average salary is above 60,000.

-- Expected Columns:
-- location
-- avg_salary

select location, avg(salary) as Avg_salary from employees group by location having avg(salary)>60000

-- 💰 Interview Q3.
-- List all departments where at least 2 employees earn a salary greater than 90,000.

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

Example 1: Count all employees per department



