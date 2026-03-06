-- ================================================
-- OLIST E-COMMERCE BUSINESS ANALYSIS
-- Tool: SQL Server (T-SQL)
-- Dataset: Brazilian E-Commerce by Olist (Kaggle)
-- Analyst: Asma Shaik
-- GitHub: https://github.com/Asmashaik7

-- ================================================
-- LEVEL 1: FOUNDATIONAL QUERIES
-- ================================================
USE OlistEcommerce;

-- Q1: How many unique customers do we have in our database?
SELECT 
    COUNT(DISTINCT customer_unique_id) AS total_unique_customers
FROM olist_customers_dataset;

-- Result: 96,096 unique customers
-- Insight: Customers table has 99,441 rows but only 96,096 unique customers
-- meaning ~3,345 customers placed repeat orders on Olist!

-- =======================================================
-- Q2: What is the distribution of orders by order status?
-- =======================================================
SELECT 
    order_status,
    COUNT(order_id) AS total_orders
FROM olist_orders_dataset
GROUP BY order_status
ORDER BY total_orders DESC;

-- Result:
-- delivered      96478
-- shipped         1107
-- canceled         625
-- unavailable      609
-- invoiced         314
-- processing       301
-- created            5
-- approved           2

-- Insight: 97% of orders successfully delivered!
-- Only 0.6% cancellation rate = strong operational efficiency
-- 609 unavailable orders = potential stock management issue worth flagging!


-- ========================================================
-- Q3: What is the total revenue generated on the platform?
-- ========================================================
SELECT 
    ROUND(SUM(payment_value), 2) AS total_revenue
FROM olist_order_payments_dataset;

-- Result: 16,008,872.12 BRL
-- Insight: Olist generated approximately 16 million BRL in total revenue 
-- from all payment transactions between 2016-2018


-- ================================================
-- DATA QUALITY ANALYSIS & RECONCILIATION
-- ================================================
-- Purpose: Validate revenue consistency across multiple tables
-- and identify structural data inconsistencies
-- ================================================

-- Cross-validation: Total revenue from order items table
SELECT 
    ROUND(SUM(price + freight_value), 2) AS total_revenue_items
FROM olist_order_items_dataset;
--Result: 15843553.24 BRL

-- Count distinct orders in each table
SELECT COUNT(DISTINCT order_id) AS orders_in_payments
FROM olist_order_payments_dataset;
-- Result: 99440 orders

SELECT COUNT(DISTINCT order_id) AS orders_in_items
FROM olist_order_items_dataset;
--Result: 98666 orders

--Both difference is 774
-------------------------------
-- Find orders with payments but NO items (data quality issue)
SELECT COUNT(DISTINCT p.order_id) AS orphaned_payment_orders
FROM olist_order_payments_dataset p
LEFT JOIN olist_order_items_dataset oi
    ON p.order_id = oi.order_id
WHERE oi.order_id IS NULL;
-- Result: 775 orders

-- Find orders with items but NO payments (edge case)
SELECT COUNT(DISTINCT oi.order_id) AS orphaned_item_orders
FROM olist_order_items_dataset oi
LEFT JOIN olist_order_payments_dataset p
    ON oi.order_id = p.order_id
WHERE p.order_id IS NULL;
-- Result: 1 order

-- Edge case investigation: Sample order with items but no payment
SELECT order_status
FROM olist_orders_dataset
WHERE order_id = 'bfbd0f9bdef84302105ad712db648a6c';
-- Result: delivered

-- Insight: Discovered 775 orders (~0.8%) with payment records but no 
-- associated items, and 1 order (<0.001%) with items but no payment record.
-- This suggests potential data pipeline issues during order processing.
-- For revenue analysis, payment_value is used as the source of truth 
-- since it reflects actual transaction inflow.

-- =============================================================
-- Q4: Which product categories have generated the most revenue?
-- ==============================================================
SELECT TOP 10 p.product_category_name, 
    ROUND(SUM(oi.price+oi.freight_value),2) AS total_revenue,
    count(DISTINCT oi.order_id) AS category_orders
FROM olist_products_dataset p
JOIN olist_order_items_dataset oi
    ON p.product_id=oi.product_id
