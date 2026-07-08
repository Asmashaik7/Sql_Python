-- 1. Find the highest salary in each department
SELECT Dept,
       MAX(Salary) AS HighestSalary
FROM Emp
GROUP BY Dept;

===========================================================
-- 2. Find the employee(s) with the highest salary in each department (Window Function)
SELECT Name,
       Dept,
       Salary
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

=============================================
-- 3. Find the employee(s) with the highest salary in each department (Correlated Subquery)
SELECT Name,
       Dept,
       Salary
FROM Emp e
WHERE Salary =
(
    SELECT MAX(Salary)
    FROM Emp
    WHERE Dept = e.Dept
);
======================================================

-- 4. Find the second highest salary
SELECT MAX(Salary)
FROM Emp
WHERE Salary <
(
    SELECT MAX(Salary)
    FROM Emp
);
--------------------------------------------------

-- 5. Count employees in each department
SELECT Dept,
       COUNT(*) AS EmployeeCount
FROM Emp
GROUP BY Dept;

=========================================================
-- 6. Departments having more than 3 employees
SELECT Dept,
       COUNT(*) AS EmployeeCount
FROM Emp
GROUP BY Dept
HAVING COUNT(*) > 3;

========================================================
-- 7. Departments where average salary is greater than 50,000
SELECT Dept,
       AVG(Salary) AS AvgSalary
FROM Emp
GROUP BY Dept
HAVING AVG(Salary) > 50000;

==========================================================
-- 8. Find duplicate email addresses
SELECT Email,
       COUNT(*) AS EmailCount
FROM Emp
GROUP BY Email
HAVING COUNT(*) > 1;
============================================================
-- 9. Employees whose salary is greater than 50,000
SELECT *
FROM Emp
WHERE Salary > 50000;

====================================================
-- 10. Employees whose name starts with 'A'
SELECT *
FROM Emp
WHERE Name LIKE 'A%';
=======================================================
-- 11. Total salary department-wise
SELECT Dept,
       SUM(Salary) AS TotalSalary
FROM Emp
GROUP BY Dept;

===============================================
-- 12. Top 3 highest-paid employees
SQL Server
SELECT TOP 3 *
FROM Emp
ORDER BY Salary DESC;

-------------------------------------------------
-- 13. UNION
SELECT ID,
       Name
FROM CurrentEmployees

UNION

SELECT ID,
       Name
FROM FormerEmployees;
====================================================
-- 14. UNION ALL
SELECT ID,
       Name
FROM CurrentEmployees

UNION ALL

SELECT ID,
       Name
FROM FormerEmployees;

=========================================================