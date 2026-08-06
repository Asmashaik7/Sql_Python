/*CTE*/

CREATE TABLE Orders1
(
    OrderID INT PRIMARY KEY,
    CustomerID INT,
    OrderDate DATE,
    Amount DECIMAL(10,2)
);

INSERT INTO Orders1
VALUES
(101, 1, '2026-01-05', 1200),
(102, 1, '2026-01-12', 1800),
(103, 1, '2026-02-01', 1500),

(104, 2, '2026-01-03', 500),
(105, 2, '2026-01-20', 700),

(106, 3, '2026-01-08', 2500),
(107, 3, '2026-01-18', 2200),
(108, 3, '2026-02-10', 1800),

(109, 4, '2026-01-10', 900),

(110, 5, '2026-01-02', 3500),
(111, 5, '2026-01-15', 2000),
(112, 5, '2026-02-05', 2500),

(113, 6, '2026-01-07', 600),
(114, 6, '2026-02-12', 700),

(115, 7, '2026-01-09', 4000),
(116, 7, '2026-02-14', 1500),
(117, 7, '2026-02-20', 1000),

(118, 8, '2026-01-25', 800),
(119, 8, '2026-02-18', 900),

(120, 9, '2026-01-30', 5000),
(121, 9, '2026-02-22', 2000),

(122, 10, '2026-02-25', 1200);

/*Business Scenario (More realistic)

You're working for an e-commerce company.
Orders
-------
OrderID
CustomerID
Amount

Your manager asks:

Step 1: Calculate the total revenue for each customer.
Step 2: Find customers whose revenue is greater than the average customer revenue.*/

WITH CustomerRevenue AS
(
    SELECT
        CustomerID,
        SUM(Amount) AS Revenue
    FROM Orders1
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
/*Result
CustomerID	Revenue
1	60800
*/
=========================================================

/*Question 1 (Easy)

Create a CTE that returns:
CustomerID
TotalRevenue
Then display all customers.
*/
with cte1 AS 
(
    select CustomerID,
            sum(Amount) as TotalRevenue
            from orders1
            group by CustomerID
)
select CustomerID, TotalRevenue from cte1;
/*
CustomerID	TotalRevenue
1	4500.00
2	1200.00
3	6500.00
4	900.00
5	8000.00
6	1300.00
7	6500.00
8	1700.00
9	7000.00
10	1200.00*/

/*Business Scenario

The Sales Manager says:

"Show me customers whose total revenue is greater than ₹5000."

Modify your current query.

Don't create a new CTE. Reuse cte1 and write only the outer query to filter the results.*/

with cte1 AS 
(
    select CustomerID,
            sum(Amount) as TotalRevenue
            from orders1
            group by CustomerID
)
select CustomerID, TotalRevenue from cte1
where TotalRevenue>5000;
/*
CustomerID	TotalRevenue
3	6500.00
5	8000.00
7	6500.00
9	7000.00
*/

/*Tiny Interview Challenge (No SQL)

If I move the condition:

WHERE TotalRevenue > 5000

inside the CTE, will it work?

Just answer Yes or No, and explain why. Don't write SQL yet. This question will tell me whether you've understood SQL's execution order.
ANswr: no. inside cTE thats an aggregate function , if at all we need to check the condition inside cte , we should use HAVING.
HAVING vs WHERE with CTE

Thinking Flow
Inside GROUP BY?
        ↓
Aggregate still being calculated?
        ↓
Use HAVING
        ↓
CTE created
        ↓
Aggregate becomes a normal column
        ↓
Use WHERE
🧠 Memory Trick
------------------------

Before the CTE → HAVING

After the CTE → WHERE*/
============================================================
/*
Are these two queries logically equivalent?

Query A

WITH cte AS
(
    SELECT CustomerID,
           SUM(Amount) AS TotalRevenue
    FROM Orders1
    GROUP BY CustomerID
    HAVING SUM(Amount) > 5000
)
SELECT *
FROM cte;

Query B

WITH cte AS
(
    SELECT CustomerID,
           SUM(Amount) AS TotalRevenue
    FROM Orders1
    GROUP BY CustomerID
)
SELECT *
FROM cte
WHERE TotalRevenue > 5000;

Answer: Query A uses HAVING because the aggregation (SUM(Amount)) is happening inside the CTE.
Query B uses WHERE because TotalRevenue is already a regular column after the CTE is created.
Both queries return the same result.
==================================================
Business Scenario

The manager asks:

"Show the Top 3 customers based on TotalRevenue."

Use the same cte1. Write only the outer query. Don't change the CTE.
Should I sort the temporary table when creating it, or should I sort it when retrieving data from it?
The answer is: when retrieving data from it.
*/
with cte1 AS 
(
    select CustomerID,
            sum(Amount) as TotalRevenue
            from orders1
            group by CustomerID
)
select top 3 CustomerID, 
TotalRevenue 
from cte1
order by totalrevenue desc;
/*
Result:
CustomerID	TotalRevenue
5	8000.00
9	7000.00
3	6500.00
7   6500.00- in results this row is missing. as we asked only top 3.
so we use another CTE to get the tied ranks using dese rank
*/

with cte1 AS 
(
    select CustomerID,
            sum(Amount) as TotalRevenue
            from orders1
            group by CustomerID
),
rankedCustomers as
(
SELECT
    CustomerID,
    TotalRevenue,
    DENSE_RANK() OVER(ORDER BY TotalRevenue DESC) AS RevenueRank
FROM cte1
)
SELECT
    CustomerID,
    TotalRevenue,
   RevenueRank
   from rankedCustomers
   where RevenueRank<=3;
/*
CustomerID	TotalRevenue	RevenueRank
5	8000.00	1
9	7000.00	2
7	6500.00	3
3	6500.00	3
*/

===================================================
