# SQL Mistakes and Learnings Log
**Analyst:** Asma Shaik  
**Project:** Olist E-Commerce SQL Portfolio  
**Started:** February 2026
**Ended:** March 2026

---

## MISTAKES LOG

### Mistake 1: Missing Comma Before Column
**Date:** 2026-02-28  
**Query Context:** Investigating top customer purchases (Q6 deep dive)

**What Happened:**
```sql
SELECT 
    oi.price,
    oi.freight_value       -- Missing comma here!
    ROUND((oi.price + oi.freight_value), 2) AS customer_spent
```
**Error Message:** `Incorrect syntax near 'ROUND'`

**Why It Happened:**  
Forgot to add comma between columns in SELECT statement

**The Fix:**
```sql
SELECT 
    oi.price,
    oi.freight_value,      -- Added comma!
    ROUND((oi.price + oi.freight_value), 2) AS customer_spent
```

**Lesson Learned:**  
Every item in SELECT must be separated by commas. Read SELECT clauses carefully from top to bottom before running!

---

### Mistake 2: Using SUM Without GROUP BY
**Date:** 2026-02-28  
**Query Context:** Trying to show individual order items with totals

**What Happened:**
```sql
SELECT 
    oi.order_item_id,              -- Individual row data
    p.product_category_name,       -- Individual row data
    ROUND(SUM(oi.price + ...))     -- Aggregate function
```
**Error Message:** Mixing aggregate and non-aggregate columns without GROUP BY

**Why It Happened:**  
Confused about when to use SUM (aggregate) vs simple calculation (row-level)

**The Fix:**  
Two options:
1. **Show individual items** — Remove SUM, just calculate per row
2. **Show totals** — Keep SUM and add GROUP BY

**Lesson Learned:**  
- SUM/COUNT/AVG = collapses multiple rows into one → needs GROUP BY
- Simple math (price + freight) = calculates per row → no GROUP BY needed
- Can't mix both approaches in same query!

---

### Mistake 3: Forgot Quotes Around Text Values in WHERE Clause
**Date:** 2026-02-28  
**Query Context:** Filtering by customer_unique_id

**What Happened:**
```sql
WHERE c.customer_unique_id = 0a0a92112bd4c708ca5fde585afaa872
```
**Error Message:** Invalid column name or syntax error

**Why It Happened:**  
Didn't realize customer_unique_id is a TEXT field, not a number

**The Fix:**
```sql
WHERE c.customer_unique_id = '0a0a92112bd4c708ca5fde585afaa872'
                             ↑                                  ↑
                          Quotes added!
```

**Lesson Learned:**  
**SQL Rule for Values:**
- Numbers: No quotes → `WHERE price = 100`
- Text/Strings: Single quotes → `WHERE name = 'John'`
- Dates: Single quotes → `WHERE date = '2024-01-15'`

---

### Mistake 4: Data Type Error During CSV Import
**Date:** 2026-02-27  
**Query Context:** Importing olist_products_dataset

**What Happened:**  
Import failed with error: `Column 'product_weight_g' does not allow values over 32767`

**Why It Happened:**  
SSMS auto-detected column as `smallint` (max value 32,767) but data had values over 44,000

**The Fix:**  
Changed data type from `smallint` to `int` during import in "Modify Columns" step

**Lesson Learned:**  
- Always check data types during CSV import!
- `smallint` = -32,768 to 32,767
- `int` = -2 billion to +2 billion
- Preview data ranges before finalizing import

---

### Mistake 5: Unicode Character Error When Saving SQL File
**Date:** 2026-02-27  
**Query Context:** Trying to save .sql file with rupee symbol (₹)

**What Happened:**  
SSMS error: "Cannot save file with unicode characters"

**Why It Happened:**  
Default SQL Server encoding doesn't support special currency symbols like ₹

**The Fix:**  
Two options:
1. Save file with UTF-8 encoding (File → Save As → Save with Encoding)
2. Replace ₹ with text like "BRL" or "Rs."

**Lesson Learned:**  
For Brazilian data, use BRL (Brazilian Real) instead of ₹ (Indian Rupee) — more accurate AND avoids encoding issues!

---

