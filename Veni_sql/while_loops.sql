
==========================
DECLARE @Counter INT = 1

WHILE @Counter <= 100
      --1<=5
BEGIN
    --PRINT 'value is: ' + CAST(@Counter AS VARCHAR)
    PRINT @Counter
    SET @Counter = @Counter + 1---1+1
END

WHILE EXISTS(SELECT 1 FROM TEST)
BEGIN
     DELETE TOP (3)  FROM TEST
END
SELECT TOP 3 * FROM EMPLOYEES

SELECT * FROM TEST


DECLARE @Outer INT = 1, @Inner INT

WHILE @Outer <= 10
BEGIN
    SET @Inner = 1
    WHILE @Inner <= 10
    BEGIN
        PRINT 'Outer: ' + CAST(@Outer AS VARCHAR) + ', Inner: ' + CAST(@Inner AS VARCHAR);
        SET @Inner = @Inner + 1
    END
    SET @Outer = @Outer + 1
END


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