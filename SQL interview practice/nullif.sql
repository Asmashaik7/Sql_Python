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