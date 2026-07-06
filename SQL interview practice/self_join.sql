-- 181. Employees Earning More Than Their Managers
-- Easy

-- Table: Employee

--Input: 
Employee table:
+----+-------+--------+-----------+
| id | name  | salary | managerId |
+----+-------+--------+-----------+
| 1  | Joe   | 70000  | 3         |
| 2  | Henry | 80000  | 4         |
| 3  | Sam   | 60000  | Null      |
| 4  | Max   | 90000  | Null      |
+----+-------+--------+-----------+
-- id is the primary key (column with unique values) for this table.
-- Each row of this table indicates the ID of an employee, their name, salary, and the ID of their manager.
-- ===================================
-- Q1: Employees earning more than their managers
-- Source: LeetCode 181
-- ===================================
select e.name as Employee
from Employee e
join Employee m
on e.managerId=m.id
where e.salary>m.salary


| Employee |
| -------- |
| Joe      |

-- Self join = same table used twice, given 2 aliases (e and m)
-- "e" = employee copy, "m" = manager copy
-- Join condition: e.managerId = m.id
--    → means: e's manager points to m's id
--    → so e = employee, m = manager (roles match alias names)
-- No special "SELF JOIN" keyword exists — it's just a regular JOIN
--    on the SAME table, that's what makes it "self"
-- WHERE e.salary > m.salary → keeps only rows where employee > manager
==========================================================================================
--Question:2 Find employees who earn the same salary as at least one other employee (but are different people).
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

select e.Name, e.Salary
from Employee e
join employee m
on e.salary=m.salary
where e.id<>m.id

--Result:
-- Name        Salary
-- Joe         70000
-- Sam         70000

--on e.salary = m.salary → matches rows where salary is common → Joe(70000)↔Sam(70000) match both ways, Henry and Max don't match anyone else
--where e.id <> m.id → makes sure we're not matching someone to themselves

=======================================================================
--Question:3 Find all pairs of employees who work in the same department (show both names, avoid showing the same pair twice).

CREATE TABLE Employee (
    Id INT,
    Name VARCHAR(50),
    DeptId INT
);

INSERT INTO Employee VALUES
(1, 'Joe', 10),
(2, 'Henry', 20),
(3, 'Sam', 10),
(4, 'Max', 20),
(5, 'Anna', 10);

select e.name, m.name
from Employee e
join Employee m
on e.deptid=m.deptid
where e.id<>m.id

--Result
-- name                                               name                                              
-- -------------------------------------------------- --------------------------------------------------
-- Joe                                                Sam                                               
-- Joe                                                Anna                                              
-- Henry                                              Max                                               
-- Sam                                                Joe                                               
-- Sam                                                Anna                                              
-- Max                                                Henry                                             
-- Anna                                               Joe                                               
-- Anna                                               Sam  
--here we got duplicated pairs. in this e.id <> m.id, we get all diff pairs which are not equal to each other. it may be duplicate pairs also.

--If we change the condition to e.id < m.id, then we get only pair which are not duplicates
select e.name, m.name
from Employee e
join Employee m
on e.deptid=m.deptid
where e.id<m.id

-- name                                               name                                              
-- -------------------------------------------------- --------------------------------------------------
-- Joe                                                Sam                                               
-- Henry                                              Max                                               
-- Joe                                                Anna                                              
-- Sam                                                Anna  
=================================================================
