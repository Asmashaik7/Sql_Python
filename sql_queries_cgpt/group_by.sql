-- What does GROUP BY do?
-- It groups rows that have the same values in one or more columns, so that we can apply aggregate functions like:

-- SUM(), AVG(), COUNT(), MAX(), MIN()

 WHEN do you use GROUP BY?
👉 Rule:
--If you're using an aggregate function (like SUM, COUNT, AVG, MAX, MIN) and you want the result per group, you MUST use GROUP BY.

💡 Quick Tip:
Only use parentheses in IN (), VALUES (), or subqueries — not in GROUP BY.

SELECT department, location, COUNT(*) AS emp_count
FROM employees
WHERE salary > 90000
GROUP BY department, location
HAVING COUNT(*) >= 2;

GROUP BY department, location
This tells SQL:

“Group the data separately for each unique combination of department and location.”

🔎 Visual:
department	location	emp_name
IT	Chennai	A
IT	Chennai	B
IT	Mumbai	C

If you do GROUP BY department, location:

One group is: IT + Chennai

Another group is: IT + Mumbai

===========================

🧾 Table: sales
product	category	quantity	price
Laptop	Electronics	2	50000
Phone	Electronics	5	20000
Shirt	Clothing	10	1000
Jeans	Clothing	3	1500
Laptop	Electronics	1	50000

--Example 1: Group by category to get total quantity sold

SELECT category, SUM(quantity) AS total_qty
FROM sales
GROUP BY category;

--Example 2: Group by product and show average price

SELECT product, AVG(price) AS avg_price
FROM sales
GROUP BY product;
------------------------------------------------------------------------------------------
🔹 Table: orders
order_id	customer_name	city	product	quantity	price_per_unit
1	Ramesh	Mumbai	Phone	2	20000
2	Sita	Delhi	Laptop	1	50000
3	Ramesh	Mumbai	Laptop	1	50000
4	Rahul	Delhi	Phone	3	20000
5	Meena	Bangalore	Headphones	2	3000
6	Sita	Delhi	Laptop	1	50000

--✅ Task 1:
--Show total quantity of products ordered by each customer.

SELECT customer_name, SUM(quantity) AS total_quantity
FROM orders
GROUP BY customer_name;

--✅ If you want total quantity of each product:

SELECT product, SUM(quantity) AS total_quantity
FROM orders
GROUP BY product;

🧠 Task 2:
Show how many different products each customer has ordered.
SELECT customer_name, COUNT(DISTINCT product) AS product_count
FROM orders
GROUP BY customer_name;
-- order_table:
-- order_id	customer_name	product	quantity
-- 1	Ravi	Pen	2
-- 2	Ravi	Notebook	1
-- 3	Ravi	Pen	3
-- 4	Anjali	Pencil	5
-- 5	Anjali	Eraser	2
-- 6	Anjali	Pencil	1
-- 7	Mohan	Notebook	4
--------------------