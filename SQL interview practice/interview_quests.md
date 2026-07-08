⭐ Important Theory Questions
WHERE vs HAVING
WHERE → Filters rows before grouping.
HAVING → Filters groups after grouping.
HAVING works with aggregate functions.


DELETE vs TRUNCATE vs DROP
DELETE → Deletes selected/all rows (WHERE allowed).
TRUNCATE → Removes all rows, keeps table.
DROP → Removes table and data.


COUNT
COUNT(*) → Counts all rows.
COUNT(Column) → Counts non-NULL values.
COUNT(DISTINCT Column) → Counts unique non-NULL values.

ORDER BY
Default → ASC
Descending → DESC

Execution Order
FROM
WHERE
GROUP BY
HAVING
SELECT
ORDER BY


CHAR vs VARCHAR
CHAR → Fixed length.
VARCHAR → Variable length.


PRIMARY KEY
Unique
No duplicates
No NULL
One primary key constraint per table


FOREIGN KEY
Maintains relationship
Can have duplicate values
Can contain NULL (unless restricted)

UNION vs UNION ALL
UNION → Removes duplicates.
UNION ALL → Keeps duplicates.
UNION ALL is generally faster.


🎯 Three ways to solve "Highest Salary"
Interview Question	                                Best Answer
Highest salary in each department	                MAX() + GROUP BY
Employee(s) with highest salary in each department	DENSE_RANK()
Same question using subquery	                    Correlated subquery