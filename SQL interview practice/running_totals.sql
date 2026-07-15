RUNNING TOTAL PRACTICE QUERIES
-- Consider the table:
CREATE TABLE Employees
(
    EmployeeID INT,
    EmployeeName VARCHAR(50),
    Department VARCHAR(20),
    Salary INT
);

INSERT INTO Employees
VALUES
(101,'Amit','HR',30000),
(102,'Neha','HR',40000),
(103,'Ravi','IT',25000),
(104,'Sara','IT',35000),
(105,'John','HR',45000);

-- Write a query to display:
-- EmployeeID
-- EmployeeName
-- Salary
-- Running Total of Salary ordered by EmployeeID

SELECT EmployeeID,
       EmployeeName,
       Salary,
       SUM(Salary) OVER(order by EmployeeID) AS RunningTotal
FROM Employees;

/*Result:
EmployeeID  EmployeeName                                       Salary      RunningTotal
----------- -------------------------------------------------- ----------- ------------
        101 Amit                                                     30000        30000
        102 Neha                                                     40000        70000
        103 Ravi                                                     25000        95000
        104 Sara                                                     35000       130000
        105 John                                                     45000       175000*/

=============================================================

-- 2. Write a query to display:

-- EmployeeID
-- EmployeeName
-- Department
-- Salary
-- Running Total of Salary ordered by EmployeeID

select 
EmployeeID,
EmployeeName,
Department,
Salary,
Running Total of Salary ordered by EmployeeID
from Employees

-- Result:
-- EmployeeID  EmployeeName                                       Department           Salary      running_total
-- ----------- -------------------------------------------------- -------------------- ----------- -------------
--         101 Amit                                               HR                         30000         30000
--         102 Neha                                               HR                         40000         70000
--         103 Ravi                                               IT                         25000         95000
--         104 Sara                                               IT                         35000        130000
--         105 John                                               HR                         45000        175000
==============================================================
-- SQL Task 2
-- Business Requirement

-- The HR Manager wants to know the cumulative salary paid within each department.

-- Display:

-- EmployeeID
-- EmployeeName
-- Department
-- Salary
-- Running Total of Salary for each Department

select 
EmployeeID,
EmployeeName,
Department,
Salary,
sum(salary) over(partition by Department order by EmployeeID) as running_total
from Employees

-- RESULT:
-- EmployeeID  EmployeeName                                       Department           Salary      running_total
-- ----------- -------------------------------------------------- -------------------- ----------- -------------
--         101 Amit                                               HR                         30000         30000
--         102 Neha                                               HR                         40000         70000
--         105 John                                               HR                         45000        115000
--         103 Ravi                                               IT                         25000         25000
--         104 Sara                                               IT                         35000         60000

=====================================================================
-- SQL Task 3
-- Sales Table

-- Requirement

-- Display:

-- SaleDate
-- SalesAmount
-- Running Total of Sales

-- ordered by SaleDate.

CREATE TABLE Sales
(
    SaleID INT,
    SaleDate DATE,
    SalesAmount INT
);

INSERT INTO Sales
VALUES
(1,'2026-01-01',1000),
(2,'2026-01-02',1500),
(3,'2026-01-03',1200),
(4,'2026-01-04',1800),
(5,'2026-01-05',900);

select
SaleDate,
SalesAmount,
sum(SalesAmount) over(order by SaleDate)as Running_Total
from Sales
--  RESULT:
--  SaleDate         SalesAmount Running_Total
-- ---------------- ----------- -------------
--       2026-01-01        1000          1000
--       2026-01-02        1500          2500
--       2026-01-03        1200          3700
--       2026-01-04        1800          5500
--       2026-01-05         900          6400

=============================================================
-- SQL Task 4
-- Bank Transactions
CREATE TABLE Transactions
(
    TransactionID INT,
    CustomerID INT,
    TransactionDate DATE,
    Amount INT
);

INSERT INTO Transactions
VALUES
(1,101,'2026-01-01',500),
(2,101,'2026-01-03',700),
(3,101,'2026-01-05',300),
(4,102,'2026-01-02',400),
(5,102,'2026-01-06',600);
-- Requirement

-- Display:

-- CustomerID
-- TransactionDate
-- Amount
-- Running Total for each customer
-- ordered by TransactionDate.

select CustomerID,
TransactionDate,
Amount,
sum(Amount) over(order by TransactionDate)as Running_Total
from Transactions

--RESULT:
-- CustomerID  TransactionDate  Amount      Running_Total
-- ----------- ---------------- ----------- -------------
--         101       2026-01-01         500           500
--         102       2026-01-02         400           900
--         101       2026-01-03         700          1600
--         101       2026-01-05         300          1900
--         102       2026-01-06         600          2500
===========================================================
-- SQL Task 5 (Interview Level)

-- Employees
CREATE TABLE Employees
(
    EmployeeID INT,
    EmployeeName VARCHAR(50),
    Department VARCHAR(20),
    Salary INT
);

INSERT INTO Employees
VALUES
(101,'Amit','HR',30000),
(102,'Neha','HR',40000),
(103,'Ravi','IT',25000),
(104,'Sara','IT',35000),
(105,'John','HR',45000);

-- display:

-- EmployeeName
-- Salary
-- Total Salary of all employees on every row.

select 
EmployeeName,
Salary,
sum(Salary) over() as Total_salary
from Employees

-- RESULT:
-- EmployeeName                                       Salary      Total_salary
-- -------------------------------------------------- ----------- ------------
-- Amit                                                     30000       175000
-- Neha                                                     40000       175000
-- Ravi                                                     25000       175000
-- Sara                                                     35000       175000
-- John                                                     45000       175000
-- NOTE:"It returns all employee rows because OVER() is a window function.
-- The total salary is calculated once and displayed on every row without reducing the number of rows.
===============================================================================
/*
Query	                   Returns
SUM()	                    One row
SUM() OVER()	            Total repeated on every row
SUM() OVER(ORDER BY...)	    Running Total
PARTITION BY                for restarting totals by department*/
=================================================
/*The HR department wants a report showing:

EmployeeID
EmployeeName
Department
Salary
Running Total of Salary within each department

The running total should restart for every department and be ordered by EmployeeID.*/

SELECT EmployeeID,
       EmployeeName,
       Department,
       Salary,
       SUM(Salary) OVER(
           PARTITION BY Department
           ORDER BY EmployeeID
       ) AS Running_Total
FROM Employees;


-- Memory Trick (Codey's Trick 😄)

-- Think of SQL clauses as chapters in a book.

-- PARTITION BY
--     Department,
--     Designation

-- ORDER BY
--     EmployeeID,
--     Salary

-- Inside one chapter (one clause), columns are separated by commas.
-- When you move to a new chapter (new clause), you don't put a comma.

=============================================================================