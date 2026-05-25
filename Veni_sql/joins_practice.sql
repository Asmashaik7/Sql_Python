-- Practice of joins  

CREATE TABLE customers (

    customer_id INT,

    customer_name VARCHAR(50),

    city VARCHAR(50)

);

CREATE TABLE orders (

    order_id INT,

    customer_id INT,

    Amount Money

);

INSERT INTO customers (customer_id, customer_name, city)

VALUES

(1, 'Ravi', 'Hyderabad'),

(2, 'Priya', 'Chennai'),

(3, 'Arjun', 'Bangalore'),

(4, 'Sneha', 'Pune');
 
INSERT INTO orders (order_id, customer_id, amount)

VALUES

(101, 1, 1200),

(102, 2, 800),

(103, 1, 2100),

(104, 3, 500),

(105, 3, 1500);

select * from customers
SELECT * FROM orders

 ====================
 --INNER JOIN
 ====================
 SELECT    C.customer_name,    O.order_id,    O.Amount
 FROM CUSTOMERS AS C
 INNER JOIN ORDERS O
 ON C.customer_id=O.customer_id  
 
 -- Returns customers who have orders only-- only matching records
 
 /*Result:
 customer_name	order_id	Amount
Ravi	101	1200.00
Priya	102	800.00
Ravi	103	2100.00
Arjun	104	500.00
Arjun	105	1500.00*/
----------------------------------------
 LEFT JOIN
 ---------------------------------------
 SELECT    C.customer_name,    O.order_id,    O.Amount
 FROM CUSTOMERS AS C
 LEFT JOIN ORDERS O
 ON C.customer_id=O.customer_id 
 
 -- ALL CUSTOMER-- ORDERS IF AVAILABLE-- ELSE NULL
 
 /* Result:
customer_name	order_id	Amount
Ravi	        101	         1200.00
Ravi	        103	           2100.00
Priya	        102	            800.00
Arjun	        104	            500.00
Arjun	        105	            1500.00
Sneha	        NULL	        NULL*/

 ---------------------------------------------
 --LEFT JOIN with WHERE clause
 ---------------------------------------------

 SELECT    C.customer_name,    O.order_id,    O.Amount
 FROM CUSTOMERS AS C
 LEFT JOIN ORDERS O
 ON C.customer_id=O.customer_id
 WHERE O.order_id IS NULL 

 -- SHOWS CUSTOMERS WITHOUT ORDERS
 /*Result:
customer_name	order_id	Amount
Sneha	NULL	NULL*/
 
 ---------------------------------
RIGHT JOIN
---------------------------------
 SELECT    C.customer_name,    O.order_id,    O.Amount
 FROM CUSTOMERS AS C
 RIGHT JOIN ORDERS O
 ON C.customer_id=O.customer_id

 /*Result:
 customer_name	order_id	Amount
Ravi	101	1200.00
Priya	102	800.00
Ravi	103	2100.00
Arjun	104	500.00
Arjun	105	1500.00 */
 
 -- ALL ORDERS-- MATCHING CUSTOMERS-- ELSE NULL

 -----------------------------------
 --FULL JOIN
 ----------------------------------

 SELECT    C.customer_name,    O.order_id,    O.Amount
 FROM CUSTOMERS AS C
 FULL JOIN ORDERS O
 ON C.customer_id=O.customer_id 
 
 -- RETURNS ALL DATA FROM BOTH TABLES-- COMBINES LEFT+RIGHT

 /*customer_name	order_id	Amount
Ravi	101	1200.00
Ravi	103	2100.00
Priya	102	800.00
Arjun	104	500.00
Arjun	105	1500.00
Sneha	NULL	NULL*/

 --------------------------------------------
 --CROSS JOIN
 ----------------------------------

 SELECT    C.customer_name,    O.order_id,    O.Amount
 FROM CUSTOMERS AS C
 CROSS JOIN ORDERS O  
 --5 CUSTOMERS* 4 ORDERS=20 rows
 /*Result:
 customer_name	order_id	Amount
Ravi	101	1200.00
Ravi	102	800.00
Ravi	103	2100.00
Ravi	104	500.00
Ravi	105	1500.00
Priya	101	1200.00
Priya	102	800.00
Priya	103	2100.00
Priya	104	500.00
Priya	105	1500.00
Arjun	101	1200.00
Arjun	102	800.00
Arjun	103	2100.00
Arjun	104	500.00
Arjun	105	1500.00
Sneha	101	1200.00
Sneha	102	800.00
Sneha	103	2100.00
Sneha	104	500.00
Sneha	105	1500.00*/

 -----------------------
 --SELF JOIN
 -------------------

CREATE TABLE customers_ref (
    customer_id INT,
    customer_name VARCHAR(50),
    ReferrerID INT)
    
 INSERT INTO customers_ref(customer_id, customer_name, ReferrerID)VALUES(1, 'Ravi' ,NULL),(2, 'Priya', 1),
 (3, 'Arjun', 1),
 (4, 'Sneha', 2);
 
 SELECT * FROM customers_ref

 /*Result:
customer_id	customer_name	ReferrerID
1	Ravi	NULL
2	Priya	1
3	Arjun	1
4	Sneha	2*/
===================================



select * from customers_ref


SELECT    CR.customer_id, R.customer_name AS REFERRER
FROM customers_ref CR
JOIN customers_ref R
ON CR.ReferrerID=R.ReferrerID  
/*customer_id	REFERRER
2	Priya
3	Priya
2	Arjun
3	Arjun
4	Sneha*/

--- CUSTOMERS HAVE REFERRER

===============================================================
/*
INNER -- ONLY MATCHING CUSTOMERS & ORDERS

LEFT -- ALL CUSTOMERS + MATCHING ORDERS
RIGHT -- ALL ORDERS + MATCHING CUSTOMERS
FULL - EVERYTHING FROM BOTH TABLES(CUSTOMERS+ORDERS)
CROSS - ALL COMBINATIONS(CUSTOMERS*ORDERS)
SELF - SAME TABLE RELATIONSHIP*/
 