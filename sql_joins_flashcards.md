# SQL JOINS — Flashcards (Interactive)

🔗 **Live artifact:** https://claude.ai/public/artifacts/0bafb1f2-2e97-4f3b-b841-7856023250ec

---

## Overview
A compact interactive flashcard app explaining core SQL JOIN types with simple examples and visuals. Great for quick revision and interview prep.

**Core topics covered**
- INNER JOIN
- LEFT JOIN
- RIGHT JOIN
- FULL OUTER JOIN
- Self joins and multiple-condition joins
- Combining JOINs with `WHERE` and `GROUP BY`
- Common mistakes and gotchas

---

## Features
- 20 cards with detailed explanations
- Simple sample tables and SQL code examples
- Visual highlights showing which rows are returned by each JOIN
- Quick reference guide at the bottom
- Real-world usage notes for when to pick each JOIN type

---

## How to use this repo
1. Save this file as `SQL_Joins_Flashcards.md` (or `README.md` if this is the project root).  
2. Add the live artifact link above so viewers can open the interactive version.  
3. Optionally export and upload any HTML/JSON files from Claude Artifacts into a `/flashcards` folder and link them from this README.  

---

## Quick Example — Customers & Orders
**Tables**

`customer`:

| c_id | name    |
|------|---------|
| 1    | Alice   |
| 2    | Bob     |
| 3    | Charlie |
| 4    | David   |

`orders`:

| o_id | c_id | amount |
|------|------|--------|
| 101  | 1    | 500    |
| 102  | 1    | 700    |
| 103  | 2    | 300    |
| 104  | 5    | 900    |  <-- order with no matching customer


### 1) INNER JOIN — only common rows
```sql
SELECT c.c_id, c.name, o.o_id, o.amount
FROM customer c
INNER JOIN orders o
  ON c.c_id = o.c_id;
```
**Result**: rows for Alice (101,102) and Bob (103). No Charlie or order 104.


### 2) LEFT JOIN — all from left (customers)
```sql
SELECT c.c_id, c.name, o.o_id, o.amount
FROM customer c
LEFT JOIN orders o
  ON c.c_id = o.c_id;
```
**Result**: all customers; customers without orders show `NULL` for order columns (Charlie, David).


### 3) RIGHT JOIN — all from right (orders)
```sql
SELECT c.c_id, c.name, o.o_id, o.amount
FROM customer c
RIGHT JOIN orders o
  ON c.c_id = o.c_id;
```
**Result**: all orders; orders without matching customer show `NULL` for customer columns (o_id 104).


### 4) FULL OUTER JOIN — everything from both
```sql
SELECT c.c_id, c.name, o.o_id, o.amount
FROM customer c
FULL JOIN orders o
  ON c.c_id = o.c_id;
```
**Result**: matching rows, plus left-only (customers with no orders) and right-only (orders with no customer).

---

## Advanced Examples
- **Self-join (employees and managers):** useful when the same table references itself.
- **Multiple join conditions:** use `ON a.id = b.id AND a.type = b.type` for stricter matching.
- **JOIN + GROUP BY:** aggregate after joining to get per-customer totals.

**Example — total amount per customer (including customers with zero orders):**

```sql
SELECT c.c_id, c.name, COALESCE(SUM(o.amount), 0) AS total_amount
FROM customer c
LEFT JOIN orders o
  ON c.c_id = o.c_id
GROUP BY c.c_id, c.name;
```

---

## Common Mistakes & Tips
- Forgetting to include the `ON` clause — causes cross join behavior.
- Confusing `WHERE` filtering after an OUTER JOIN — applying `WHERE o.o_id IS NOT NULL` turns a LEFT JOIN into an INNER-like result.
- Not using table aliases — aliases (`c`, `o`) make queries clearer in multi-join queries.
- Using `FULL JOIN` in DB engines that don’t support it (MySQL prior to 8.x) — emulate using `UNION` of LEFT and RIGHT joins.

---

## Quick Reference
- `INNER JOIN`: only matching rows
- `LEFT JOIN`: all left, matched right
- `RIGHT JOIN`: all right, matched left
- `FULL JOIN`: all rows from both

---

## Attribution
Built from interactive content created with Claude Artifacts.  
Created on: 2025-10-13

---

## Next steps (optional)
- Export the interactive artifact from Claude (HTML/JSON) and place it under `/flashcards` in this repo.  
- Add a small `index.html` and enable GitHub Pages to host the interactive version directly from your repo.

---

*Happy learning — Asma!*