GROUP BY p.product_category_name
ORDER BY total_revenue DESC;
--Distinct: We count how many unique orders contributed to that category.Simply count, It counts item rows, not orders.

-- Result:
-- beleza_saude (Beauty & Health)         1,441,248.07 BRL    8,836 orders
-- relogios_presentes (Watches & Gifts)   1,305,541.61 BRL    5,624 orders
-- cama_mesa_banho (Bed/Bath/Table)       1,241,681.72 BRL    9,417 orders
-- esporte_lazer (Sports & Leisure)       1,156,656.48 BRL    7,720 orders
-- informatica_acessorios (IT accessories) 1,059,272.40 BRL   6,689 orders

-- Insight: Beauty & Health is the top revenue-generating category at 1.44M BRL,
-- followed by Watches & Gifts at 1.3M BRL. Interestingly, Bed/Bath/Table has MORE orders (9,417) than Beauty & Health (8,836) 
-- but LOWER revenue,lower average order values in home goods vs beauty products.

-- ================================================
-- Q5: Which states have the highest number of customers?
-- ================================================
SELECT TOP 10 customer_state, 
    count(distinct customer_unique_id) as Unique_customers
FROM olist_customers_dataset
GROUP BY customer_state
ORDER BY Unique_customers DESC;

-- Result:
-- SP (São Paulo)        40,302
-- RJ (Rio de Janeiro)   12,384
-- MG (Minas Gerais)     11,259
-- RS (Rio Grande do Sul) 5,277
-- PR (Paraná)            4,882
-- SC (Santa Catarina)    3,534
-- BA (Bahia)             3,277
-- DF (Brasília)          2,075
-- ES (Espírito Santo)    1,964
-- GO (Goiás)             1,952

-- Insight: São Paulo dominates with 40,302 customers (~42% of total customer base),
-- more than 3x the second-place Rio de Janeiro. The top 3 states (SP, RJ, MG) 
-- account for approximately 66% of all customers, showing heavy geographic 
-- concentration in Brazil's southeast region.

-- ==================================================
-- LEVEL 2: INTERMEDIATE QUERIES
-- ==================================================

-- ====================================================
-- Q6: What are the top 10 highest spending customers?
-- ====================================================

SELECT TOP 10 c.customer_unique_id,
    c.customer_city,c.customer_state,
    round(sum(p.payment_value),2) as total_spent_by_customer,
    count(distinct o.order_id) as total_orders
from olist_customers_dataset c
join olist_orders_dataset o
on c.customer_id=o.customer_id
join olist_order_payments_dataset p
on o.order_id=p.order_id
group by customer_unique_id, c.customer_city,c.customer_state
ORDER BY total_spent_by_customer DESC;

-- Result:
-- Customer from Rio de Janeiro, RJ:    13,664.08 BRL (1 order)
-- Customer from Florianópolis, SC:      9,553.02 BRL (3 orders)
-- Customer from Araruama, RJ:           7,571.63 BRL (2 orders)
-- Customer from Vila Velha, ES:         7,274.88 BRL (1 order)
-- Customer from Campo Grande, MS:       6,929.31 BRL (1 order)
-- Customer from Vitória, ES:            6,922.21 BRL (1 order)
-- Customer from Marília, SP:            6,726.66 BRL (1 order)
-- Customer from Divinópolis, MG:        6,081.54 BRL (1 order)
-- Customer from Goiânia, GO:            4,809.44 BRL (1 order)
-- Customer from Mauá, SP:               4,764.34 BRL (1 order)

-- Insight: The highest spender placed one order worth 13,664 BRL (~$2,700 USD equivalent).
-- Interestingly, 8 out of 10 top spenders made only a single large purchase, suggesting
-- these are likely one-time high-value purchases (electronics, furniture, appliances)
-- rather than repeat loyal customers. Only 1 customer (Florianópolis) made multiple orders (3),
-- indicating potential for loyalty program targeting.

-- ================================================
-- DEEP DIVE ANALYSIS: What did the highest spender purchase?
-- ================================================
-- Purpose: Investigate purchase behavior of top customer to understand 
-- if high spending comes from multiple diverse items or bulk purchases

