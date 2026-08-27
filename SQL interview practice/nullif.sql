--NULLIF
/*So far we've been doing:

"If something is NULL, give me another value."

NULLIF() works almost in the opposite direction:

"If two values are equal, turn the result into NULL."
-------------------
Scenario — Sales Performance

Imagine you're analyzing sales data:

Employee	Sales	Target
Ayesha	10000	10000
Rahul	8000	10000
Sara	12000	10000

Your manager asks:

"Calculate the percentage of target achieved."

The basic business formula is:

Sales ÷ Target × 100

If:

Sales = 5000
Target = 0

then saying 0% would be misleading. The employee did have sales, but there was no target to measure against.
So in a report, something like: No Target
Now let's connect this to NULLIF()

NULLIF() can help us safely handle the division-by-zero problem.

Think of:

NULLIF(Target, 0)

as:

"If Target is 0, turn it into NULL; otherwise keep Target."

So:

Target = 10000 → 10000
Target = 0     → NULL

What should this return?

NULLIF(0, 0)

Just answer:

NULL or 0?

nULL

Exactly! ❤️ NULL.

Because:

NULLIF(0, 0)

asks:

Are 0 and 0 equal?

Yes → return NULL. ✅

Now one more, just to make sure the rule is clear.

What will this return?

NULLIF(5000, 0)

Are 5000 and 0 equal?

👉 What will the result be?

5000

Exactly! 🎯❤️

NULLIF(5000, 0)

Are 5000 and 0 equal?

No → return the first value, 5000. ✅

So now you have the rule:

NULLIF(value1, value2) returns NULL if the two values are equal; otherwise it returns value1.*/
SELECT
    NULLIF(10000, 0) AS Result1,
    NULLIF(0, 0) AS Result2,
    NULLIF(5000, 5000) AS Result3,
    NULLIF(5000, 1000) AS Result4;

/*
Result1	Result2	Result3	Result4
10000	NULL	NULL	5000
-----------------------------------------------------
Next tiny step

Suppose:

Sales  = 5000
Target = 0

If we calculate:

Sales / NULLIF(Target, 0)

What do you think happens?

A) Divide-by-zero error
B) Result becomes NULL
C) Result becomes 0

Take a guess. 😎

result becomes null

🎯 Exactly! ❤️

You got it.

5000 / NULLIF(0, 0)

First:

NULLIF(0, 0) → NULL

So SQL effectively evaluates:

5000 / NULL

➡️ Result = NULL ✅
➡️ No divide-by-zero error ✅

🧠 This is the important business pattern

When we have a calculation like:

Sales / Target

and Target might be zero, we can safely write:

Sales / NULLIF(Target, 0)

Meaning:

"If Target is 0, turn it into NULL so the calculation doesn't divide by zero.*/

CREATE TABLE EmployeeTargets
(
    EmployeeID INT,
    EmployeeName VARCHAR(50),
    Sales DECIMAL(10,2),
    Target DECIMAL(10,2)
);

INSERT INTO EmployeeTargets
VALUES
(101, 'Ayesha', 10000, 10000),
(102, 'Rahul', 8000, 10000),
(103, 'Sara', 12000, 10000),
(104, 'Imran', 5000, 0);

/*Manager asks:

"Calculate the percentage of target achieved for each employee."*/
select 
EmployeeName,
Sales,
Target,
(sales/nullif(Target,0))*100 as PercentageAchieved
from EmployeeTargets;
/*
EmployeeName	Sales	    Target	    PercentageAchieved
Ayesha	        10000.00	10000.00	100.0000000000000
Rahul	        8000.00	    10000.00	80.0000000000000
Sara	        12000.00	10000.00	120.0000000000000
Imran	        5000.00	    0.00	    NULL
*/

select 
EmployeeName,
Sales,
Target,
isnull((sales/nullif(Target,0))*100 , 'No Target') as PercentageAchieved
from EmployeeTargets;
--ERROR-Data type conversion as here the data is text
/*SO use:CASE
    WHEN condition THEN result
    ELSE result
END*/



select 
EmployeeName,
Sales,
Target,
case
when target=0
then 'No Target'
else
(sales/nullif(Target,0))*100 
end as PercentageAchieved
from EmployeeTargets;

/*RESULT
Msg 8114, Level 16, State 5, Line 204
Error converting data type varchar to numeric.*/

select 
EmployeeName,
Sales,
Target,
case
when target=0
then 'No Target'
else
cast((sales/nullif(Target,0))*100 as varchar(20))
end as PercentageAchieved
from EmployeeTargets;
/*
EmployeeName	Sales	    Target	    PercentageAchieved
Ayesha	        10000.00	10000.00	100.0000000000000
Rahul	        8000.00	    10000.00	80.0000000000000
Sara	        12000.00	10000.00	120.0000000000000
Imran	        5000.00	    0.00	    No Target

*/

/*
COALESCE() → find a non-NULL value / provide fallback
ISNULL() → replace NULL with a fallback (SQL Server)
NULLIF() → turn a specific matching value into NULL
-------------------------------------------
One thing I want you to notice

We actually used NULLIF() in two related ways:

Purpose 1 — prevent an error

Sales / NULLIF(Target, 0)

Purpose 2 — create a NULL condition

NULLIF(0, 0)

That distinction is worth remembering.
======================================================================*/

CREATE TABLE ProductMargin
(
    ProductID INT,
    ProductName VARCHAR(50),
    SellingPrice DECIMAL(10,2),
    CostPrice DECIMAL(10,2)
);

INSERT INTO ProductMargin
VALUES
(101, 'Laptop', 60000, 45000),
(102, 'Phone', 30000, 20000),
(103, 'Tablet', 25000, 0),
(104, 'Monitor', 15000, 10000),
(105, 'Keyboard', 3000, 1800);

