--calculating DOB 
CREATE TABLE Employee_DatePractice (
    EmpID INT,
    EmpName VARCHAR(50),
    DOB DATE,
    DOJ DATE
);

INSERT INTO Employee_DatePractice VALUES
(1,'Ravi','1998-05-12','2022-01-10'),
(2,'Priya','1995-08-20','2020-06-15'),
(3,'Arjun','2000-03-25','2024-02-01');

INSERT INTO Employee_DatePractice VALUES
(4,'Sneha','1997-12-30','2025-05-20'),
(5,'Kiran','1999-01-18','2025-05-24'),
(6,'Anu','1996-07-14','2025-04-28'),
(7,'Vikram','1993-11-05','2023-12-15'),
(8,'Meera','2001-09-09','2025-01-02');

select * from Employee_DatePractice
/*
EmpID	EmpName	DOB	DOJ
1	Ravi	1998-05-12	2022-01-10
2	Priya	1995-08-20	2020-06-15
3	Arjun	2000-03-25	2024-02-01
4	Sneha	1997-12-30	2025-05-20
5	Kiran	1999-01-18	2025-05-24
6	Anu	1996-07-14	2025-04-28
7	Vikram	1993-11-05	2023-12-15
8	Meera	2001-09-09	2025-01-02*/

select empid, EmpName,DOJ, datediff(year,DOB,getdate()) as EmpAge
from Employee_DatePractice
/*
empid	EmpName	DOJ	    EmpAge
1	Ravi	2022-01-10	28
2	Priya	2020-06-15	31
3	Arjun	2024-02-01	26
4	Sneha	2025-05-20	29
5	Kiran	2025-05-24	27
6	Anu	    2025-04-28	30
7	Vikram	2023-12-15	33
8	Meera	2025-01-02	25
*/
--here the problem is age is not accurate, even when birth month arrives or not, age is calculated .
--datediff does NOT calculate exact birthday age here.
--mainly compares the YEAR part, not exact birthday completion.