-- Step 1: Identify what product category they bought
SELECT 
    c.customer_unique_id,
    o.order_id,
    oi.order_item_id,
    p.product_category_name
FROM olist_customers_dataset c
JOIN olist_orders_dataset o
    ON c.customer_id = o.customer_id
JOIN olist_order_items_dataset oi
    ON o.order_id = oi.order_id
JOIN olist_products_dataset p
    ON oi.product_id = p.product_id
WHERE c.customer_unique_id = '0a0a92112bd4c708ca5fde585afaa872'
ORDER BY oi.order_item_id;

-- Result: 8 items, all from telefonia_fixa (landline phones)

-- Step 2: Breakdown of individual item prices
SELECT 
    c.customer_unique_id,
    o.order_id,
    oi.order_item_id,
    p.product_category_name,
    oi.price,
    oi.freight_value,
    ROUND((oi.price + oi.freight_value), 2) AS item_total
FROM olist_customers_dataset c
JOIN olist_orders_dataset o
    ON c.customer_id = o.customer_id
JOIN olist_order_items_dataset oi
    ON o.order_id = oi.order_id
JOIN olist_products_dataset p
    ON oi.product_id = p.product_id
WHERE c.customer_unique_id = '0a0a92112bd4c708ca5fde585afaa872'
ORDER BY oi.order_item_id;

-- Result:
-- 8 identical items at 1,680 BRL each
-- Shipping: 28.01 BRL per item
-- Item total: 1,708.01 BRL each
-- Grand total: 8 × 1,708.01 = 13,664.08 BRL

-- Insight: The highest spender made a bulk purchase of 8 identical landline 
-- phones (telefonia_fixa category). This behavior indicates a B2B transaction
-- rather than typical consumer behavior — likely a small business, retail store,
-- or office purchasing equipment in bulk. This suggests Olist could benefit from
-- creating a dedicated B2B sales channel with volume discounts and business 
-- account features to capture more wholesale opportunities.

-- ================================================
-- Q7: What are the most popular payment methods?
-- ================================================
select payment_type,
    round(sum(payment_value),2) as total_payments,
    count(distinct order_id) as total_orders,
    round(avg(payment_value),2) as avg_per_payment_type
from olist_order_payments_dataset
group by payment_type
order by total_orders DESC;
--GROUP BY = creates groups AVG = calculates average within each group automatically!

-- Result:
-- credit_card:  12,542,084 BRL  |  76,505 orders  |  163.32 BRL avg
-- boleto:        2,869,361 BRL  |  19,784 orders  |  145.03 BRL avg
-- voucher:         379,437 BRL  |   3,866 orders  |   65.70 BRL avg
-- debit_card:      217,990 BRL  |   1,528 orders  |  142.57 BRL avg
-- not_defined:           0 BRL  |       3 orders  |    0.00 BRL avg

-- Insight: Credit cards dominate Olist with 75% of all transactions and 78% 
-- of total revenue. Boleto remains significant (19% of orders) serving customers 
-- without credit cards. Vouchers show the lowest average transaction value (66 BRL),
-- indicating usage for small purchases or promotional discounts. Debit card usage 
-- is surprisingly low (1.5%), likely due to Brazilian preference for credit card 
-- installment payment options.


-- ================================================
-- Q8: How are orders distributed by value segments?
-- ================================================
/*"How can we segment orders into Low, Medium, and High value categories?"
Why this matters:

Marketing can target different customer segments
Shipping teams can prioritize high-value orders
Fraud detection focuses on high-value anomalies*/

use OlistEcommerce;

select
    case
        when payment_value<100 then 'Low value'
        when payment_value between 100 and 500 then 'Medium value'
        else 'High value'
    end as order_value_segment,
    count(distinct order_id) as total_orders,
    round(sum(payment_value),2) as total_revenue,
    round(avg(payment_value),2) as avg_order_value
from olist_order_payments_dataset
group by 
    case
        when payment_value<100 then 'Low value'
        when payment_value between 100 and 500 then 'Medium value'
        else 'High value'
    end
order by total_orders desc;

