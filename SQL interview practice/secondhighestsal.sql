--Second highest salary , using subqueries.
--nth salary means n number of times we should q=write the subquery within another, nested queries.
-- this is a technique. o.w use window functions to get it.
CREATE TABLE Employee (
    Id INT,
    Name VARCHAR(50),
    Salary INT
);

INSERT INTO Employee VALUES
(1, 'Joe', 70000),
(2, 'Henry', 80000),
(3, 'Sam', 70000),
(4, 'Max', 90000);

select name, salary 
from employee
where salary<(select max(salary) from employee)--This gives all emp sal except highest

-- name                                               salary     
-- -------------------------------------------------- -----------
-- Joe                                                      70000
-- Henry                                                    80000
-- Sam                                                      70000
=======================================================================
--REQUIRED QUERY TO GET RESULT
select max(salary)
from employee
where salary<(select max(salary) from employee)
--Result:
80000

===================================
--i want to get name along with salary
--trying to get using group by

select name, max(salary) 
from employee
group by name
having salary<(select max(salary) from employee)
--ERROR--in the HAVING clause because it is not contained in either an aggregate function or the GROUP BY clause.

--i want to get name along with secong highest salary

select name, salary
from employee
where salary=(select max(salary)
from employee
where salary<(select max(salary) from employee))
 --Result:
name                                               salary     
-------------------------------------------------- -----------
Henry                                                    80000