select * from ProductMargin;
/*
ProductID	ProductName	SellingPrice	CostPrice
101	            Laptop	60000.00	45000.00
102	            Phone	30000.00	20000.00
103	            Tablet	25000.00	0.00
104	            Monitor	15000.00	10000.00
105	            Keyboard	3000.00	1800.00


"Show ProductName, SellingPrice, CostPrice and ProfitMargin. If CostPrice is 0, display 'Cost not recorded'; otherwise calculate Profit Margin %."*/

select ProductName,
SellingPrice,
CostPrice,
    case
        when CostPrice=0
            then 'Cost not recorded'
        else
            CAST((SellingPrice -CostPrice)/SellingPrice*100 as varchar(20))
        end as ProfitMargin
from ProductMargin;

/*
ProductName                                        SellingPrice                            CostPrice                               ProfitMargin
-------------------------------------------------- --------------------------------------- --------------------------------------- --------------------
Laptop                                             60000.00                                45000.00                                25.0000000000000
Phone                                              30000.00                                20000.00                                33.3333333333300
Tablet                                             25000.00                                0.00                                    Cost not recorded
Monitor                                            15000.00                                10000.00                                33.3333333333300
Keyboard                                           3000.00                                 1800.00                                 40.0000000000000

=============================================================

Before we move on

You've now covered the main NULL-handling tools we planned:

1. IS NULL / IS NOT NULL: Identify missing values.

2. COALESCE(): Return the first non-NULL value.

    COALESCE(Phone, 'Not Provided')

3. ISNULL(): SQL Server's two-value NULL replacement function.

    ISNULL(Bonus, 0)

4. NULLIF()

Return NULL when two values are equal; particularly useful for avoiding divide-by-zero.

Sales / NULLIF(Target, 0)
--------------------------------------------------------------------
Mixed NULL Challenge 1 — Customer Orders

You're working for an e-commerce company.

Your manager wants a customer report showing:

Customer name
Order amount
Discount
Final Amount

Business rule:

If the discount is missing, treat it as 0.

We already have Orders_NULL, but let's make the requirement slightly more realistic by joining customer information.
*/

SELECT *
FROM Customers_NULL;

SELECT *
FROM Orders_NULL;

/*
CustomerID	CustomerName	Email	    Phone
101	        Ayesha	ayesha@email.com	9876543210
102	        Rahul	rahul@email.com	    NULL
103	        Sara	sara@email.com    9123456780
104	         Imran	imran@email.com 	NULL
105	        Priya	priya@email.com	    9988776655



OrderID	CustomerID	Sales	Discount
1	    101	        1000.00	100.00
2	    102	        1500.00	NULL
3	    103	        800.00	50.00
4	    104	        2000.00	NULL
5	    105	        1200.00	200.00

Write a query that returns:

CustomerName
Sales
Discount
FinalAmount
*/

select c.CustomerName,
o.Sales,
o.Discount,
o.Sales-o.discount as FinalAmount
from Customers_NULL c
join Orders_NULL o
on c.CustomerID=o.CustomerID

/*
CustomerName	Sales	Discount	FinalAmount
Ayesha	        1000.00	100.00	900.00
Rahul	        1500.00	NULL	NULL
Sara	        800.00	50.00	750.00
Imran	        2000.00	NULL	NULL
Priya	        1200.00	200.00	1000.00*/

select c.CustomerName,
o.Sales,
isnull(o.Discount,0) as Given_Discount,
o.Sales-isnull(o.Discount,0) as FinalAmount
from Customers_NULL c
join Orders_NULL o
on c.CustomerID=o.CustomerID

/*
CustomerName	Sales	Given_Discount	FinalAmount
Ayesha	        1000.00	    100.00	    900.00
Rahul	        1500.00	    0.00	    1500.00
Sara	        800.00	    50.00	     750.00
Imran	        2000.00	    0.00	    2000.00
Priya	        1200.00	    200.00	    1000.00

================================================================================================
Mixed Challenge 2 — Customer Contact

Now let's make you choose between COALESCE() and ISNULL().

The customer-service team wants a report containing:

Customer name
Best Contact

Business rule:

Use the customer's PersonalPhone if available.
If that's missing, use WorkPhone.
If that's also missing, use Email.
If all three are missing, show 'No Contact*/

SELECT *
FROM CustomerContact;
/*
CustomerID	CustomerName	PersonalPhone	WorkPhone	Email
101	        Ayesha	9876543210	8888888888	ayesha@email.com
102	        Rahul	NULL	    8777777777	rahul@email.com
103	        Sara	NULL	    NULL	    sara@email.com
104	        Imran	NULL	    NULL	    NULL
105	        Priya	9999999999	NULL	    priya@email.com
*/

select CustomerName,
coalesce(PersonalPhone,WorkPhone,Email,'No contact') as Best_Contact
from CustomerContact;

/*
CustomerName	Best_Contact
Ayesha	9876543210
Rahul	8777777777
Sara	sara@email.com
Imran	No contact
Priya	9999999999

=============================================================================
Mixed Challenge 3 — Sales Target
*/
SELECT *
FROM EmployeeTargets;

/*
EmployeeID	EmployeeName	Sales	    Target
101	        Ayesha	        10000.00	10000.00
102	        Rahul	    8000.00	        10000.00
103	        Sara	    12000.00	    10000.00
104	        Imran	    5000.00	        0.00

The manager asks:

"Show each employee's target achievement percentage. If the employee has no target (Target = 0), show 'No Target' instead of calculating."*/

select EmployeeName,
Sales,
case
when 
coalescs(Target,'No target') as Target
then
(Target-Sales)/ as PercentageAchieved
from EmployeeTargets;







