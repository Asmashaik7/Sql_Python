
==========================
DECLARE @Counter INT = 1

WHILE @Counter <= 5
      --1<=5
BEGIN
    --PRINT 'value is: ' + CAST(@Counter AS VARCHAR)
    PRINT @Counter
    SET @Counter = @Counter + 1
END
/*Result:
1
2
3
4
5*/

----------------------------

DECLARE @Outer INT = 1, @Inner INT

WHILE @Outer <= 3
BEGIN
    SET @Inner = 1
    WHILE @Inner <= 3
    BEGIN
        PRINT 'Outer: ' + CAST(@Outer AS VARCHAR) + ', Inner: ' + CAST(@Inner AS VARCHAR);
        SET @Inner = @Inner + 1
    END
    SET @Outer = @Outer + 1
END

/*Messages
Outer: 1, Inner: 1
Outer: 1, Inner: 2
Outer: 1, Inner: 3
Outer: 2, Inner: 1
Outer: 2, Inner: 2
Outer: 2, Inner: 3
Outer: 3, Inner: 1
Outer: 3, Inner: 2
Outer: 3, Inner: 3*/
-------------------------------------------------
DECLARE @Num INT = 1

WHILE @Num <= 15
BEGIN
    IF @Num = 10
        BREAK  -- Exit loop when Num = 5

    IF @Num % 2 = 0
    BEGIN
        SET @Num = @Num + 1;
        CONTINUE  -- Skip even numbers
    END

    PRINT 'Odd Number: ' + CAST(@Num AS VARCHAR);
    SET @Num = @Num + 1
END
/*Messages
Odd Number: 1
Odd Number: 3
Odd Number: 5
Odd Number: 7
Odd Number: 9*/
--------------------------
WHILE EXISTS(SELECT 1 FROM TEST)
BEGIN
     DELETE TOP (3)  FROM TEST
END
SELECT TOP 3 * FROM EMPLOYEES

SELECT * FROM TEST
