/*🆕 ISNULL() — SQL Server

Since you're using SQL Server / SSMS, ISNULL() is worth knowing.

First, don't memorize yet.

You've already solved this:

COALESCE(Phone, 'Not Provided')

Now imagine your manager asks:

"Can we do the same thing using a SQL Server-specific function?"

That's where ISNULL() comes in.

🧠 Basic idea
ISNULL(value, replacement)

It means:

If value is NULL, return replacement; otherwise return value.

For example:

ISNULL(Discount, 0)
Discount = 100 → 100
Discount = NULL → 0

And with text:

ISNULL(Phone, 'Not Provided')
Phone exists → phone number
Phone is NULL → Not Provided*/
select * FROM Orders_NULL;

/*
OrderID	CustomerID	Sales	Discount
1	        101	    1000.00	100.00
2	        102	    1500.00	NULL
3	        103	    800.00	50.00
4	        104	    2000.00	NULL
5	        105	    1200.00	200.00*/

SELECT
    Discount,
    ISNULL(Discount, 0) AS Discount_Handled
FROM Orders_NULL;


--=====================================================
/*Now let's compare them

For this simple situation:

COALESCE(Discount, 0)

and

ISNULL(Discount, 0)

produce the same result.

But they aren't exactly the same function.

COALESCE()	                        ISNULL()
Standard SQL function	            SQL Server-specific function
Can accept multiple values	        Accepts 2 values
Returns first non-NULL value	    Returns first value if non-NULL, otherwise second
Works well for fallback chains	    Simple NULL replacement

For example, this works with COALESCE():

COALESCE(PersonalPhone, WorkPhone, Email, 'No Contact')

But ISNULL() only takes:

ISNULL(PersonalPhone, WorkPhone)

So the easiest way to remember it is:

ISNULL() = two choices
COALESCE() = multiple choices

🔥 Let's test your understanding with a business scenario

A company has this table:

EmployeeID | Salary | Bonus
-----------|--------|------
101        | 50000  | 5000
102        | 60000  | NULL
103        | 45000  | 3000

The HR team wants to calculate:

Total Compensation = Salary + Bonus

If Bonus is missing, they want to treat it as 0.

You now have two possible functions.

Your turn:

Which one would you choose here:

ISNULL() or COALESCE()?
ans: isnull()

*/

CREATE TABLE EmployeeBonus
(
    EmployeeID INT,
    EmployeeName VARCHAR(50),
    Salary DECIMAL(10,2),
    Bonus DECIMAL(10,2)
);

INSERT INTO EmployeeBonus
VALUES
(101, 'Ayesha', 50000, 5000),
(102, 'Rahul', 60000, NULL),
(103, 'Sara', 45000, 3000),
(104, 'Imran', 55000, NULL);

select * from EmployeeBonus;
/*
EmployeeID	EmployeeName	Salary	Bonus
101	        Ayesha	50000.00	5000.00
102	        Rahul	60000.00	NULL
103	        Sara	45000.00	3000.00
104	        Imran	55000.00	NULL

Manager asks:

"Show EmployeeID, EmployeeName, Salary, Bonus, and TotalCompensation. Treat a missing Bonus as 0."*/

select EmployeeID, 
EmployeeName, 
Salary, 
Bonus,
isnull(bonus,0) as bonus_handled,
(salary+bonus_handled) as TotalCompensation
from EmployeeBonus;

select EmployeeID, 
EmployeeName, 
Salary, 
Bonus,
(salary+isnull(bonus,0)) as TotalCompensation
from EmployeeBonus;
/*
EmployeeID	EmployeeName	Salary	Bonus	TotalCompensation
101	Ayesha	50000.00	5000.00	55000.00
102	Rahul	60000.00	NULL	60000.00
103	Sara	45000.00	3000.00	48000.00
104	Imran	55000.00	NULL	55000.00
=============================================================================
You've now seen:

ISNULL()
ISNULL(Bonus, 0)

Two arguments only:

value → replacement
COALESCE()
COALESCE(PersonalPhone, WorkPhone, Email, 'No Contact')

Multiple values:

value → value → value → fallback

So your current mental model is good:

ISNULL() → simple two-choice NULL handling
COALESCE() → first non-NULL from multiple choices*/

