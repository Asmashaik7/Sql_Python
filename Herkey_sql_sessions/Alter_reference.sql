/* =====================================================
   ALTER TABLE – Quick Reference Practice File
   ===================================================== */

/* -----------------------------------------------------
   1??  CREATE TABLE (Base Example)
----------------------------------------------------- */

CREATE TABLE SampleTable (
    ID INT PRIMARY KEY IDENTITY(1,1),
    Name VARCHAR(50)
);


/* -----------------------------------------------------
   2??  ADD Single Column
----------------------------------------------------- */

ALTER TABLE SampleTable
ADD Salary INT;


/* -----------------------------------------------------
   3??  ADD Multiple Columns
----------------------------------------------------- */

ALTER TABLE SampleTable
ADD JoiningDate DATE,
    IsActive BIT;


/* -----------------------------------------------------
   4??  ALTER COLUMN (Modify Data Type / Size)
----------------------------------------------------- */

ALTER TABLE SampleTable
ALTER COLUMN Name VARCHAR(100);

ALTER TABLE SampleTable
ALTER COLUMN Salary BIGINT;


/* -----------------------------------------------------
   5??  ADD DEFAULT CONSTRAINT
----------------------------------------------------- */

ALTER TABLE SampleTable
ADD CONSTRAINT DF_SampleTable_Salary
DEFAULT 0 FOR Salary;


/* -----------------------------------------------------
   6??  ALTER COLUMN to NOT NULL
   (Only works if no NULL values exist)
----------------------------------------------------- */

ALTER TABLE SampleTable
ALTER COLUMN Salary BIGINT NOT NULL;


/* -----------------------------------------------------
   7??  DROP COLUMN
----------------------------------------------------- */

ALTER TABLE SampleTable
DROP COLUMN IsActive;


/* -----------------------------------------------------
   8??  DROP CONSTRAINT
----------------------------------------------------- */

ALTER TABLE SampleTable
DROP CONSTRAINT DF_SampleTable_Salary;


/* -----------------------------------------------------
   9??  DROP TABLE
----------------------------------------------------- */

DROP TABLE SampleTable;