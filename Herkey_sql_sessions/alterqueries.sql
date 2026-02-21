-- 1.  Add a New Columns

--Let’s add Salary to Employees1:
use Herkey_practice;

alter table Employees1
ADD salary INT;

select * from Employees1;

--Let’s add JoiningDate:

alter table Employees1 
ADD JoiningDate DATE 
DEFAULT GETDATE();
-- DEFAULT only applies to future inserts
--It does NOT automatically update existing rows

update Employees1
set JoiningDate=GETDATE()
where JoiningDate IS NULL;

select Name, JoiningDate from Employees1;

alter table Employees1
drop Column JoiningDate;