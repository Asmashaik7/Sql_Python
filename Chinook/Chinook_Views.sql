--Views are like virtual tables, which can b used multiple times to avoid writing big and complex queries involving 3 to 5 table joins.
--EX: Retrive customer details and their assigned customer representatives

select * 
from Customer c
left join employee e
on c.SupportRepId=e.EmployeeId;

select c.FirstName,
		c.LastName,
		c.CustomerId,
		c.Email,
		e.EmployeeId as SupportRepID,
		e.FirstName AS SupportRepName
from Customer c
left join employee e
on c.SupportRepId=e.EmployeeId;

--convert this to VIEW by using create using descriptive name, so that later we can find it easily without confusion

create VIEW CustomerDetail AS
select c.FirstName,
		c.LastName,
		c.CustomerId,
		c.Email,
		e.EmployeeId as SupportRepID,
		e.FirstName AS SupportRepName
from Customer c
left join employee e
on c.SupportRepId=e.EmployeeId;

SELECT * from CustomerDetail;
-- here we are using view simply by giving its name, rather than writing complex queries again.

select * 
from CustomerDetail
where SupportRepName='Jane';

