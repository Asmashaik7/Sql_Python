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



 
CREATE TABLE customers (
    customer_id INT,
    customer_name VARCHAR(50),
    city VARCHAR(50));CREATE TABLE orders (
    order_id INT,
    customer_id INT,
    Amount Money);--drop table orders-- drop table cselect * from customersselect * from ordersINSERT INTO customers (customer_id, customer_name, city)VALUES(1, 'Ravi', 'Hyderabad'),(2, 'Priya', 'Chennai'),(3, 'Arjun', 'Bangalore'),(4, 'Sneha', 'Pune');INSERT INTO orders (order_id, customer_id, amount)VALUES(101, 1, 1200),(102, 2, 800),(103, 1, 2100),(104, 3, 500),(105, 3, 1500);SELECT    C.customer_name,    O.order_id,    O.Amount
 FROM CUSTOMERS AS C
 INNER JOIN ORDERS O
 ON C.customer_id=O.customer_id  -- returns who have orders-- only matching recordsSELECT    C.customer_name,    O.order_id,    O.Amount
 FROM CUSTOMERS AS C
 LEFT JOIN ORDERS O
 ON C.customer_id=O.customer_id -- ALL CUSTOMER-- ORDERS IF AVAILABLE-- ELSE NULL-- KEEPS ALL CUSTOMERS-- SHOWS CUSTOMERS WITHOUT ORDERSSELECT    C.customer_name,    O.order_id,    O.Amount
 FROM CUSTOMERS AS C
 LEFT JOIN ORDERS O
 ON C.customer_id=O.customer_id
 WHERE O.order_id IS NULL   -- TO SHOW CUSTOMERS WITHOUT ORDERS  ONLYSELECT    C.customer_name,    O.order_id,    O.Amount
 FROM CUSTOMERS AS C
 RIGHT JOIN ORDERS O
 ON C.customer_id=O.customer_id -- ALL ORDERS-- MATCHING CUSTOMERS-- ELSE NULLSELECT    C.customer_name,    O.order_id,    O.Amount
 FROM CUSTOMERS AS C
 FULL JOIN ORDERS O
 ON C.customer_id=O.customer_id -- RETURNS ALL DATA FROM BOTH TABLES-- COMBINES LEFT+RIGHTSELECT    C.customer_name,    O.order_id,    O.Amount
 FROM CUSTOMERS AS C
 CROSS JOIN ORDERS O  5 CUSTOMERS* 4 ORDERS

CREATE TABLE customers_ref (
    customer_id INT,
    customer_name VARCHAR(50),
    ReferrerID INT)INSERT INTO customers_ref(customer_id, customer_name, ReferrerID)VALUES(1, 'Ravi' ,NULL),(2, 'Priya', 1),(3, 'Arjun', 1),(4, 'Sneha', 2);SELECT * FROM customers_ref
SELECT    CR.customer_id,    R.customer_name AS REFERRER
FROM customers_ref CRJOIN customers_ref RON CR.ReferrerID=R.ReferrerID  

--- CUSTOMERS HAVE REFERRER INNER -- ONLY MATCHING CUSTOMERS & ORDERSLEFT -- ALL CUSTOMERS + MATCHING ORDERSRIGHT -- ALL ORDERS + MATCHING CUSTOMERSFULL - EVERYTHING FROM BOTH TABLES(CUSTOMERS+ORDERS)CROSS - ALL COMBINATIONS(CUSTOMERS*ORDERS)SELF - SAME TABLE RELATIONSHIP
 