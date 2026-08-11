/*1. CASE WHEN – Interview Questions
Q1. What is CASE WHEN?

Answer:
CASE WHEN is used to apply conditional logic in SQL. It works like an IF...ELSE statement and returns different values based on specified conditions.

Q2. Categorize employees based on salary.*/
SELECT Name,
       Salary,
       CASE
           WHEN Salary >= 80000 THEN 'High'
           WHEN Salary >= 50000 THEN 'Medium'
           ELSE 'Low'
       END AS SalaryCategory
FROM Employee;
--Q3. Replace NULL values with 'Unknown'.
SELECT Name,
       CASE
           WHEN City IS NULL THEN 'Unknown'
           ELSE City
       END AS City
FROM Employee;
--Q4. Can CASE WHEN be used with aggregate functions?

--Answer: Yes.

SELECT
SUM(CASE WHEN Gender='Male' THEN 1 ELSE 0 END) AS MaleCount,
SUM(CASE WHEN Gender='Female' THEN 1 ELSE 0 END) AS FemaleCount
FROM Employee;
/*Q5. Where can CASE WHEN be used?

Answer:

SELECT
ORDER BY
GROUP BY
HAVING
UPDATE
=====================================================
Business Scenario

You're a Data Analyst in an e-commerce company.

The manager wants customers classified based on their total spending:

Less than ₹2,000 → Low
₹2,000–₹5,000 → Medium
More than ₹5,000 → High

Show each order's OrderID, Amount, and classify the order as Small, Medium, or Large.
rules:
Amount < 1000       → Small
Amount 1000–3000    → Medium
Amount > 3000       → Large*/

select OrderID, 
        Amount,
        case
        when Amount < 1000 then 'Small'
        when Amount >=1000 and Amount<=3000 then 'Medium'
        else 'Large'
        end as order_type
   from Orders1

   /*Result:
   OrderID	Amount	order_type
101	1200.00	Medium
102	1800.00	Medium
103	1500.00	Medium
104	500.00	Small
105	700.00	Small
106	2500.00	Medium
107	2200.00	Medium
108	1800.00	Medium
109	900.00	Small
110	3500.00	Large
111	2000.00	Medium
112	2500.00	Medium
113	600.00	Small
114	700.00	Small
115	4000.00	Large
116	1500.00	Medium
117	1000.00	Medium
118	800.00	Small
119	900.00	Small
120	5000.00	Large
121	2000.00	Medium
122	1200.00	Medium
==============================================================
Business Scenario

The Sales Manager now wants to classify orders based on their amount, but with only two categories:

"Identify whether each order is a High Value order or a Regular order."

Rule:

Amount >= 3000 → High Value
Otherwise → Regular
Write the SQL showing:

OrderID
Amount
Order_Category*/
select * from orders1;
select 
OrderID,
Amount,
case
    when Amount >= 3000 then 'High Value'
    else 'Regular'
    end as Order_Category
from orders1;
/*
OrderID	Amount	Order_Category
101	1200.00	Regular
102	1800.00	Regular
103	1500.00	Regular
104	500.00	Regular
105	700.00	Regular
106	2500.00	Regular
107	2200.00	Regular
108	1800.00	Regular
109	900.00	Regular
110	3500.00	High Value
111	2000.00	Regular
112	2500.00	Regular
113	600.00	Regular
114	700.00	Regular
115	4000.00	High Value
116	1500.00	Regular
117	1000.00	Regular
118	800.00	Regular
119	900.00	Regular
120	5000.00	High Value
121	2000.00	Regular
122	1200.00	Regular
=====================================================
Business Scenario

The HR team wants to classify employees based on salary:

Salary < 30,000 → Low
Salary 30,000–60,000 → Medium
Salary > 60,000 → High

Suppose we have:

Employees
---------
EmployeeID
EmployeeName
Salary
Interview question

Write a query showing:

EmployeeID
EmployeeName
Salary
Salary_Category*/

select EmployeeID,
EmployeeName,
Salary,
case
when Salary < 30000 then 'Low'
when Salary inbetween 30000 and 60000 then 'Medium'
when Salary > 60000 then 'High'
end as Salary_Category
from employees;