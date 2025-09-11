/*Top_where_between_join_right join_left inner join_alias_orderby_count(*)_functions_sum_dateadd_groupby*/
SELECT TOP (1000) [OrderID]
      ,[OrderDate]
      ,[CustomerID]
      ,[OrderTotal]
  FROM [KCC].[dbo].[Orders]
  where OrderTotal<1000

/* between,   */
SELECT TOP (1000) [OrderID]
      ,[OrderDate]
      ,[CustomerID]
      ,[OrderTotal]
  FROM [dbo].[Orders]
  where OrderTotal between 1000 and 2000

  /* JOINs default Inner join its us all customers that has orders and also all orders that have customers
  if a customer doent have order means he wont shown here*/

  Select OrderID,OrderDate, OrderTotal, CustomerName, Phone
  from dbo.Orders Join dbo.Customers 
  on dbo.Customers.CustomerID=dbo.Orders.CustomerID

  /*Alias name */
    Select OrderID,OrderDate, OrderTotal, CustomerName, Phone
  from dbo.Orders o Join dbo.Customers c
  on o.CustomerID=c.CustomerID

  /*who doent have order but i want that customer- right join-*/
    Select OrderID,OrderDate, OrderTotal, CustomerName, Phone
  from dbo.Orders o Right outer join dbo.Customers c
  on o.CustomerID=c.CustomerID
  
Select OrderID,OrderDate, OrderTotal, CustomerName, Phone,c.CustomerID
  from dbo.Orders o left outer join dbo.Customers c
  on o.CustomerID=c.CustomerID

/*order by ascending */
Select OrderID,OrderDate, OrderTotal, CustomerName, Phone,c.CustomerID
  from dbo.Orders o left outer join dbo.Customers c
  on o.CustomerID=c.CustomerID
  order by OrderTotal desc

  /* functions- date   */
select * from dbo.Orders
where OrderDate>='2/18/2022'
/* past onr month date use -1 in date fn*/
select * from dbo.Orders
where OrderDate>=DATEADD(year,-4,getdate())

/*count the above */
select Count(*) from dbo.Orders
where OrderDate>=DATEADD(year,-4,getdate())

/* sum up order total)*/
select sum(ordertotal) as order_total from dbo.orders
where OrderDate>=DATEADD(year,-4,getdate())

/* sum up order total and group by customerid*/
select sum(ordertotal) as order_total from dbo.orders
where OrderDate>=DATEADD(year,-4,getdate())
group by CustomerID


