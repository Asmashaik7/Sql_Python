-- SECTION 1: Find employees who report to the IT Manager

USE Chinook;

SELECT FirstName,
       LastName,
       ReportsTo
FROM Employee
WHERE ReportsTo = (
    SELECT EmployeeId
    FROM Employee
    WHERE Title = 'IT Manager'
);

-- Result
-- Robert  King       6
-- Laura   Callahan   6

-- Insight
-- Two employees (Robert King and Laura Callahan) report directly to the IT Manager.

/* =========================================================
   SECTION 2: Customers with High Purchase Frequency
   Business Question:
   Which customers have placed more than 6 invoices?
   ========================================================= */

-- Step 1: Identify CustomerIds with more than 6 invoices
-- This groups invoices by customer and filters frequent buyers

SELECT CustomerId,
    COUNT(InvoiceId) AS Total_Invoices
FROM Invoice
GROUP BY CustomerId
HAVING COUNT(InvoiceId) > 6;

-- Insight:
-- These customers have made more than 6 purchases, indicating high engagement
-- and potential candidates for loyalty programs or targeted promotions.

/* =========================================================
   SECTION 3: Top Revenue Generating Customers
   Business Question:
   Which customers generate the highest revenue?
   ========================================================= */

SELECT c.CustomerId,
       c.FirstName,
       c.LastName,
       SUM(i.Total) AS TotalSpent
FROM Customer c
JOIN Invoice i
ON c.CustomerId = i.CustomerId
GROUP BY c.CustomerId, c.FirstName, c.LastName
ORDER BY TotalSpent DESC;

-- Insight:
-- Helena Holý is the highest spending customer (49.62).
-- Puja Srivastava is the lowest spending customer (36.64).
-- Most customers spend between 37–40, showing balanced revenue distribution.

/* =========================================================
   SECTION 4: Top Selling Artists
   Business Question:
   Which artists generate the highest sales revenue?
   ========================================================= */

SELECT Top 10 ar.ArtistId,
       ar.Name AS Artist,
       SUM(il.UnitPrice * il.Quantity) AS TotalSales
FROM InvoiceLine il
JOIN Track t 
ON il.TrackId = t.TrackId
JOIN Album al 
ON t.AlbumId = al.AlbumId
JOIN Artist ar 
ON al.ArtistId = ar.ArtistId
GROUP BY ar.ArtistId, ar.Name
ORDER BY TotalSales DESC;

/*Result:
ArtistId | ArtistName | TotalSales
90  Iron Maiden                 68.31
50  Metallica                   61.38
150 U2                          51.48
22  Led Zeppelin                44.55
149 Lost                        39.80
113 Os Paralamas Do Sucesso     30.69
124 R.E.M.                      30.69
82  Faith No More               25.74
118 Pearl Jam                   23.76
58  Deep Purple                 23.76

-- Business Insight:
-- A small number of artists generate a large share of total revenue.
-- Iron Maiden leads overall sales, suggesting strong customer demand for their tracks in the Chinook store.

 =========================================================
SECTION 5: Most Popular Music Genres

Business Question:
Which music genres are purchased the most by customers in the Chinook store?
 =========================================================*/
 
 SELECT TOP 5 
       g.GenreId,
       g.Name AS Genre,
       SUM(il.Quantity) AS TracksSold
FROM Genre g
JOIN Track t
     ON g.GenreId = t.GenreId
JOIN InvoiceLine il
     ON t.TrackId = il.TrackId
GROUP BY g.GenreId, g.Name
ORDER BY TracksSold DESC;

/*Result:
1	Rock	487
7	Latin	207
4	Alternative & Punk	158
3	Metal	146
2	Jazz	44*/

-- Business Insight:
-- Rock music strongly dominates customer purchases in the Chinook store,
-- indicating that rock artists contribute heavily to overall demand.

/* =========================================================
   SECTION 6: Top Revenue-Generating Music Genres

   Business Question:
   Which music genres generate the highest total revenue 
   from track purchases in the Chinook store?
   ========================================================= */

select top 5 g.genreid,g.Name,
 sum(il.Unitprice*il.quantity) as Total_revenue
 from genre g
 join Track t
 on g.genreid=t.genreid
 join InvoiceLine il
 on t.TrackId=il.trackid
 group by g.genreid,g.Name
 order by Total_revenue desc;

/*Result:
1	Rock	482.13
7	Latin	204.93
4	Alternative & Punk	156.42
3	Metal	144.54
2	Jazz	43.56*/

-- Business Insight:
-- Rock dominates genre revenue in the Chinook store, indicating strong
-- customer demand for rock-related tracks. Latin and Alternative & Punk
-- also contribute significantly but remain far behind Rock in total sales.