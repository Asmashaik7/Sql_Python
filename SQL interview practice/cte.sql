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
