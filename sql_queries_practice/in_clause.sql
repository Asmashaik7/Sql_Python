-- IN clause
-- The IN clause helps you match a column to multiple values easily.

🎯 Your Task:
Write a query to select all employees whose location is either 'Mumbai', 'Hyderabad', or 'Delhi'.

select * from employee where location ='Mumbai' or location='Hyderabad' or location='Delhi'

select * from employee where location in('Mumbai','Hyderabad','Delhi' )
--above both queries are same, they give same output. but IN clause is preferered in multiple selections

-- ✅ Use IN When:
-- 1. ✅ You're matching against a list of values
-- Instead of writing multiple OR conditions:

-- -- Long way:
SELECT * FROM employee 
WHERE location = 'Mumbai' OR location = 'Hyderabad' OR location = 'Delhi';
-- You can simplify with IN:

-- -- Cleaner way:
SELECT * FROM employee 
WHERE location IN ('Mumbai', 'Hyderabad', 'Delhi');
-- 📌 Why?
-- Because you're checking if the column value is one of many options — perfect job for IN.

-- 2. ✅ The values are from the same column
-- IN only works when all values you're checking are from the same column.
-- For example:

SELECT * FROM employee 
WHERE department IN ('HR', 'Sales', 'Finance');
-- Here, all values are from the department column.

-- ❌ You cannot use IN across different columns like this:

-- -- ❌ Invalid:
WHERE department IN ('HR') OR location IN ('Mumbai')  
-- Use AND/OR in such cases instead.

-- 💬 So Remember:
-- Use IN when you're filtering one column for multiple values.
-- Why use IN?
-- Cleaner and shorter.

-- Easier to extend (e.g., add more departments without writing multiple OR conditions).

SELECT name, department
FROM employees
WHERE department = 'Sales' OR department = 'Finance' OR department = 'HR';


--Shorter version using IN:

SELECT name, department
FROM employees
WHERE department IN ('Sales', 'Finance', 'HR');

--NOT IN
select name, department from employees where department not in('sales','finance','hr');
--Yes! ✅ This query will return the names and departments of employees who do NOT belong to Sales, Finance, or HR.

--So if someone is in departments like "Tech", "Admin", "Marketing", etc., they will be included in the result.