-- Result:
-- Low Value:     48,493 orders | 2,941,315 BRL |  56.72 BRL avg
-- Medium Value:  47,539 orders | 9,125,335 BRL | 191.01 BRL avg
-- High Value:     4,239 orders | 3,942,223 BRL | 926.27 BRL avg

-- Insight: Customer value distribution follows the Pareto principle — just 4% 
-- of customers (high-value segment) contribute 25% of total revenue with an 
-- average order value of 926 BRL. The mid-value segment drives the bulk of 
-- revenue at 57% despite representing 47% of orders. This suggests opportunity 
-- for (1) VIP programs targeting high-value customers, (2) upselling strategies 
-- to move low-value customers to mid-value tier, and (3) retention campaigns 
-- focused on the profitable mid-value segment.


/*## SQL Order of Execution
1. FROM
2. WHERE
3. GROUP BY (can't use SELECT aliases - must repeat CASE)
4. SELECT (creates aliases here)
5. ORDER BY (CAN use SELECT aliases!)

That's why we repeat CASE in GROUP BY but can use alias in ORDER BY!
case stat creates derived columns, It is created temporarily when the query runs.Exists only in that query output, Disappears after execution, unlike calculated column which exists in the table(model)*/

-- ===============================================================
-- Q9: What is the average delivery time for completed orders?
-- ================================================================
select 
    count(distinct order_id) as total_orders,
    avg(datediff(day,order_purchase_timestamp,order_delivered_customer_date)) as delivery_days,
    min(datediff(day,order_purchase_timestamp,order_delivered_customer_date)) as min_delivery_days,
    max(datediff(day,order_purchase_timestamp,order_delivered_customer_date)) as max_delivery_days,
    order_status
from olist_orders_dataset
where order_status='delivered'
and order_delivered_customer_date is not null
group by order_status;--inorder to exclude the empty delivery dates.

-- Result:
-- 96,470 delivered orders
-- Average: 12 days
-- Fastest: 0 days (same day delivery!)
-- Slowest: 210 days (7 months!)

-- Insight: Olist maintains a reasonable average delivery time of 12 days 
-- for a country as large as Brazil. However, the extreme range (0-210 days) 
-- reveals significant operational variance. Same-day delivery capability exists 
-- for local orders, likely in São Paulo metro area. The 210-day outlier suggests 
-- either remote region deliveries, logistics issues, or data quality problems 
-- worth investigating. This wide variance likely impacts customer satisfaction 
-- scores and could benefit from delivery time prediction models.

-- Find the order that took 210 days
SELECT 
    o.order_id,
    c.customer_state,
    c.customer_city,
    o.order_purchase_timestamp,
    o.order_delivered_customer_date,
    DATEDIFF(day, o.order_purchase_timestamp, o.order_delivered_customer_date) AS delivery_days
FROM olist_orders_dataset o
JOIN olist_customers_dataset c
    ON o.customer_id = c.customer_id
WHERE o.order_status = 'delivered'
  AND DATEDIFF(day, o.order_purchase_timestamp, o.order_delivered_customer_date) = 210;

-- ================================================
-- BONUS INVESTIGATION: Delayed Delivery Analysis by State
-- ================================================
-- Purpose: Investigate orders with delivery times exceeding 50 days
-- to identify geographic patterns and operational bottlenecks

-- Step 1: Count orders with delivery > 50 days
SELECT
    o.order_id,
    c.customer_state,
    o.order_purchase_timestamp,
    o.order_delivered_customer_date,
    DATEDIFF(day, o.order_purchase_timestamp, o.order_delivered_customer_date) AS delivery_days
FROM olist_orders_dataset o
JOIN olist_customers_dataset c
    ON o.customer_id = c.customer_id
WHERE o.order_status = 'delivered'
  AND DATEDIFF(day, o.order_purchase_timestamp, o.order_delivered_customer_date) > 50
ORDER BY delivery_days DESC;

-- Result: 632 orders took longer than 50 days to deliver (~0.65% of all deliveries)

-- Step 2: Analyze delayed deliveries by state
SELECT 
    c.customer_state,
    COUNT(o.order_id) AS delayed_orders,
    ROUND(AVG(DATEDIFF(day, o.order_purchase_timestamp, o.order_delivered_customer_date)), 2) AS avg_delivery_days
