--This contains all queries which seems different and very new for me,
--for a quick reference 
-- 💡 Quick Tip:
-- Only use parentheses in IN (), VALUES (), or subqueries — not in GROUP BY.

--  SQL Twist Challenge
-- 📌 Task:

-- Show each department and location combination that has at least 2 employees earning more than ₹90,000.

SELECT department, location, COUNT(*) AS emp_count
FROM employees
WHERE salary > 90000
GROUP BY department, location
HAVING COUNT(*) >= 2;

-- GROUP BY department, location
-- This tells SQL:

-- “Group the data separately for each unique combination of department and location.”

-- 🔎 Visual:
-- department	location	emp_name
-- IT	Chennai	A
-- IT	Chennai	B
-- IT	Mumbai	C

-- If you do GROUP BY department, location:

-- One group is: IT + Chennai

-- Another group is: IT + Mumbai