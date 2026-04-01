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

windows functions:
top / best / highest / latest
PER group
ROW_NUMBER() OVER (PARTITION BY group ORDER BY metric)

This is the universal pattern analysts reuse:
SELECT *
FROM (
    SELECT column1,
           column2,
           metric,
           ROW_NUMBER() OVER (
               PARTITION BY group_column
               ORDER BY metric DESC
           ) AS rn
    FROM table
) t
WHERE rn = 1;

Step 1: Divide data into groups
Step 2: Rank rows inside each group
Step 3: Keep rank = 1

We cant do,WHERE ROW_NUMBER() = 1   ❌, So we:

1. Create ranking in subquery
2. Filter in outer query

Step 1: Create a ranked list (inner query)
Step 2: Save it as a temporary sheet (t)
Step 3: Filter top rows (outer query)

SQL Mistakes Log – Chinook Project

7. Business interpretation after query
   Early queries focused only on SQL results.

Better approach:
Always add an insight like:

-- Insight:
-- Iron Maiden generates the highest revenue in the Chinook dataset.

---

8. Using wrong tables for required data
   Mistake: Tried to calculate sales using Track table.

Example mistake:
SUM(t.Quantity)

Why it's wrong:
Track table does not store purchase quantity.

Correct approach:
Use InvoiceLine table for sales data.

Lesson:
Always identify which table actually contains the required data.

---

9. Missing joins in data flow
   Mistake: Skipped InvoiceLine while calculating sales.

Why it's wrong:
Sales information exists only in InvoiceLine.

Correct approach:
Follow correct schema path:

Genre → Track → InvoiceLine

Lesson:
Always trace the relationship path before writing joins.

---

10. Missing GROUP BY when using aggregation
    Mistake: Used SUM() without GROUP BY.

Why it's wrong:
SQL requires grouping when aggregation is used with non-aggregated columns.

Correct approach:
GROUP BY all non-aggregated columns.

Lesson:
If using SUM, COUNT, AVG → always check GROUP BY.

---

11. Using column aliases incorrectly
    Mistake: Used alias names incorrectly or inconsistently.

Example mistake:
TrackSold instead of TracksSold

Why it's wrong:
SQL treats aliases exactly as written.

Lesson:
Be consistent with alias names and avoid typos.

---

12. Using aliases inside window functions
    Mistake: Tried to use alias in ORDER BY inside ROW_NUMBER().

Example mistake:
ORDER BY TotalRevenue

Why it's wrong:
SQL Server does not allow alias inside window functions.

Correct approach:
Repeat the expression:
ORDER BY SUM(i.Total) DESC

Lesson:
Inside window functions, use full expressions instead of aliases.

---

13. Trying to filter window functions using HAVING
    Mistake: Used HAVING with ROW_NUMBER().

Example mistake:
HAVING ROW_NUMBER()...

Why it's wrong:
Window functions cannot be used in HAVING or WHERE directly.

Correct approach:
Use subquery and filter outside:

SELECT * FROM (...) t WHERE rn = 1

Lesson:
Window function → compute first → filter later.

---

14. Forgetting commas in SELECT or GROUP BY
    Mistake: Missing commas between columns.

Example mistake:
c.LastName
i.BillingCountry

Why it's wrong:
SQL syntax requires commas between columns.

Lesson:
Always double-check commas in SELECT and GROUP BY.

---

15. Confusion between business metric and question
    Mistake: Used revenue when question asked for popularity.

Example:
Used SUM(UnitPrice * Quantity) instead of SUM(Quantity).

Lesson:
Always match metric to business question:

Popularity → Quantity
Revenue → Price × Quantity

---

16. Not understanding what query output represents
    Mistake: Thought query gives country revenue when it gives customer revenue per country.

Lesson:
Always ask:
“What does each row represent?”

---

17. Overusing SELECT *
    Mistake: Used SELECT * in final output.

Why it's not ideal:
Includes unnecessary columns (like rn).

Better approach:
Select only required columns.

Lesson:
Use SELECT * for testing, not final output.

---

18. Alias naming confusion
    Mistake: Using unclear or conflicting alias names.