FROM olist_orders_dataset o
JOIN olist_customers_dataset c
    ON o.customer_id = c.customer_id
WHERE o.order_status = 'delivered'
  AND DATEDIFF(day, o.order_purchase_timestamp, o.order_delivered_customer_date) > 50
GROUP BY c.customer_state
ORDER BY delayed_orders DESC;

-- Result (Top 10):
-- RJ (Rio de Janeiro):  214 delayed orders | 64 days avg
-- SP (São Paulo):        88 delayed orders | 75 days avg
-- BA (Bahia):            43 delayed orders | 80 days avg
-- CE (Ceará):            34 delayed orders | 73 days avg
-- MG (Minas Gerais):     34 delayed orders | 64 days avg
-- PA (Pará):             33 delayed orders | 64 days avg
-- RS (Rio Grande do Sul):32 delayed orders | 66 days avg
-- PE (Pernambuco):       26 delayed orders | 64 days avg
-- ES (Espírito Santo):   14 delayed orders | 93 days avg
-- GO (Goiás):            13 delayed orders | 77 days avg

-- Notable outliers:
-- AP (Amapá):   1 order, 187 days (remote Amazon region, boat/plane access)
-- SE (Sergipe): 6 orders, 103 days (concerning - not a remote state)
-- PI (Piauí):   7 orders, 98 days

-- Key Findings:
-- 1. RIO DE JANEIRO PROBLEM: 214 delayed orders (34% of all delays) despite being 
--    a major metro area. RJ represents 1.8% delay rate vs SP's 0.2% - suggests 
--    RJ-specific logistics challenges (warehouse location, urban infrastructure, 
--    security issues in certain neighborhoods).
--
-- 2. REMOTE REGION DELAYS: Northern/Amazon states (AP, AC, RR, AM) show expected 
--    extreme delays (69-187 days) due to geographic isolation and limited road access.
--
-- 3. SERGIPE ANOMALY: 103-day average for an accessible northeastern state indicates 
--    potential operational failure worth investigating.
--
-- 4. VOLUME VS SEVERITY: While RJ has most delayed orders (214), states like AP 
--    have worse average times (187 days) but lower volume due to smaller population.

-- Business Recommendations:
-- • URGENT: Audit RJ delivery operations - 214 delays unacceptable for major city
-- • Set delivery expectations: Display realistic timelines for remote regions at checkout
-- • Investigate SE logistics: 103 days for accessible state suggests failure
-- • Consider opening distribution center in RJ to reduce delays
-- • Implement delivery time prediction model based on customer state/city

-- ================================================
-- Q10: What are the monthly order trends?
-- ================================================
SELECT  
    COUNT(DISTINCT order_id) AS total_orders,  
    MONTH(order_purchase_timestamp) AS month, 
    YEAR(order_purchase_timestamp) AS year 
FROM olist_orders_dataset 
GROUP BY MONTH(order_purchase_timestamp), YEAR(order_purchase_timestamp)  
ORDER BY total_orders DESC;

/*Result
7211	3	2018
6939	4	2018
6873	5	2018
6728	2	2018
6512	8	2018
6292	7	2018
6167	6	2018
5673	12	2017
4631	10	2017
4331	8	2017
4285	9	2017
4026	7	2017
3700	5	2017
3245	6	2017
2682	3	2017
2404	4	2017
1780	2	2017
800	1	2017
324	10	2016
16	9	2018
4	10	2018
4	9	2016
1	12	2016
*/

-- Result:
-- Peak month: March 2018 with 7,211 orders
-- Lowest: September 2016 (4 orders - dataset just starting)

-- Insight: Olist showed strong consistent growth from 2016 to 2018,
-- peaking in March 2018 with 7,211 orders. The dataset appears to end
-- mid-2018, as Sep/Oct 2018 show only 16 and 4 orders respectively,
-- indicating incomplete data rather than actual decline.

