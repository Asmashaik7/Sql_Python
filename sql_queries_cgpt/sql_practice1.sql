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

-- 10. List all departments where maximum salary is less than 80000. -->

--List departments that have between 2 and 4 employees (inclusive).

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


