-- BETWEEN, AND, OR, IN, NOT IN — are typically used inside the WHERE clause to filter rows based on conditions.
Clause	    Used With WHERE?	Purpose
BETWEEN	     Yes	    Check if a value lies between two values (inclusive)
AND	        Yes	        Combine multiple conditions, all must be true
OR	        Yes	        Combine multiple conditions, any one can be true
IN	        Yes	        Check if a value exists in a list of values
NOT IN	     Yes	    Check if a value does not exist in the list

-- "Write a query to find the names and salaries of all employees who either:

-- Work in the Sales or HR departments and have a salary between 40,000 and 80,000,
-- OR

-- Are located in Hyderabad."**
SELECT name, salary
FROM employees
WHERE (department IN ('sales', 'hr') AND salary BETWEEN 40000 AND 80000)
   OR location = 'hyderabad';

--    🌟 Why Use Parentheses?(We control logic)
-- SQL reads your WHERE clause like this:

-- First, it applies AND

-- Then, it applies OR


SELECT * FROM employees
WHERE (department = 'HR' AND salary > 40000)
  OR location = 'Delhi';

  .

-- 🎯 Your Challenge:
-- Write a query to get all employees who are either:

-- NOT from 'Sales' or 'HR' department
-- OR

-- Their salary is NOT between 40000 and 80000

SELECT name, department, salary FROM employees 
WHERE department NOT IN ('sales', 'hr') 
   OR salary NOT BETWEEN 40000 AND 80000;
   
   
-- 🎯 SQL Task (Slightly Tricky!)
-- 📝 Write a query to get all employees who:
-- Are not from 'Hyderabad' or 'Mumbai'
-- AND
-- Have salary not between 30,000 and 70,000
-- 👉 Show: name, location, and salary

select name,location,salary from employees where location not in('hyderabad','mumbai') and (salary not between 30000 and 70000)

-- Task
-- Employees who are in Hyderabad or Mumbai

-- And whose salary is between ₹30,000 and ₹70,000 (inclusive)
select name,location,salary from employees where location in('hyderabad','mumbai') and (salary between 30000 and 70000)

-- “Get employees who are from Hyderabad and have a salary more than ₹80,000
-- OR those who are from Mumbai (any salary).
-- Show their name, location, and salary.”

SELECT name, location, salary
FROM employee
WHERE (location = 'hyderabad' AND salary > 80000)
   OR location = 'mumbai';

-- "List all employees who are from Chennai and earn less than ₹40,000,
-- OR those who are from Kolkata and earn more than ₹90,000.
-- Show name, location, and salary."
select name, location, salary from employees where (location='chennai' and salary<40000) or (location='kolkata'and salary>90000)
