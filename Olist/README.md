# 🛒 Brazilian E-Commerce Analytics — Olist Dataset

### End-to-End Portfolio Project | SQL Server (T-SQL) + Power BI

**Analyst:** Asma Shaik  
**GitHub:** [github.com/Asmashaik7](https://github.com/Asmashaik7)  
**Dataset:** [Brazilian E-Commerce by Olist — Kaggle](https://www.kaggle.com/datasets/olistbr/brazilian-ecommerce)

---

## 📌 Project Overview

This project explores real-world Brazilian e-commerce data from Olist, covering approximately 100,000 orders placed between 2016 and 2018.

The project was completed in two stages:

**Stage 1 — SQL Business Analysis**

Using SQL Server (T-SQL), I analyzed customer behavior, order trends, payment methods, product category performance, and delivery operations. I answered 15 business questions across three levels of query complexity and conducted additional investigations to identify data-quality issues and business insights.

**Stage 2 — Power BI Dashboard Development**

After completing the SQL analysis, I extended the same project using Power BI to transform the findings into interactive dashboards. The four-page report provides an overview of business performance, customer behavior, cancellation trends, payment methods, and delivery performance.

**Project Objective:** To demonstrate how SQL can be used to investigate business data and how Power BI can communicate analytical findings through interactive visualizations.

---

## 🗂️ Dataset Description

The original Olist dataset contains 9 tables. This project uses 5 core tables for SQL analysis and Power BI reporting.

| **Table** | **Description** | **Rows** |
|---|---|---:|
| olist_customers_dataset | Customer information and location | 99,441 |
| olist_orders_dataset | Order status and timestamps | 99,441 |
| olist_order_items_dataset | Products per order with price and freight | 112,650 |
| olist_products_dataset | Product catalog with categories | 32,951 |
| olist_order_payments_dataset | Payment methods and values | 103,886 |

The dataset contains transactional data from **2016 to 2018**.

> **Data Quality Note:** The products table contains a known column name typo — `product_lenght_cm` instead of `product_length_cm`. This is preserved as-is from the original Olist dataset.

> **Customer ID Note:** Olist uses two customer identifiers — `customer_id` at order level and `customer_unique_id` at person level. Unique customer analysis uses `customer_unique_id` to identify individual customers across orders.

---

## 🛠️ Tools & Skills Used

| **Category** | **Details** |
|---|---|
| **Database** | SQL Server (T-SQL) |
| **Data Visualization** | Power BI |
| **SQL Querying** | SELECT, WHERE, GROUP BY, ORDER BY, JOINs |
| **SQL Functions** | COUNT, SUM, AVG, MIN, MAX, ROUND |
| **Intermediate SQL** | Multi-table JOINs, CASE statements, date functions (DATEDIFF, MONTH, YEAR) |
| **Advanced SQL** | CTEs, RANK, DENSE_RANK, LAG, SUM() OVER() |
| **Data Quality** | Cross-table reconciliation, NULL handling with ISNULL() |
| **Power BI** | KPI cards, bar charts, line charts, filters, report pages |
| **DAX** | Measures, calculated columns, CALCULATE, DIVIDE, DISTINCTCOUNT, DATEDIFF |

---

## 🔍 SQL Business Questions Answered

### ✅ Level 1 — Foundational Analysis (Q1–Q5)

| **#** | **Business Question** | **Key Finding** |
|---|---|---|
| Q1 | How many unique customers exist? | 96,096 unique customers |
| Q2 | What is the order status distribution? | Approximately 97% of orders were delivered; cancellation rate was approximately 0.6% |
| Q3 | What is the total payment value recorded on the platform? | 16,008,872.12 BRL |
| Q4 | Which product categories generate the most revenue? | Beauty & Health leads at 1,441,248.07 BRL |
| Q5 | Which states have the highest number of customers? | São Paulo dominates with 40,302 customers, approximately 42% of the customer base |

### ✅ Level 2 — Intermediate Analysis (Q6–Q10)

| **#** | **Business Question** | **Key Finding** |
|---|---|---|
| Q6 | Who are the top 10 highest-spending customers? | Top spender: 13,664.08 BRL — bulk purchase of 8 landline phones |
| Q7 | What are the most popular payment methods? | Credit cards account for approximately 75% of orders |
| Q8 | How are orders distributed by value segments? | Medium-value orders contribute the highest total payment value: 9.17 million BRL |
| Q9 | What is the average delivery time? | Average delivery time: approximately 12 days; range: 0–210 days |
| Q10 | What are the monthly order trends? | Peak: March 2018 with 7,211 orders |

### ✅ Level 3 — Advanced Analysis with CTEs & Window Functions (Q11–Q15)

| **#** | **Business Question** | **Key Finding** |
|---|---|---|
| Q11 | Rank customers by total spending | Used CTE and RANK(); top customer spent 13,664.08 BRL |
| Q12 | Month-over-month order growth | Used LAG(); biggest monthly increase was 2,913 orders in November 2017 |
| Q13 | Rank product categories by revenue | Used DENSE_RANK(); 74 categories ranked, with Beauty & Health at #1 |
| Q14 | What is the running total of revenue? | Used SUM() OVER(); cumulative product value plus freight crossed 5 million BRL in October 2017 |
| Q15 | What is the distribution of repeat and one-time buyers? | 2,997 repeat customers (3.1%) and 93,099 one-time customers (96.9%) |

---

## 📊 Power BI Dashboard

After completing the SQL analysis, I extended the project by developing a four-page interactive Power BI report using the same five core tables.

### 1. Executive Overview

Provides a high-level view of overall e-commerce performance.

**Key metrics and visuals:**
- Total Orders
- Unique Customers
- Total Payment Value
- Delivered Orders Percentage
- Monthly Order Trend
- Top 10 Product Categories by Order Value
- Orders by Order Status

### 2. Customer & Geographic Insights

Explores customer distribution, spending behavior, and repeat purchasing.

**Key visuals:**
- Customers by State
- One-Time vs Repeat Customers
- Top 10 Customers by Spending

### 3. Cancellation Analysis

Examines order cancellations and how cancellation patterns vary over time.

**Key visuals:**
- Cancellation KPI cards
- Monthly Cancelled Orders
- Monthly Cancellation Rate

### 4. Delivery Performance & Delays

Analyzes delivery duration and identifies orders with unusually long delivery times.

**Key visuals:**
- Total Orders Taking More Than 50 Days to Deliver
- Average Delivery Days
- Delayed Orders by Customer State
- Orders by Payment Method

> **Delivery Analysis Note:** Orders taking more than 50 days from purchase to customer delivery are classified as extreme delays for this analysis. This threshold does not represent all late deliveries.

> **Data Quality Note:** The dataset has incomplete data in some periods, particularly in 2016 and late 2018. Monthly trends and rates should therefore be interpreted cautiously.

---

## 💡 Key Business Insights

**1. Customer Retention Opportunity**

> Approximately 96.9% of customers made only one purchase, while 3.1% placed repeat orders. Olist could explore loyalty programs, targeted offers, and retention campaigns to encourage repeat purchases.

**2. B2B Opportunity Detected**

> The highest-spending customer purchased 8 identical landline phones worth 13,664.08 BRL in a single order. This bulk-purchase behavior may indicate a business purchasing requirement and could be explored as a potential B2B opportunity.

**3. Black Friday Impact**

> November 2017 recorded the largest month-over-month order increase, with 2,913 additional orders. The timing suggests a possible Black Friday effect.

**4. Rio de Janeiro Delivery Pattern**

> Rio de Janeiro recorded 214 orders taking more than 50 days to deliver, representing approximately 34% of the 632 extreme-delay orders identified. This makes RJ an important area for further logistics investigation.

**5. Untapped Category Opportunity**

> Children & Youth Fashion generated only 665.36 BRL in product value plus freight. Its low recorded value may warrant further investigation into category performance and product visibility.

**6. Data Quality Issue Found**

> Cross-table reconciliation identified 775 orders with payment records but no associated order items, and 1 order with items but no payment record. The payment and order-item totals were therefore analyzed separately rather than treated as interchangeable measures.

**7. Order Value Segmentation**

> Order-level payment analysis showed that medium-value orders contributed the highest total payment value at approximately 9.17 million BRL across 47,889 orders. High-value orders accounted for 4,296 orders and approximately 4.00 million BRL.

---

## 🔎 Project Structure

```text
Brazilian-Ecommerce-Analytics/
│
├── README.md
│
├── SQL/
│   └── olist_analysis.sql
│
└── PowerBI/
    └── Olist_Ecommerce_Dashboard.pbix

---

## 🎯 What This Project Demonstrates

- End-to-end business analysis using SQL Server and Power BI
- Writing multi-table JOINs and analytical SQL queries
- Applying CTEs and window functions to solve business questions
- Analyzing customer behavior, payment patterns, and order trends
- Investigating data-quality issues through cross-table reconciliation
- Creating DAX measures and calculated columns
- Designing multi-page interactive Power BI dashboards
- Translating analytical findings into business insights and recommendations

---

*Dataset source: [Olist Brazilian E-Commerce — Kaggle](https://www.kaggle.com/datasets/olistbr/brazilian-ecommerce)*
