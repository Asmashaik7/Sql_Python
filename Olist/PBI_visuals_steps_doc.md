Total Orders =
DISTINCTCOUNT(olist_orders_dataset[order_id])
=========================================================
Unique Customers =
DISTINCTCOUNT(
    olist_customers_dataset[customer_unique_id]
)
1. Customer ID (customer_id)

Identifies a customer record associated with an order.

In the Olist dataset, each order is linked to a customer_id.

The same customer can have different customer_id values for different orders.

2. Customer Unique ID (customer_unique_id)

Identifies the actual customer across their orders.

If the same person places multiple orders, their customer_unique_id remains the same.

This is the column we use to identify one-time buyers and repeat customers.

Simple example

Order       customer_id     customer_unique_id
Order 1     C001            U100
Order 2     C002            U100
Order 3     C003            U200
=====================================================