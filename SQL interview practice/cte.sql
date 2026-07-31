/*CTE
Business Scenario (More realistic)

You're working for an e-commerce company.
Orders
-------
OrderID
CustomerID
Amount

Your manager asks:

Step 1: Calculate the total revenue for each customer.

Step 2: Find customers whose revenue is greater than the average customer revenue.*/

WITH rev_cte as
(
	select 
	OrderID,
	CustomerID,
	Amount,
	sum(amount) over(partition by CustomerID) as cust_revenue
	)
	from orders
)
select customerid
from rev_cte
having cust_revenue>avg(cust_rev)

select 