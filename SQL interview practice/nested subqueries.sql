/*
Display the customer names whose total spending is greater than the average total spending of all customers
who have placed orders.
*/


SELECT c.CustomerName
FROM Customers c
JOIN Orders o
    ON c.CustomerID = o.CustomerID
GROUP BY c.CustomerID, c.CustomerName
HAVING SUM(o.Amount) >
(
    SELECT AVG(Total_Spent)
    FROM
    (
        SELECT CustomerID,
               SUM(Amount) AS Total_Spent
        FROM Orders
        GROUP BY CustomerID
    ) t
);

/*
🧠 Step 1: Read the question

Ask yourself:

What is the final output?

Example:

Show customer names

👉 Start from Customers table.

🧠 Step 2: Is there GROUP BY?

If the question says:

Total
Count
Average
Maximum
Minimum

👉 Think:

"I need GROUP BY."

🧠 Step 3: Is it comparing with another value?

If you see words like:

greater than average
less than average
higher than maximum
above overall average

👉 Think:

"I need a subquery."

🧠 Step 4: Is it asking for average/count of grouped values?

Example:

Average total spending

Not

Average order amount

Immediately think:

GROUP BY first
↓
Then AVG

Remember this line:

"Aggregate of an aggregate = Derived Table."

Examples:

AVG(SUM())
MAX(COUNT())
MIN(SUM())

👇 Pattern:

SELECT Aggregate(...)
FROM
(
    SELECT Aggregate(...)
    GROUP BY ...
) t
🧠 Step 5: WHERE or HAVING?

Very easy rule:

Rows     → WHERE

Groups   → HAVING

Or even shorter:

No GROUP BY → WHERE

After GROUP BY → HAVING

🧠 Step 6: Which table do I start with?

Ask:

Which table has the final output?

Need customer names?

➡ Customers

Need product names?

➡ Products

Need employee names?

➡ Employees

🧠 Step 7: Group by what?

Remember this interview rule:

Always group by the primary key and the displayed column.

Example:

GROUP BY
CustomerID,
CustomerName

Reason:

IDs are unique. Names may repeat.

⭐ The golden pattern

Whenever you read a difficult SQL question, ask yourself these 6 questions:

✅ What is the output?
✅ Which table has that output?
✅ Do I need GROUP BY?
✅ Am I comparing with another value?
✅ Do I need a subquery?
✅ Is it WHERE or HAVING?
🎯 Your interview mantra

Don't panic. Say this in your mind:

Output → Table → Join → Group → Subquery → Having

That's the order in which you should think.
================================================================

⭐ Codey's SQL Pattern Book (save this)
If the question says...	        Immediately think...
Total per customer	            GROUP BY
Average of totals	            Derived Table → AVG(SUM())
Greater than average	        Subquery
Display names	                Start from the table containing names
Filter aggregate	            HAVING
Filter rows	                    WHERE
Does a row exist?	            EXISTS
Never exists	                NOT EXISTS
Highest	                        TOP 1 + ORDER BY DESC
Duplicates	                    GROUP BY + COUNT(*)

*/