--2 MILLIONS ROWS  -10 MIN --2 MIN
--What is a Clustered Index?

--A clustered index physically sorts the table data based on the indexed column.

SELECT * FROM EMPLOYEES WHERE DEPARTMENT='IT'
/*
EMPID	NAME	Department	Salary
1	A	IT	500000
2	B	IT	600000
3	C	IT	600000*/

CREATE CLUSTERED INDEX idx_EmpID on Employees(EmpID)  
--Store the rows on disk in the order of EmpID.

SELECT * FROM EMPLOYEES

/*Why is it fast?

Suppose your table has 2 million rows.

Without an index:

SELECT *
FROM Employees
WHERE EmpID = 1500000;

SQL Server may have to scan row after row.

1
2
3
4
...
1500000

This is called a Table Scan.

With a clustered index:

SQL Server can navigate through a B-Tree structure and jump near the required row immediately.

1-1000000
1000001-2000000
1500000 found

Much less work.*/
=============================