### Mistake 6: Not Understanding customer_id vs customer_unique_id
**Date:** 2026-02-27  
**Query Context:** Counting unique customers (Q1)

**Initial Confusion:**  
Why are there two customer ID columns?

**What I Learned:**  
- `customer_id` = unique per ORDER (same person gets new ID each order)
- `customer_unique_id` = unique per PERSON (tracks actual individual)

**Why It Matters:**  
For "How many unique customers" analysis, MUST use `customer_unique_id` or we'll overcount!

**Lesson Learned:**  
Always explore and understand your data structure BEFORE writing queries. Don't assume column names are self-explanatory!

---

## KEY CONCEPTS I STRUGGLED WITH

### 1. When to Use GROUP BY
**Struggled:** Understanding when GROUP BY is required

**Now I Know:**  
- If using aggregate functions (SUM, COUNT, AVG, MAX, MIN) → Need GROUP BY
- GROUP BY tells SQL: "collapse rows with same value into one row"
- All non-aggregated columns in SELECT must be in GROUP BY

**Analogy:**  
GROUP BY is like organizing a messy pile of papers into folders by category!

---

### 2. Understanding JOINs
**Struggled:** How to connect multiple tables

**Now I Know:**  
- JOINs are like catching buses to a destination 🚌
- Sometimes direct route (1 table)
- Sometimes transfers needed (2-4 tables)
- Can't skip stops — must follow the connection chain!

**Key Rule:**  
Map out the table connections FIRST before writing query:
```
customers → orders → order_items → products
(via customer_id) → (via order_id) → (via product_id)
```

---

### 3. DISTINCT vs Regular Counts
**Struggled:** When to use DISTINCT

**Now I Know:**  
- `COUNT(*)` = counts all rows (including duplicates)
- `COUNT(DISTINCT column)` = counts unique values only

**Example:**  
If customer placed 3 orders:
- `COUNT(customer_id)` = 3 (counts all 3 order records)
- `COUNT(DISTINCT customer_unique_id)` = 1 (counts the person once)

---

## THINGS I FIGURED OUT ON MY OWN

### 1. Data Quality Reconciliation (Q3)
**What I Did:**  
Cross-validated revenue between payments table and order_items table

**What I Discovered:**  
- 775 orders with payments but no items
- 1 order with items but no payment
- Suggests data pipeline issues

**Why It Matters:**  
Real analysts validate their data — don't just trust one source!

---

### 2. Deep-Dive Customer Investigation
**What I Did:**  
Spent 1 hour writing 4-table JOIN to see what top spender bought

**What I Discovered:**  
Top customer (13,664 BRL) bought 8 identical landline phones — clearly B2B/wholesale transaction!

**Why It Matters:**  
Going deeper than the surface analysis reveals real business insights!

---

## PROUD MOMENTS

✅ Fixed data type error independently during import  
✅ Spotted the `product_lenght_cm` typo in the dataset  
✅ Figured out 4-table JOIN after 1 hour of trying  
✅ Created the "bus journey" analogy for JOINs  
✅ Discovered data quality issues through reconciliation  

---

**Last Updated:** 2026-02-28

# SQL Mistakes and Learnings

## KEY CONCEPTS I STRUGGLED WITH

### GROUP BY and AVG
- GROUP BY = creates groups
- AVG = calculates average within each group automatically!

**Example:**
GROUP BY payment_type creates separate buckets for credit_card, boleto, etc.
Then AVG(payment_value) calculates the average WITHIN each bucket!

**Quick Rule:**
- If working on text → use COUNT
- If working on numbers → use aggregates

---

## MISTAKES LOG

### Mistake 7: Using Aliases in GROUP BY
**Date:** 2026-03-02
**Query Context:** Q10 Monthly Order Trends

**What Happened:**
```sql
GROUP BY month, year  -- aliases don't work here!
```
**Why It Happened:**
GROUP BY runs BEFORE SELECT, so aliases don't exist yet!

**The Fix:**
```sql
GROUP BY MONTH(order_purchase_timestamp), 
         YEAR(order_purchase_timestamp)
```
**Lesson Learned:**
SQL Order of Execution:
1. FROM → 2. WHERE → 3. GROUP BY → 4. SELECT → 5. ORDER BY

GROUP BY can't use SELECT aliases — repeat the full expression!

