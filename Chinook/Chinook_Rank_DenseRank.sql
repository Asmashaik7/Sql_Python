use Chinook;
--RANK()
select FirstName, LastName, HireDate, 
Rank() over (Order by HireDate) AS RankByHireDate
From Employee;

--DENSE RANK()
select customerID, SUM(Total) AS TotalSpending , 
	DENSE_RANK() OVER (Order by SUM(Total) DESC) AS SpendingRank
	From INVOICE
	Group By CustomerID;

select InvoiceID, Total, 
	Sum(Total) over (order by  InvoiceDate) AS RunningTotal
	From Invoice;






