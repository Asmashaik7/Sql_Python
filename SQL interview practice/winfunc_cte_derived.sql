-- Most Asked Interview Questions
-- 1. Find the 2nd Highest Salary
-- Pattern
-- DENSE_RANK()
--         ↓
-- CTE / Derived Table
--         ↓
-- WHERE RankNo = 2
--CTE
WITH SalaryRank AS
(
    SELECT Name,
           Salary,
           DENSE_RANK() OVER(ORDER BY Salary DESC) AS RankNo
    FROM Employee
)
SELECT *
FROM SalaryRank
WHERE RankNo = 2;
==========================================================
-- Derived Table

SELECT *
FROM
(
    SELECT Name,
           Salary,
           DENSE_RANK() OVER(ORDER BY Salary DESC) AS RankNo
    FROM Employee
) AS SalaryRank
WHERE RankNo = 2;
=============================================================

-- 2. Highest Salary in Each Department
WITH DeptRank AS
(
    SELECT Name,
           DeptID,
           Salary,
           ROW_NUMBER() OVER
           (
               PARTITION BY DeptID
               ORDER BY Salary DESC
           ) AS RN
    FROM Employee
)
SELECT *
FROM DeptRank
WHERE RN = 1;
============================================
-- Pattern:

-- PARTITION BY
--       ↓
-- ROW_NUMBER()
--       ↓
-- WHERE RN = 1
-- 3. Latest Order of Every Customer

WITH LatestOrder AS
(
    SELECT OrderID,
           CustomerID,
           OrderDate,
           ROW_NUMBER() OVER
           (
               PARTITION BY CustomerID
               ORDER BY OrderDate DESC
           ) AS RN
    FROM Orders
)
SELECT *
FROM LatestOrder
WHERE RN = 1;
========================================================
-- 4. First Order of Every Customer

-- Same query.

-- Just change

-- ORDER BY OrderDate ASC
========================================================
-- 5. Top 3 Salaries
WITH SalaryRank AS
(
    SELECT Name,
           Salary,
           DENSE_RANK() OVER
           (
               ORDER BY Salary DESC
           ) AS RN
    FROM Employee
)
SELECT *
FROM SalaryRank
WHERE RN <=3;
=================================================================
-- 6. Remove Duplicate Rows

WITH DuplicateRows AS
(
    SELECT *,
           ROW_NUMBER() OVER
           (
               PARTITION BY Name, Salary
               ORDER BY EmpID
           ) AS RN
    FROM Employee
)
DELETE
FROM DuplicateRows
WHERE RN > 1;
---------------------------------------------------------
-- 7. Running Total
SELECT OrderID,
       Amount,
       SUM(Amount)
       OVER(ORDER BY OrderID)
       AS RunningTotal
FROM Orders;

===================================
-- 8. Previous Salary
SELECT Name,
       Salary,
       LAG(Salary)
       OVER(ORDER BY Salary)
       AS PreviousSalary
FROM Employee;
===================================
-- 9. Next Salary
SELECT Name,
       Salary,
       LEAD(Salary)
       OVER(ORDER BY Salary)
       AS NextSalary
FROM Employee;
========================================
-- 10. Rank Employees
SELECT Name,
       Salary,
       ROW_NUMBER() OVER(ORDER BY Salary DESC),
       RANK() OVER(ORDER BY Salary DESC),
       DENSE_RANK() OVER(ORDER BY Salary DESC)
FROM Employee;