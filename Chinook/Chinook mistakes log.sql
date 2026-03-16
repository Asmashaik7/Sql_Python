/*SQL Mistakes Log – Chinook Project

1. Using the wrong column in calculations
   Mistake: Used TrackId instead of Quantity in revenue calculations.
   Example mistake:
   SUM(il.UnitPrice * il.TrackId)

Why it's wrong:
TrackId is just an identifier, not the number of items sold.

Correct approach:
SUM(il.UnitPrice * il.Quantity)

Lesson:
Always check what a column represents before using it in calculations.

---

2. Confusing "most popular" with "highest revenue"
   Mistake: Used revenue when the question asked for most popular genres.

Wrong metric:
SUM(UnitPrice * Quantity)

Correct metric:
SUM(Quantity)

Lesson:
Match the metric with the business question.

Most popular → number of items sold
Highest revenue → money generated

---

3. SQL dialect differences (LIMIT vs TOP)
   Mistake: Used LIMIT in SQL Server.

Wrong:
LIMIT 10

Correct in SQL Server:
TOP 10

Lesson:
Different databases have different syntax.

MySQL / PostgreSQL / SQLite → LIMIT
SQL Server → TOP

---

4. Typographical errors in SQL keywords
   Mistake example:
   group byg.genreid

Correct:
GROUP BY g.GenreId

Lesson:
Small typos break SQL queries. Always scan keywords.

---

5. Not always thinking about the data relationships first
   Better approach before writing queries:

Artist → Album → Track → InvoiceLine
Genre → Track → InvoiceLine
Customer → Invoice

Lesson:
Understand the schema path before writing joins.

---

6. Not always grouping by stable identifiers
   Better practice:

GROUP BY ArtistId, ArtistName

instead of only:

GROUP BY Name

Lesson:
IDs prevent grouping errors when names repeat.

---

7. Business interpretation after query
   Early queries focused only on SQL results.

Better approach:
Always add an insight like:

-- Insight:
-- Iron Maiden generates the highest revenue in the Chinook dataset.
