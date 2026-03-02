-- To practice window functuons
CREATE TABLE practice_windowfuns (
    order_id INT,
    customer_id VARCHAR(10),
    order_month VARCHAR(10),
    amount INT
);

--Insert All 10 Rows
INSERT INTO practice_windowfuns (order_id, customer_id, order_month, amount)
VALUES
(1,'A','Jan',100),
(2,'A','Feb',200),
(3,'A','Mar',150),
(4,'B','Jan',300),
(5,'B','Feb',250),
(6,'B','Mar',100),
(7,'C','Jan',400),
(8,'C','Feb',100),
(9,'C','Mar',200),
(10,'C','Apr',50);

select * from practice_windowfuns;

SELECT customer_id, SUM(amount)
FROM practice_windowfuns
GROUP BY customer_id;

/* Result
A	450
B	650
C	750
There are only 3 unique customer_ids: A, B, C . GROUP BY creates one group per unique customer_id
All rows belonging to the same customer are merged into one aggregated row*/

======================================================================
select 
order_id,
customer_id,
amount,
sum(amount) over() as total_amount
from practice_windowfuns;

--How many rows will return?-10 
--What will total_amount show? 1850
--coz Calculate sum over the entire table., so total_amount will be the same number in every row.
/*
1	A	100	1850
2	A	200	1850
3	A	150	1850
4	B	300	1850
5	B	250	1850
6	B	100	1850
7	C	400	1850
8	C	100	1850
9	C	200	1850
10	C	50	1850*/

/*Query Type	Rows Returned	Behavior
GROUP BY	3 rows	Collapses
OVER()	10 rows	Keeps rows
OVER(ORDER BY)	10 rows	Running total*/
===================================================================

SELECT 
    order_id,
    customer_id,
    amount,
    SUM(amount) OVER(ORDER BY order_id) AS running_total
FROM practice_windowfuns;

/*Result
1	A	100	100
2	A	200	300
3	A	150	450
4	B	300	750
5	B	250	1000
6	B	100	1100
7	C	400	1500
8	C	100	1600
9	C	200	1800
10	C	50	1850
*/

=================================================================

SELECT 
    order_id,
    customer_id,
    amount,
    SUM(amount) OVER(PARTITION BY customer_id) AS customer_total
FROM practice_windowfuns;


/* Result
1	A	100	450
2	A	200	450
3	A	150	450
4	B	300	650
5	B	250	650
6	B	100	650
7	C	400	750
8	C	100	750
9	C	200	750
10	C	50	750
*/
/* Split the data logically by customer
 Calculate SUM inside each customer group
 But do NOT collapse rows */

 =====================================================
 /*Expression	Meaning
OVER()	Total of entire table
OVER(ORDER BY col)	Running total across table
OVER(PARTITION BY col)	Total per group (repeated)
OVER(PARTITION BY col ORDER BY col2)	Running total per group*/
===================================================================
SELECT 
    customer_id,
    SUM(amount) AS total_spent,
    RANK() OVER(ORDER BY SUM(amount) DESC) AS customer_rank
FROM practice_windowfuns
GROUP BY customer_id;

/* result
C	750	1
B	650	2
A	450	3
*/

--Window functions work on the result set after GROUP BY.
--1️ GROUP BY collapses rows
--2️ Then RANK() numbers them
select 
customer_id, 
sum(amount) as total_spent,
dense_rank() over(order by sum(amount) desc) as customer_rank
from practice_windowfuns 
group by customer_id;

/*C	750	1
B	650	2
A	450	3*/

--Show top 2 customers by spending

select top 2
customer_id, 
sum(amount) as total_spent,
dense_rank() over(order by sum(amount) desc) as customer_rank
from practice_windowfuns 
group by customer_id;

/*Result:
C	750	1
B	650	2*/

/*TOP without ORDER BY is unsafe.
The engine is not guaranteed to return the highest values unless ordered.
Even though your DENSE_RANK() has ORDER BY inside it,
that does NOT control the final result ordering.*/

select top 2
customer_id, 
sum(amount) as total_spent,
dense_rank() over(order by sum(amount) desc) as customer_rank
from practice_windowfuns 
group by customer_id
order by total_spent desc;


/*Result:
C	750	1
B	650	2*/

SELECT 
    order_id,
    customer_id,
    amount,
    ROW_NUMBER() OVER(ORDER BY amount DESC) AS row_num
FROM practice_windowfuns;

/*When Do We Use ROW_NUMBER?
Pagination
Picking first row per group
Deduplication
Exact Top N (no ties allowed)*/


/*Without PARTITION:
👉 One ranking across entire dataset.

With PARTITION:
👉 Ranking restarts inside each group.*/

