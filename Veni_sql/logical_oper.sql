--Logical operators (AND, OR, NOT, BETWEEN, IN, LIKE, IS NULL, combinations).

select * from products

--1. Get products where quantity is greater than 50 and cost is greater than 100.

SELECT *
FROM PRODUCTS
WHERE QUANTITY > 50
AND COST > 100;
----------------------------------------------------
/*Results:PID	PNAME	QUANTITY	COST	SALES*/
--No rows matching this query. lets insert some rows. 

INSERT INTO PRODUCTS VALUES (4, 'KEYBOARD', 15, 250, 700);

INSERT INTO PRODUCTS VALUES (5, 'MONITOR', 8, 800, 1200);

INSERT INTO PRODUCTS VALUES (6, 'PRINTER', 3, 450, 300);

INSERT INTO PRODUCTS VALUES (7, 'SCANNER', 12, 350, 900);

INSERT INTO PRODUCTS VALUES (8, 'SPEAKERS', 20, 150, 500);

INSERT INTO PRODUCTS VALUES (9, 'TABLET', 6, 400, 650);

INSERT INTO PRODUCTS VALUES (10, 'PENDRIVE', 50, 50, 1000);

INSERT INTO PRODUCTS VALUES (11, 'HARDDISK', 25, 600, 1500);

INSERT INTO PRODUCTS VALUES (12, 'SSD', 18, 700, 1800);

INSERT INTO PRODUCTS VALUES (13, 'ROUTER', 9, 200, 450);

INSERT INTO PRODUCTS VALUES (14, 'PROJECTOR', 2, 1200, 3000);

INSERT INTO PRODUCTS VALUES (15, 'WEBCAM', 30, 180, 950);

INSERT INTO PRODUCTS VALUES (16, 'HEADPHONES', 22, 275, 1100);

INSERT INTO PRODUCTS VALUES (17, 'MICROPHONE', 7, 320, 750);

INSERT INTO PRODUCTS VALUES (18, 'SMARTWATCH', 11, 900, 2500);

INSERT INTO PRODUCTS VALUES (19, 'CHARGER', 40, 100, 850);

INSERT INTO PRODUCTS VALUES (20, 'ADAPTER', 35, 80, 600);
INSERT INTO PRODUCTS VALUES (21, 'POWERBANK', 60, 250, 1400);

select * from products

SELECT *
FROM PRODUCTS
WHERE QUANTITY > 50
AND COST > 100;
-----------------------------------------------------
--2. Get products where sales are greater than 5000 or quantity is less than 10.

SELECT *
FROM PRODUCTS
WHERE SALES > 5000
OR QUANTITY < 10;

--------------------------------------------------------
--3. Get products where cost is not greater than 200.

SELECT *
FROM PRODUCTS
WHERE NOT COST > 200;

------------------------------------------------------------
--4. Find products whose quantity is between 20 and 100.

SELECT *
FROM PRODUCTS
WHERE QUANTITY BETWEEN 20 AND 100;

----------------------------------------------------------------
--5. Get products whose names are either Laptop, Mouse, or Keyboard.

SELECT *
FROM PRODUCTS
WHERE PNAME IN ('Laptop', 'Mouse', 'Keyboard');

-----------------------------------------------------------------------
--6. Find products whose names start with S or end with X.

SELECT *
FROM PRODUCTS
WHERE PNAME LIKE 'S%'
OR PNAME LIKE '%X';

---------------------------------------------------------------
--7. Find rows where sales value is NULL.

SELECT *
FROM PRODUCTS
WHERE SALES IS NULL;
--Results: NO values. as we dont have NULLs in sales

-----------------------------------------------------------
/* 8. Get products where:
quantity > 30
and (cost < 100 OR sales > 1000)*/

SELECT *
FROM PRODUCTS
WHERE QUANTITY > 30
AND (COST < 100 OR SALES > 1000);

/* Result:
PID	PNAME	QUANTITY	COST	SALES
10	PENDRIVE	50	50	1000
20	ADAPTER	35	80	600
21	POWERBANK	60	250	1400*/

------------------------------------------------------------

