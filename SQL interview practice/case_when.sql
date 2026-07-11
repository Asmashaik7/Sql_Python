1. CASE WHEN – Interview Questions
Q1. What is CASE WHEN?

Answer:
CASE WHEN is used to apply conditional logic in SQL. It works like an IF...ELSE statement and returns different values based on specified conditions.

Q2. Categorize employees based on salary.
SELECT Name,
       Salary,
       CASE
           WHEN Salary >= 80000 THEN 'High'
           WHEN Salary >= 50000 THEN 'Medium'
           ELSE 'Low'
       END AS SalaryCategory
FROM Employee;
Q3. Replace NULL values with 'Unknown'.
SELECT Name,
       CASE
           WHEN City IS NULL THEN 'Unknown'
           ELSE City
       END AS City
FROM Employee;
Q4. Can CASE WHEN be used with aggregate functions?

Answer: Yes.

SELECT
SUM(CASE WHEN Gender='Male' THEN 1 ELSE 0 END) AS MaleCount,
SUM(CASE WHEN Gender='Female' THEN 1 ELSE 0 END) AS FemaleCount
FROM Employee;
Q5. Where can CASE WHEN be used?

Answer:

SELECT
ORDER BY
GROUP BY
HAVING
UPDATE