Lesson:
Use clear short aliases:

c → Customer
i → Invoice
il → InvoiceLine
t → Track
g → Genre

---

19. Trying to do everything in one query
    Mistake: Combined aggregation, ranking, and filtering in one step.

Why it's wrong:
SQL processes queries in stages.

Correct approach:

Step 1: GROUP BY
Step 2: Window function
Step 3: Outer query filter

Lesson:
Break problems into steps.

---

20. Small typos causing errors
    Mistake examples:
    group byg
    TrackSold vs TracksSold

Lesson:
Most SQL errors are small typos — read carefully.

---
21. Grouping at wrong granularity
    Mistake: Grouped by full date instead of month.

Example mistake:
GROUP BY InvoiceDate

Why it's wrong:
This groups data at daily level instead of monthly level, which does not match the business question.

Correct approach:
GROUP BY YEAR(InvoiceDate), MONTH(InvoiceDate)

Lesson:
Always match the level of aggregation (day, month, year) with the business requirement.

---

22. Selecting columns not in GROUP BY
    Mistake: Selected InvoiceDate without grouping or aggregating it.

Example mistake:
SELECT InvoiceDate, SUM(Total)

Why it's wrong:
SQL requires that all selected columns must either be included in GROUP BY or be aggregated.

Correct approach:
Remove InvoiceDate or include it in GROUP BY (depending on requirement).

Lesson:
Every column in SELECT must be:
✔ part of GROUP BY
OR
✔ inside an aggregate function (SUM, COUNT, etc.)

---

23. Grouping at wrong granularity (time analysis)
    Mistake: Grouped by full date instead of month.

Example mistake:
GROUP BY InvoiceDate

Why it's wrong:
This groups data at daily level instead of monthly level.

Correct approach:
GROUP BY YEAR(InvoiceDate), MONTH(InvoiceDate)

Lesson:
Always match aggregation level with business question (day vs month vs year).

---

24. Selecting columns not in GROUP BY
    Mistake: Selected InvoiceDate without grouping or aggregating it.

Why it's wrong:
SQL requires all selected columns to be grouped or aggregated.

Lesson:
Every column in SELECT must be:
✔ in GROUP BY
OR
✔ inside an aggregate function

---

25. Using TOP instead of handling ties
    Mistake: Used TOP 5 when multiple rows had equal values.

Why it's wrong:
TOP may exclude valid tied results.

Correct approach:
Use RANK() when ties matter.

Lesson:
TOP → arbitrary cutoff
RANK → includes ties

---

26. Not recognizing when to use RANK vs ROW_NUMBER
    Mistake: Used ROW_NUMBER() even when ties existed.

Difference:
ROW_NUMBER() → forces unique rank
RANK() → allows ties

Lesson:
Use:
ROW_NUMBER → when only one result needed
RANK → when multiple top results possible

---

27. Overusing SELECT * in final output
    Mistake: Used SELECT * in final query output.

Why it's not ideal:
Returns unnecessary columns (like rn).

Better approach:
Select only required columns.

Lesson:
SELECT * → testing
Explicit columns → final output

---

28. Not identifying correct analysis pattern
    Mistake: Initially confused between:

* aggregation problem
* ranking problem

Lesson:
Recognize patterns:

GROUP BY → summary
WINDOW FUNCTION → top per group
SIMPLE SUM → overall totals

---

29. Not verifying result meaning
    Mistake: Ran query but unsure what output represents.

Lesson:
Always ask:
“What does each row represent?”

---

30. Ignoring ties in business interpretation
    Mistake: Initially treated top tracks as unique winners.

Correction:
Multiple tracks had equal top sales.

Lesson:
Always check for equal values in results.

---

31. Not aligning SQL with business question
    Mistake: Focused on writing query instead of interpreting requirement.

Lesson:
Always convert question into:

Group → Metric → Output

Example:
Top track per genre →
Group = Genre
Metric = Quantity
Output = Track

---

32. Not simplifying final queries
    Mistake: Writing complex queries without refinement.

Lesson:
After solving:
✔ simplify
✔ clean aliases
✔ improve readability