---

### Mistake 8: Extra Comma in SELECT
**Query Context:** Q11 CTE

**What Happened:**
```sql
ROUND(SUM(op.payment_value), 2) AS total_spent,  -- extra comma!
FROM olist_customers_dataset
```
**Lesson Learned:**
Last column in SELECT never has a comma!

---

### Mistake 9: ORDER BY Inside CTE
**Query Context:** Q12 CTE

**What Happened:**
```sql
WITH monthly_sales AS
(
    SELECT ...
    ORDER BY total_orders DESC  -- not allowed inside CTE!
)
```
**Lesson Learned:**
ORDER BY only goes in final SELECT, never inside CTE! CTEs are temporary tables — you can't sort a table!

---

### Mistake 10: Missing Columns in Final SELECT
**Query Context:** Q11

**What Happened:**
```sql
SELECT RANK() OVER (ORDER BY total_spent DESC)  
-- forgot customer_unique_id and total_spent!
```
**Lesson Learned:**
Always select all meaningful columns — not just the calculated one!

---

### Mistake 11: Wrong CTE Syntax Order
**Query Context:** Q13 Category Revenue Ranking

**What Happened:**
```sql
with as category_revenue_ranking  -- wrong!
```
**The Fix:**
```sql
with category_revenue_ranking as  -- correct!
```
**Lesson Learned:**
CTE syntax is always: `WITH name AS ()` — name comes BEFORE `as`!

---

### Mistake 12: Extra Closing Bracket in Final SELECT
**Query Context:** Q13

**What Happened:**
```sql
from category_revenue_ranking
)  -- extra bracket!
```
**Lesson Learned:**
Brackets only wrap the CTE body — final SELECT has no closing bracket!

---

### Mistake 13: Double Quotes Instead of Single Quotes
**Query Context:** Q13 ISNULL()

**What Happened:**
```sql
ISNULL(p.product_category_name, "Uncategorized")  -- wrong!
```
**The Fix:**
```sql
ISNULL(p.product_category_name, 'Uncategorized')  -- correct!
```
**Lesson Learned:**
SQL Server always uses **single quotes** for text values — never double quotes!

---

### Mistake 14: ORDER BY Inside CTE ⚠️
**Query Context:** Q14 and Q15

**What Happened:**
```sql
WITH running_total AS
(
    SELECT...
    ORDER BY total_revenue DESC  -- not allowed!
)
```
**Lesson Learned:**
ORDER BY never goes inside CTE — only in final SELECT! *(Repeated mistake — needs extra attention!)* ⚠️

---

### Mistake 15: Using Table Alias Outside CTE
**Query Context:** Q15

**What Happened:**
```sql
SELECT c.customer_unique_id  -- c. doesn't exist in final SELECT!
FROM customer_segment
```
**Lesson Learned:**
After CTE, you're selecting from the **CTE name** — original table aliases no longer exist!

---

### Mistake 16: Missing Comma Between Two CTEs
**Query Context:** Q15

**What Happened:**
```sql
WITH orders_per_customer AS
(...)
customer_segment AS  -- missing comma!
```
**The Fix:**
```sql
WITH orders_per_customer AS
(...),  -- comma here!
customer_segment AS
```
**Lesson Learned:**
Multiple CTEs must be separated by commas — just like columns in SELECT!

---

## PROUD MOMENTS

✅ Fixed data type error independently during import
✅ Spotted the `product_lenght_cm` typo in the dataset
✅ Figured out 4-table JOIN after 1 hour of trying
✅ Created the "bus journey" analogy for JOINs
✅ Discovered data quality issues through reconciliation
✅ Spotted NULL category at Rank 20 independently (Q13)
✅ Identified data quality issue without being told!
✅ Understood WHERE vs SELECT placement for ISNULL()
✅ Spotted Children's Fashion as untapped business opportunity
✅ Cross-validated dataset end date across Q10, Q12 and Q14
✅ This is called TRIANGULATION in data analysis!
✅ Caught missing COUNT in Q15 independently
✅ Connected customer_id vs customer_unique_id correctly
✅ Wrote first ever chained CTEs in Q15
✅ Completed entire SQL Portfolio Project with 15 questions across 3 levels! 🏁