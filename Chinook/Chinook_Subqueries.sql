/* SUB QUERY*/
--Get Employee who directly reports to IT manager
select * from employee;
--if i go and check for IT amnager his empid is 6.

select *
from Employee
where ReportsTo=6;		

--RESULTS ARE we get the IT staff who are reporting to IT manager directly, here we are searcing for IT manager empid manually in emp table.
select FirstName, LastName , ReportsTo
from Employee
where ReportsTo=(select EmployeeId 
				from Employee
				where Title='IT Manager');

--Fetch customer who has placed more than 6 invoices
select * from customer;
select * from INVOICE;

select CustomerId
From INVOICE
Group by CustomerId
having Count(InvoiceID)>6; 
--i should pass these results to another query to get the required result.-i get custids here who ahs more than 6 invoices.
select CustomerId, FirstName, LastName
From Customer
where CustomerId=(select CustomerId
					From INVOICE
					Group by CustomerId
					having Count(InvoiceID)>6);
--this gives an ERROR as the subquery give smultiple custIDs. where caluse needs only one condition. Her we should use IN OPERATOR
select CustomerId, FirstName, LastName
From Customer
where CustomerId IN (select CustomerId
					From INVOICE
					Group by CustomerId
					having Count(InvoiceID)>6);
--the above gives custid,FName and lname columns

--I want to additional column as invoice_count also
select c.CustomerId, FirstName, LastName, i.Invoice_count
From Customer c
Join (
		select CustomerId, COUNT(InvoiceID) AS Invoice_count
					From INVOICE
					Group by CustomerId
					having Count(InvoiceID)>6
					
		) AS i
on c.CustomerId=i.CustomerID;

--here the subquery inside makes a virtual table , so we should use JOIN , 
