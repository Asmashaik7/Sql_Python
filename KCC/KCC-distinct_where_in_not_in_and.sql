select CustomerName, Notes from dbo.Customers

select * from dbo.Customers

select CustomerName as [Customer Name] from dbo.Customers
/*tree delicious is twice*/

select DISTINCT CustomerName as [Customer Name] from dbo.Customers
/*i got distinct names*/

Select top(3) * from dbo.Customers

/*filtering with where clause*/
Select * from dbo.Customers
where State='WA'
/*not equal - <> or !=*/
select * from dbo.Customers
where state <>'WA'
select * from dbo.Customers
where state !='WA'
/* where clause - or*/
select * from dbo.Customers
where state ='WA' or state='NY' or state='UT'
/*cleaner code for the above*/
select * from dbo.Customers
where state IN('WA','NY','UT')

/* not in the above states*/
select * from dbo.Customers
where state NOT IN('WA','NY','UT')


select * from dbo.Customers

/* i wan to locate a customer who is in US*/
select * from dbo.Customers
where CustomerName ='Tres Delicious' AND country='United States' or Country='France'

select * from dbo.Customers
where CustomerName ='Tres Delicious' AND (country='United States' or Country='France')
/* i wan to locate a customer whose ame starts with letter A- LIke %- any after A, there an be any number of characters */
select * from dbo.Customers
where CustomerName Like 'A%'AND (country='United States' or Country='France')

/* Not like*/
select * from dbo.Customers
where CustomerName Not Like 'A%'AND (country='United States' or Country='France')

/* Filter Numeriv values- orderstable*/