-- ================================================
-- Q12: Month-over-Month Order Growth
-- ================================================
WITH monthly_sales AS
(
    SELECT 
        COUNT(DISTINCT order_id) AS total_orders,
        MONTH(order_purchase_timestamp) AS month,
        YEAR(order_purchase_timestamp) AS year
    FROM olist_orders_dataset
    GROUP BY MONTH(order_purchase_timestamp), 
             YEAR(order_purchase_timestamp)
)
SELECT
    year,
    month,
    total_orders,
    LAG(total_orders) OVER (ORDER BY year, month) AS previous_month_orders,
    total_orders - LAG(total_orders) OVER (ORDER BY year, month) AS month_growth
FROM monthly_sales;
-- Note: ORDER BY only goes in final SELECT, never inside CTE!
-- Note: LAG() gives the value from the previous row

-- Result (Key highlights):
-- Nov 2017: 7,544 orders | Growth: +2,913 (biggest spike!)
-- Sep 2018: 16 orders    | Growth: -6,496 (incomplete data!)
-- First row (Sep 2016): NULL for previous_month — no prior data exists

-- Insight: Month-over-month analysis using LAG() revealed strong growth 
-- throughout 2017, peaking in November 2017 with a single month growth of 
-- 2,913 orders, likely driven by Black Friday. The dataset shows consistent 
-- growth from 2016 to mid-2018. Negative growth in Sep/Oct 2018 (-6,496) 
-- represents incomplete data rather than actual decline.
SELECT 
    customer_unique_id,
    total_spent,
    RANK() OVER (ORDER BY total_spent DESC) AS rank_by_spent
FROM customer_spent;

-- Result (Top 5):
-- Rank 1: 0a0a92112bd4c708ca5fde585afaa872 | 13,664.08 BRL
-- Rank 2: 46450c74a0d8c5ca9395da1daac6c120 |  9,553.02 BRL
-- Rank 3: da122df9eeddfedc1dc1f5349a1a690c |  7,571.63 BRL
-- Rank 4: 763c8b1c9c68a0229c42c9fc6f662b93 |  7,274.88 BRL
-- Rank 5: dc4802a71eae9be1dd28f5d788ceb526 |  6,929.31 BRL

-- Insight: Using CTE and RANK() window function, top customers were ranked 
-- by total spending. The highest spending customer spent 13,664.08 BRL in a 
-- single bulk purchase of 8 landline phones, suggesting B2B transaction 
-- behavior. Top 5 customers all spent above 6,929 BRL.

================================================================================
/*Q12: Month-over-Month Order Growth
Business Question:

"How much did orders grow or decline each month compared to the previous month?"*/
================================================================================

with monthly_sales as
(
select count(distinct order_id) as total_orders,
month(order_purchase_timestamp) as Month,
year(order_purchase_timestamp) as Year
from olist_orders_dataset
group by month(order_purchase_timestamp), year(order_purchase_timestamp)
)
--Golden Rule: ORDER BY only goes in the final SELECT, never inside a CTE
--LAG() simply means:"Give me the value from the previous row"

select
month,
year,
total_orders,
lag(total_orders) over(order by year, month) as previous_month_orders,
total_orders - lag(total_orders) over(order by year, month) as Month_growth
from monthly_sales;

-- Result (Key Highlights):
-- Nov 2017: 7,544 orders | Growth: +2,913 (biggest spike!)
-- Sep 2018: 16 orders    | Growth: -6,496 (incomplete data!)
-- First row (Sep 2016): NULL for previous_month - no prior data exists

-- Insight: Month-over-month analysis using LAG() revealed strong growth
-- throughout 2017, peaking in November 2017 with a single month growth of
-- 2,913 orders, likely driven by Black Friday. The dataset shows consistent
-- growth from 2016 to mid-2018. Negative growth in Sep/Oct 2018 (-6,496)
-- represents incomplete data rather than actual decline.

/*Q13: Category Revenue Ranking
Business Question:
"Rank product categories by total revenue - which categories are top performers?"*/

-- ================================================
-- FIRST ATTEMPT: NULL issue discovered
-- ================================================
WITH category_revenue_ranking AS
(
    SELECT 
        p.product_category_name AS category_name,
        ROUND(SUM(oi.price + oi.freight_value), 2) AS total_revenue
    FROM olist_order_items_dataset oi
    JOIN olist_products_dataset p
        ON oi.product_id = p.product_id
    GROUP BY p.product_category_name
)

