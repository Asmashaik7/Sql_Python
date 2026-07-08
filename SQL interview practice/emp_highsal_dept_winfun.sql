--Find the employee(s) with the highest salary in each department.
-- Method 1: MAX() + GROUP BY

SELECT Dept,
       MAX(Salary)
FROM Emp
GROUP BY Dept;
--Result
-- Dept	    MaxSalary
-- HR	    50000
-- IT	    70000

-- We don't get the employee name.
-- This works only if the interviewer asks:
-- "Find the highest salary in each department.
==========================================================================
--Method 2: Correlated Subquery

SELECT Name, Dept, Salary
FROM Emp e
WHERE Salary =
(
    SELECT MAX(Salary)
    FROM Emp
    WHERE Dept = e.Dept
);

-- Output:
-- Name	Dept	Salary
-- B	HR	    50000
-- C	IT	    70000

--Gets the employee name.
--On large tables, it may be slower because the inner query is evaluated for each row.

==================================================================================
--Method 3: DENSE_RANK()

SELECT Name, Dept, Salary
FROM
(
    SELECT Name,
           Dept,
           Salary,
           DENSE_RANK() OVER
           (
               PARTITION BY Dept
               ORDER BY Salary DESC
           ) AS rnk
    FROM Emp
) t
WHERE rnk = 1;

-- Output:
-- Name	Dept	Salary
-- B	HR	50000
-- C	IT	70000

-- ✅ Gets the employee name.
-- ✅ Handles ties correctly.
-- ✅ Often easier to read for ranking problems.
--"For ranking problems, I prefer window functions because they express the requirement clearly. 
--Correlated subqueries may be less efficient since the inner query depends on the outer query and can be evaluated repeatedly."
