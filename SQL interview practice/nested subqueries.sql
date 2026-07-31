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

===============================================================
/*Business Scenario

The HR manager says:

"Find the departments whose average salary is greater than the overall average salary of all employees."

Table: Employees
EmployeeID | EmployeeName | Department | Salary

Example data:

1 | Asma   | HR      | 30000
2 | Rahul  | HR      | 40000
3 | John   | IT      | 70000
4 | Sara   | IT      | 60000
5 | David  | Sales   | 50000
6 | Aisha  | Sales   | 45000
🎯 Your task

Display:

Department

whose average salary is greater than the overall average salary.*/

CREATE TABLE Employees_nestedsq
(
    EmployeeID INT PRIMARY KEY,
    EmployeeName VARCHAR(50),
    Department VARCHAR(30),
    Salary INT
);

INSERT INTO Employees_nestedsq
VALUES
(1,'Asma','HR',30000),
(2,'Rahul','HR',40000),
(3,'John','IT',70000),
(4,'Sara','IT',60000),
(5,'David','Sales',50000),
(6,'Aisha','Sales',45000),
(7,'Ali','Finance',80000),
(8,'Priya','Finance',75000),
(9,'Rohan','Marketing',35000),
(10,'Meena','Marketing',38000);

--Department whose average salary is greater than the overall average salary.
select department 
from Employees_nestedsq
group by department
having avg(salary)>
(
select avg(salary)
    from Employees_nestedsq
   )

   =====================================================================
  /* Here's the interview trick

Whenever you see:

Average of SUM
Average of COUNT
Maximum of SUM
Minimum of COUNT

Immediately think:

🚨 Nested Subquery / Derived Table Required

Whenever you see:

Average Salary
Maximum Salary
Minimum Salary
Overall Average

Usually a single subquery is enough.

🧠 Your decision tree
Need AVG(SUM()) ?
        │
      YES
        │
Nested Subquery
        │
      NO
        │
Simple Subquery*/
=====================================================
--Find the departments whose total salary is greater than the average total salary of all departments.
select department
from Employees_nestedsq
group by department
having sum(salary)>
(
    select avg(total_sal)
    from
    (
    select sum(salary) as total_Sal
    from Employees_nestedsq
    group by department
    ) t
);
/*
Result:
department
Finance
IT*/

===========================================================
--Find the departments whose employee count is greater than the average employee count across all departments.

select department,count(*) as emp_count_dept
from Employees_nestedsq
group by department
having count(*)>
(
select avg(total_emp)
from
    (
    select count(*) as total_emp
        from Employees_nestedsq
         group by department
      ) t
);

/*
Result:
department	emp_count_dept

Each department has 2 employees. The average is also 2. Since the condition is > 2, no department satisfies it, so the query correctly returns no rows."*/
================================================================================

/*Business Scenario

You're working for an e-commerce company.

The manager asks:

"What is the average number of orders placed by each customer?"*/

SELECT AVG(orders_count)
FROM (
    SELECT CustomerID,
           COUNT(OrderID) AS orders_count
    FROM Orders
    GROUP BY CustomerID
) t;

=========================================

/*Business Scenario

You're working for an online shopping company.

The manager asks:

"Find the average revenue generated per customer."

Table:

Orders
------
OrderID
CustomerID
Amount

*/
SELECT AVG(revenue_per_cust)
FROM (
    SELECT CustomerID,
           sum(amount) AS revenue_per_cust
    FROM Orders
    GROUP BY CustomerID
) t;

