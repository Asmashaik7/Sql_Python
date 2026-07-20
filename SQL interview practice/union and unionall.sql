
/*UNION and UNION ALL

Employees
EmpID	Name
1		Asma
2		Rahul
3		John

Customers
CustID	Name
101		Rahul
102		Sara
103		John
Q1

Write a query to display unique names from both tables.
select Name from Employees
UNION
select Name from Customers;
-------------------------------------
Q2

Write a query to display all names, including duplicates.
select Name from Employees
UNION ALL
select Name from Customers;
--------------------------------------------------
Q3

Will this query work? If No, tell me why.

SELECT EmpID, Name
FROM Employees

UNION

SELECT Name
FROM Customers;
-- This doesnt work because the columns are not equal in count. If we write Empid before Name in second select stat, then it might worked.

================================================
Next 3 Questions
Tables

Employees

EmpID	Name	Salary
1		Asma	50000
2		Rahul	60000

Managers

MgrID	Name	Salary
101		John	90000
102		Rahul	60000

Q1
Write a query to return unique Name and Salary from both tables.
select Name, Salary from Employees
UNION 
Select Name, Salary from Managers


Q2
Write a query to return all Name and Salary from both tables.
select Name, Salary from Employees
UNION ALL
Select Name, Salary from Managers

Q3

Will this work?

SELECT Name, Salary
FROM Employees

UNION

SELECT Salary, Name
FROM Managers;

If No, tell me why. If Yes, explain what happens.
⭐ Interview Rule
SQL matches columns by position, not by name.
So it compares:

1st column ↔ 1st column
2nd column ↔ 2nd column

It does not care that one is called Name and the other Salary.

============================================================================
Interview Revision (5 points only):

UNION → Removes duplicates.
UNION ALL → Keeps duplicates, faster.
Same number of columns required.
Corresponding columns must have compatible data types.
Output column names come from the first SELECT.*/