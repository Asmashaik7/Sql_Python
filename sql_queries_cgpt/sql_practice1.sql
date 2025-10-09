-- <!-- logical practice using GROUP BY, HAVING, and WHERE together.

-- 👉 Use this sample table for all queries:
-- employees

-- emp_id	name	department	salary	location
-- 1	Raj	Sales	50000	Chennai
-- 2	Priya	HR	70000	Bangalore
-- 3	John	IT	90000	Hyderabad
-- 4	Ravi	Sales	40000	Chennai
-- 5	Sneha	IT	95000	Bangalore
-- 6	Ahmed	HR	85000	Kolkata
-- 7	Neha	IT	72000	Chennai
-- 8	Kiran	HR	60000	Chennai

--  Questions:
-- 1. List all departments and total salary paid in each department.

-- 2. List departments having more than 2 employees.

-- 3. Show departments where average salary is greater than 75000.

-- 4. List departments with total salary greater than 1.5 lakhs (150000).

-- 5. List locations and how many employees are in each location.

-- 6. Show all locations where employee count is less than 3.

-- 7. List departments and their average salary, but only for departments that have "IT" or "HR".

-- 8. List departments having average salary greater than 60000, and only consider employees from 'Chennai'.

-- 9. For each location, show the total number of distinct departments.

-- 10. List all departments where maximum salary is less than 80000.

--11. List departments that have between 2 and 4 employees (inclusive).

===================================
--1. List all departments and total salary paid in each department.
select department,sum(salary) as Total_salary from employee group by department  

--2. List departments having more than 2 employees.
select department, count(distinct names) as count_emp from employees group by department having count(distinct names)>2;
--here we cant use count_emp(aggregated function) with having, again you need to write count(distinct names)

--3. Show departments where average salary is greater than 75000.
select department,avg(salary) as Avg_salary from employees group by department having avg(salary)>75000;

-- 4. List departments with total salary greater than 1.5 lakhs (150000).
select department, sum(salary) as Total_salary from employees group by department having Total_salary>150000;
 

 --5. List locations and how many employees are in each location.
select location, count(distinct name) as emp_count from employees group by location having emp_count>3;

-- 6. Show all locations where employee count is less than 3.
select location,count(name) as emp_count from employees group by location having count(name)<3;

-- 7. List departments and their average salary, but only for departments that have "IT" or "HR".
select department, avg(salary) as Avg_salary from employees where department in('IT','HR') group by department

-- 8. List departments having average salary greater than 60000, and only consider employees from 'Chennai'.
select department,avg(salary) as Avg_salary from employees where location='Chennai' group by department having avg(salary)>60000; 

-- 9. For each location, show the total number of distinct departments.
select location, count(distinct department) from employees group by location

-- 10. List all departments where maximum salary is less than 80000. -->
select department, max(salary) as maximum_salary from employees group by department having max(salary)<80000;

--11. List departments that have between 2 and 4 employees (inclusive).
select department, count(*) as Employee_count from employees group by department having count(*) between 2 and 4;
-------------------------------------------------------------october------------
🔹 SQL Practice Questions

1. List each department and show the total number of employees in it.
(Basic GROUP BY practice)
select department, count(*) as Employee_count from employees group by department;

2. Show each department and the average salary, sorted in descending order of average salary.
 select department, avg(sal) as Avg_salary from employee group by department order by avg(sal) desc;
-- Explanation:
-- GROUP BY department → groups employees by department.
-- AVG(sal) → calculates the average salary per department.
-- ORDER BY AVG(sal) DESC → sorts the results from highest to lowest average salary.

3. Find departments where average salary is greater than 70,000.
 select department, avg(sal) as Avg_salary from employees group by department having avg(sal)>70000;

4. List all departments having more than 5 employees.
 select department, count(*) as Employee_count from employee group by department having count(*)>5;
--order of execution: FROM  →  WHERE  →  GROUP BY  →  HAVING  →  SELECT  →  ORDER BY

5. Display departments where total salary (SUM) exceeds 200,000.
 select department,sum(salary) as total_sal from employee group by department having sum(salary)>200000;
-- GROUP BY department → groups employees by department.
-- SUM(salary) → calculates total salary per department.
-- HAVING SUM(salary) > 200000 → filters departments where total salary exceeds 2,00,000.

6. Find departments where minimum salary is less than 30,000.
 select department, min(salary) group by department from employees having min(salary)<30000;

7. List departments where the difference between maximum and minimum salary is more than 50,000.
 select department, min(salary), max(salary) from employees group by department having (max(salary)-min(salary)>50000);

8. Show each location and the number of departments present there.
 select location, count(distinct department) as number_dept from employees group by location

9. Find departments where the average salary is between 40,000 and 60,000.
 select department, avg(salary) as avg_sal from employee group by department having avg(salary) between 40000 and 60000;

10. List all departments where the maximum salary is the same as the minimum salary (meaning all employees have identical salaries).
 select department,max(salary) as max_sal, min(salary) as min_sal from employee group by department having max(salary)=min(salary);

--  Some key ones to always remember for GROUP BY + aggregates:
-- HAVING always comes after GROUP BY.
-- WHERE cannot use aggregate functions; only HAVING can.
-- Aliases in SELECT cannot be used in HAVING — use the full aggregate instead.
-- COUNT, SUM, AVG, MIN, MAX can all be used in HAVING expressions.
-- DISTINCT works inside aggregate functions, e.g., COUNT(DISTINCT department).