SELECT 
    category_name,
    total_revenue,
    DENSE_RANK() OVER (ORDER BY total_revenue DESC) AS category_rank
FROM category_revenue_ranking;
-- Issue discovered: Rank 20 shows NULL category name!
-- Fix: Use ISNULL() to replace NULL with 'Uncategorized'

-- ================================================
-- IMPROVED VERSION: Handling NULL categories
-- ================================================
WITH category_revenue_ranking AS
(
    SELECT 
        ISNULL(p.product_category_name, 'Uncategorized') AS category_name,
        ROUND(SUM(oi.price + oi.freight_value), 2) AS total_revenue
    FROM olist_order_items_dataset oi
    JOIN olist_products_dataset p
        ON oi.product_id = p.product_id
    GROUP BY p.product_category_name
)
SELECT 
    category_name,
    total_revenue,
    DENSE_RANK() OVER (ORDER BY total_revenue DESC) AS category_rank
FROM category_revenue_ranking;

-- Result: 74 categories ranked by revenue
-- Rank 1:  beleza_saude                   | 1,441,248.07 BRL
-- Rank 20: Uncategorized                  |   207,705.09 BRL
-- Rank 72: cds_dvds_musicais              |       954.99 BRL
-- Rank 73: fashion_roupa_infanto_juvenil  |       665.36 BRL
-- Rank 74: seguros_e_servicos             |       324.51 BRL

-- Insight: Using CTE and DENSE_RANK(), 74 product categories were rankedby total revenue. 
-- beleza_saude leads with 1,441,248.07 BRL in total revenue.

-- Bottom 3 categories generated less than 1,000 BRL, suggesting these are either newly added categories or unpopular products like CDs/DVDs in the streaming era. 
-- Notably, fashion_roupa_infanto_juvenil (Children & Youth Fashion) at only 665 BRL suggests an untapped opportunity — children's fashion is a 
-- high-demand market, indicating poor visibility or promotion on the platform rather than lack of demand. In contrast, seguros_e_servicos 
-- (Insurance & Services) low revenue is expected as consumers typically purchase insurance directly from providers rather than e-commerce platforms.

-- Uncategorized products ranked 20th with 207,705 BRL, highlighting a data quality issue worth fixing.

-- ================================================
/*Q14: Running Total of Revenue
Business Question:
"What is the cumulative revenue month by month?"*/
-- ================================================

WITH running_total AS
(
    SELECT 
        MONTH(o.order_purchase_timestamp) AS month,
        YEAR(o.order_purchase_timestamp) AS year,
        ROUND(SUM(oi.price + oi.freight_value), 2) AS total_revenue
    FROM olist_order_items_dataset oi
    JOIN olist_orders_dataset o
        ON oi.order_id = o.order_id
    GROUP BY MONTH(o.order_purchase_timestamp), 
             YEAR(o.order_purchase_timestamp)
)
SELECT 
    year,
    month,
    total_revenue,
    SUM(total_revenue) OVER (ORDER BY year, month) AS running_total_revenue
FROM running_total;

-- Result (Key Highlights):
-- First month: Sep 2016  |       354.75 BRL | Running:  354.75 BRL
-- 5M milestone: Oct 2017 |   769,312.37 BRL | Running:  5,157,164.64 BRL
-- Peak month:   Nov 2017 | 1,179,143.77 BRL | Running:  6,336,308.41 BRL
-- Final month:  Sep 2018 |       166.46 BRL | Running: 15,843,553.24 BRL

-- Insight: Using CTE and SUM() OVER(), monthly running total revenue was calculated. Olist accumulated a total of 15,843,553.24 BRL by mid-2018.
-- Revenue crossed the 5 million BRL milestone in October 2017. Monthly revenue grew significantly from 354.75 BRL in Sep 2016 to over 1,000,000 
-- BRL per month in 2018, showing strong business growth.

-- Data Quality Note: Sep 2018 shows only 166.46 BRL in monthly revenue compared to 1,000,000+ BRL in previous months, confirming that the 
-- dataset ends around August 2018. This finding is consistent across 
-- Q10 (16 orders), Q12 (-6,496 drop) and Q14 (166.46 BRL) —  triangulating that Sep/Oct 2018 data is incomplete.

