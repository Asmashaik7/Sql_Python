/*In SQL Server, loops are used to repeatedly execute a block of T-SQL statements until a condition is met.

Loops are mainly used when:
==========================
If we  need to perform repetitive tasks (e.g., inserting multiple rows, updating records in batches).

If we want to process data row by row (though set-based operations are usually preferred for performance).

Types of Loops
==============
SQL Server supports two main loop types:

1. WHILE Loop
Executes a block of code repeatedly as long as the condition evaluates to TRUE.

WHILE condition
BEGIN
    -- Statements to execute
END

Ex:*/
==========================================
--using + and cast fun
DECLARE @Counter INT = 1;

WHILE @Counter <= 5
BEGIN
    PRINT 'Counter value is: ' + CAST(@Counter AS VARCHAR);
    SET @Counter = @Counter + 1;
END
/*Messages:
Counter value is: 1
Counter value is: 2
Counter value is: 3
Counter value is: 4
Counter value is: 5
*/

--OR USING CONCAT(), using COMMA without using + and cast function
DECLARE @Counter INT = 1;

WHILE @Counter <= 5
BEGIN
    PRINT CONCAT('Counter value is: ', @Counter);
    SET @Counter = @Counter + 1;
END;
/*Messages:
Counter value is: 1
Counter value is: 2
Counter value is: 3
Counter value is: 4
Counter value is: 5
*/
-------------------------------------------
DECLARE @Counter INT = 1;

WHILE @Counter <= 5
BEGIN
    PRINT 'Counter value is: ' + @Counter;
    SET @Counter = @Counter + 1;
END
--ERROR: Conversion failed when converting the varchar value 'Counter value is: ' to data type int.
----------------------------------------
DECLARE @Counter INT = 1;

SELECT SQL_VARIANT_PROPERTY(CAST(@Counter AS VARCHAR), 'BaseType') as datatype_name;
/*Results:
datatype_name
varchar*/

--------------------
DECLARE @Counter INT = 1;

SELECT SQL_VARIANT_PROPERTY(@Counter, 'BaseType') as datatype_name;
/*Results:
datatype_name
int*/
=================================================
/*2. Nested WHILE Loops
A loop inside another loop.

Useful for multi-level iterations (like processing rows and columns).*/

DECLARE @Outer INT = 1, @Inner INT;

WHILE @Outer <= 3
BEGIN
    SET @Inner = 1;
    WHILE @Inner <= 2
    BEGIN
        PRINT 'Outer: ' + CAST(@Outer AS VARCHAR) + ', Inner: ' + CAST(@Inner AS VARCHAR);
        SET @Inner = @Inner + 1;
    END
    SET @Outer = @Outer + 1;
END
/*Messages:
Outer: 1, Inner: 1
Outer: 1, Inner: 2
Outer: 2, Inner: 1
Outer: 2, Inner: 2
Outer: 3, Inner: 1
Outer: 3, Inner: 2
*/
=================================================
--BREAK and CONTINUE
==================

--We can use BREAK to exit a loop early and CONTINUE to skip to the next iteration.

DECLARE @Num INT = 1;

WHILE @Num <= 10
BEGIN
    IF @Num = 5
        BREAK;  -- Exit loop when Num = 5

    IF @Num % 2 = 0
    BEGIN
        SET @Num = @Num + 1;
        CONTINUE;  -- Skip even numbers
    END

    PRINT 'Odd Number: ' + CAST(@Num AS VARCHAR);
    SET @Num = @Num + 1;
END

/*Messages:
Odd Number: 1
Odd Number: 3*/
-----------------------------------------------------