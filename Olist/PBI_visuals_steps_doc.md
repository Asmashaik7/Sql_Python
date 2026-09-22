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
Order Status % =
DIVIDE(
    COUNT(olist_orders_dataset[order_id]),
    CALCULATE(
        COUNT(olist_orders_dataset[order_id]),
        ALL(olist_orders_dataset[order_status])
    )
)
Orders in this status ÷ Total orders
-------------
DIVIDE() syntax in DAX
DIVIDE(
    <numerator>,
    <denominator>
)

Think:

DIVIDE(what you're dividing, what you're dividing by)

Simple example
Revenue per Order =
DIVIDE(
    [Total Revenue],
    [Total Orders]
)

Meaning:

Total Revenue ÷ Total Orders

With a fallback value

DIVIDE() can take an optional third argument:

DIVIDE(
    <numerator>,
    <denominator>,
    <alternate_result>
)

Example:

Revenue per Order =
DIVIDE(
    [Total Revenue],
    [Total Orders],
    0
)

If Total Orders is zero, DAX returns 0 instead of an error.

-----------
Basic syntax
CALCULATE(
    <expression>,
    <filter1>,
    <filter2>,
    ...
)
Another simple example
Delivered Orders =
CALCULATE(
    COUNT(olist_orders_dataset[order_id]),
    olist_orders_dataset[order_status] = "delivered"
)

Meaning:

Count the orders, but only where status = Delivered.
-----------
Calculate something, but change the filter context while calculating it.

Simple example

Suppose we want total revenue only for delivered orders:

Delivered Revenue =
CALCULATE(
    SUM(olist_order_payments_dataset[payment_value]),
    olist_orders_dataset[order_status] = "delivered"
)
--------
While:

CALCULATE(
    COUNT(orders[order_id]),
    orders[order_status] = "delivered"
)

means:

Count orders, but change/add the filter so we're looking at delivered orders.

And this is why CALCULATE() is so important in Power BI/DAX: it lets us modify the filter context of a calculation.

For our next measure, the interesting part will be combining:

CALCULATE() + ALL()

because we need to say:

"Calculate total orders, but ignore the current order-status filter."

That's the exact idea behind the percentage measure we're building.