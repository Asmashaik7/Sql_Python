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
	sum(amount) as cust_revenue
    group by customerID
	)
	
)
select customerid
from rev_cte
having cust_revenue>avg(cust_rev)
======================================================

WITH CustomerRevenue AS
(
    SELECT
        CustomerID,
        SUM(Amount) AS Revenue
    FROM Orders
    GROUP BY CustomerID
)

SELECT
    CustomerID,
    Revenue
FROM CustomerRevenue
WHERE Revenue >
(
    SELECT AVG(Revenue)
    FROM CustomerRevenue
);