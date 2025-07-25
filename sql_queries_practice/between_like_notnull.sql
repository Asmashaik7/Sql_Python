🧠 Clause: BETWEEN
The BETWEEN clause is used to filter values within a range, inclusive of both ends.

✅ Syntax:

SELECT column1, column2
FROM table_name
WHERE column_name BETWEEN value1 AND value2;

Table: products

product	price
Laptop	75000
Mobile	20000
Earphones	3000
Monitor	12000
Keyboard	2500

SELECT product, price
FROM products
WHERE price BETWEEN 5000 AND 25000;

output:
product	price
Mobile	20000
Monitor	12000

-- 🎯 Task 1: Use BETWEEN
-- Question:
-- Get all employees whose salary is between 40,000 and 80,000.

