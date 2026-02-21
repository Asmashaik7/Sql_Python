--You cannot TRUNCATE a table that is referenced by a foreign key, even if child table is empty.

--SQL Server will block it.
--Step 1 – Check Current Data
SELECT * FROM Employees1;
SELECT * FROM Departments1;

 -- TRUNCATE Child Table
 truncate table Employees1;
 SELECT * FROM Employees1; -- all data is removed from the table. so its just displaying the structure

 INSERT INTO Employees1 (Name, Email, Dept_ID)
VALUES ('TestUser', 'test@mail.com', 1);

SELECT * FROM Employees1; -- one row added


--TRUNCATE Parent Table
 truncate table Departments1;

 /*
 ERROR:
 
 Msg 4712, Level 16, State 1, Line 19
Cannot truncate table 'Departments1' because it is being referenced by a FOREIGN KEY constraint.

Completion time: 2026-02-21T21:54:54.7983402+05:30

-It should FAIL because a foreign key exists referencing it. Even if Employees1 is empty.
-The relationship exists — even if no rows exist.
 */
------------------------------------------
 --How To Make It Work 
 -- first find the constraint name using the above code.
 SELECT name
FROM sys.foreign_keys
WHERE parent_object_id = OBJECT_ID('Employees1');


 alter table Employees1
 drop constraint FK__Employees__Dept___5AEE82B9;

 TRUNCATE TABLE Departments1;--Now it works, as constraint dropped

 select * from Departments1;-- now table is emptied but its structure remained.

 ==================================================================
 --Identity Reset Experiment- first chcek with delete and then truncate
 --run setup before executing 

 SELECT Emp_ID, Name FROM Employees1;
 --Notice the highest Emp_ID value. It was 1 now

 --Delete One Row (Not Truncate)

 DELETE FROM Employees1 WHERE Emp_ID = 1;
  --Notice the highest Emp_ID value. It was 2 now

  INSERT INTO Employees1 (Name, Email, Dept_ID)--
VALUES ('AfterDelete', 'afterdelete@mail.com', 1);--Notice the highest Emp_ID value. It was 22 now
--You’ll see the new Emp_ID continues from the last number. It does NOT reset.

 SELECT Emp_ID, Name FROM Employees1;

 =============================================
 TRUNCATE TABLE Employees1;

 select * from Employees1; -- its showing only structure

 INSERT INTO Employees1 (Name, Email, Dept_ID)
VALUES ('AfterTruncate', 'aftertruncate@mail.com', 1);

 select * from Employees1; -- its showing one row with reset to 1

 SELECT Emp_ID, Name FROM Employees1;-- its showing 1

 ===========================
/* TRUNCATE deallocates data pages and resets the internal identity counter.

DELETE only removes rows — it doesn’t touch the identity metadata.*/












