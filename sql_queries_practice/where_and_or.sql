-- ✅ Using AND in WHERE Clause
-- You can combine multiple conditions in SQL using:

-- AND → both conditions must be true

-- OR → at least one condition must be true
-------------------------------------------------------
-- task 1:
-- You have a table called students with columns:
-- id, name, marks, city.

-- You want to get the names of the top 3 students from Hyderabad, sorted by their marks (highest first).
-- But only if their marks are above 80.

SELECT name, marks
FROM students
WHERE city = 'Hyderabad' AND marks > 80
ORDER BY marks DESC
LIMIT 3;



Task 2:
SELECT name, marks
FROM students
WHERE city = 'Hyderabad' OR marks > 80;
--This gives you students who are either from Hyderabad or have marks > 80.

Task 3:
SELECT name
FROM students
WHERE (city = 'Hyderabad' AND marks > 80) OR gender = 'Female';
--➡ This gives you students who are either from Hyderabad and have marks > 80 ,or gender is female.


-- 💪 SQL Challenge:
-- Table: employees
-- Columns: emp_id, name, department, salary, location

-- 👉 Task:
-- Write a query to fetch names and salaries of employees who:
-- Are from Hyderabad
-- AND have a salary greater than 60,000
-- OR are from the Sales department

SELECT name, salary 
FROM employees 
WHERE (location = 'Hyderabad' AND salary > 60000) 
   OR department = 'Sales';

