-- ✅ SQL Task:
-- From the employees table, display the average salary for each department, but only for employees located in Mumbai, and only include departments where the average salary is more than ₹60,000.
-- Sort the results by average salary in descending order.

-- 🔍 Table: employees
-- Columns:
-- emp_id
-- name
-- department
-- salary
-- location

SELECT department, AVG(salary) AS avg_salary
FROM employees
WHERE location = 'Mumbai'
GROUP BY department
HAVING avg_salary > 60000
ORDER BY avg_salary DESC;

-- Filters employees only from Mumbai
--Groups them by department
-- Calculates average salary for each department
-- Keeps only those where average salary > 60000
-- Sorts results by highest average salary first
-- Uses DISTINCT (though it's optional here because GROUP BY already ensures uniqueness in departments)
-- What does GROUP BY do?
-- It groups rows that have the same values in one or more columns, so that we can apply aggregate functions

🔢 SQL Query Execution Order:
Step	Clause	What It Does
1️⃣	FROM	Chooses the table(s) you're working with. Joins happen here.
2️⃣	WHERE	Filters rows before grouping (works on raw data).
3️⃣	GROUP BY	Groups rows based on one or more columns.
4️⃣	HAVING	Filters groups after aggregation like SUM, AVG.
5️⃣	SELECT	Chooses the columns to display. You can use aliases here.
6️⃣	DISTINCT	Removes duplicate rows from result.
7️⃣	ORDER BY	Sorts the final result by one or more columns.
8️⃣	LIMIT	Restricts the number of output rows (used in MySQL, SQLite, etc.).

-- ✅ SQL Task:
-- Show unique department names in Mumbai where average salary is greater than 60,000, sorted by highest average salary.
SELECT DISTINCT department, AVG(salary) AS Avg_salary
FROM employees
WHERE location = 'Mumbai'
GROUP BY department
HAVING Avg_salary > 60000
ORDER BY Avg_salary DESC;

-- 📌 Explanation:
-- DISTINCT ensures department names are unique
-- WHERE filters only Mumbai employees
-- GROUP BY groups by department
-- HAVING filters on the grouped result
-- ORDER BY sorts the result

