-- SUB QUERIES
--TO get Name and salary of employees whose salaries >500000
select 
* 
from EMPLOYEES
/*
EMPID	NAME	Department	Salary
1	A	IT	500000
2	B	IT	600000
3	C	IT	600000
4	D	HR	400000
5	F	HR	450000
*/
------------------------------------
select 
	Name,
	Salary
from 
EMPLOYEES 
where salary >
	(select avg(salary) from EMPLOYEES) --avg sal is 510000 here.
/*
Name	Salary
B	600000
C	600000
*/

-- here we dont need group by as in outer query we are not showing avg(), aggregate column
---------------------------------------
select 
	Name,
	Salary,
	avg(salary) as Average
from 
EMPLOYEES 
group by 
	Name, salary 
		having salary >(select avg(salary) from EMPLOYEES)
/*
Name	Salary	Average
B	600000	600000
C	600000	600000
*/
--here calculates avg of each salary
------------------------------------------------------
-- here we need group by as in outer query we are showing avg(), aggregate column
select 
	Name,
	Salary,
	avg(salary)
from 
EMPLOYEES 
	group by name,salary
	having salary>
		(select avg(salary) from EMPLOYEES)



