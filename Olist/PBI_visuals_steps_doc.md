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
I want to find the order status %
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
======
Out of 99k orders, 625 oders are cancelled. 
I wanna find out the revenue appro of these orders

So we can't simply say, for example, “300 were canceled because customers changed their minds.”

But we can investigate clues around those 625 canceled orders. 625 out of 99,441 orders is approximately 0.63% canceled.
So cancellation is relatively small in the overall order population, but the interesting question is whether those cancellations are concentrated in particular categories, sellers, payment methods, or time periods.
Let's calculate the actual number in Power BI

Since we're doing this step-by-step, don't create a visual yet.

Create this measure:

Canceled Revenue =
CALCULATE(
    SUM(olist_order_payments_dataset[payment_value]),
    olist_orders_dataset[order_status] = "canceled"
)
--143.26k
This asks:

Sum the payment value, but only for orders whose status is canceled.

Then we'll create the average canceled order value separately.
----
Average Canceled Order Value =
DIVIDE(
    [Canceled Revenue],
    CALCULATE(
        DISTINCTCOUNT(olist_order_payments_dataset[order_id]),
        olist_orders_dataset[order_status] = "canceled"
    )
)
Your Average Canceled Order Value = R$229.21.

Now compare that with the overall revenue:

Total revenue: R$16.01M
Canceled-order payment value: R$143.26K
Canceled orders: 625
Total orders: 99,441

So canceled orders represent about 0.89% of total payment value, while they represent about 0.63% of orders.

That difference is interesting: canceled orders have a somewhat higher average payment value than the overall order population.

Average Canceled Order Value =
DIVIDE(
    [Canceled Revenue],
    CALCULATE(
        DISTINCTCOUNT(olist_order_payments_dataset[order_id]),
        olist_orders_dataset[order_status] = "canceled"
    )
)

-------------
Average Order Value =
DIVIDE(
    SUM(olist_order_payments_dataset[payment_value]),
    DISTINCTCOUNT(olist_order_payments_dataset[order_id])
)
Canceled orders have an average value of R$229.21 vs R$160.99 overall.

That's about 42% higher.

So although only 625 orders were canceled, the canceled orders are higher-value on average than the typical order.
===========================================
Delivered Orders % =
DIVIDE(
    CALCULATE(
        COUNT(olist_orders_dataset[order_id]),
        olist_orders_dataset[order_status] = "delivered"
    ),
    CALCULATE(
        COUNT(olist_orders_dataset[order_id]),
        ALL(olist_orders_dataset[order_status])
    )
)
What we're asking DAX

Numerator:

Count only delivered orders.

Denominator:

Count all orders, ignoring the order-status filter.

So:

96,478 ÷ 99,441 = 97.02%
This returns:

0.9702

Then in Measure tools → Format → Percentage, Power BI displays it as:

97.02%

So:

DAX calculates the decimal → Power BI Percentage format displays it as %
===========================
What is Order Status %?

It answers:

Out of all orders, what percentage is in each status?

For example, your Olist data has:

Delivered → 97.02%
Shipped → about 1.11%
Canceled → about 0.63%
Unavailable → about 0.61%


Order Status % =
DIVIDE(
    COUNT(olist_orders_dataset[order_id]),
    CALCULATE(
        COUNT(olist_orders_dataset[order_id]),
        ALL(olist_orders_dataset[order_status])
    )
)

Metric	                        Value	    Meaning
Average Canceled Order Value	229.21	    Average payment value associated with canceled orders
Average Order Value	            160.99	    Average payment value across all orders
========================================================
Next step: Cancellation Rate

Before we create it, let's be clear about the business question:

"What percentage of all orders were canceled?"

We know:

Canceled orders = 625
Total orders = 99,441

So expected result is approximately:

0.63%

Create this measure
Cancellation Rate =
DIVIDE(
    CALCULATE(
        COUNT(olist_orders_dataset[order_id]),
        olist_orders_dataset[order_status] = "canceled"
    ),
    CALCULATE(
        COUNT(olist_orders_dataset[order_id]),
        ALL(olist_orders_dataset[order_status])
    )
)
==============================
In Power BI → New measure:

Cancelled Orders =
CALCULATE(
    [Total orders],
    olist_orders_dataset[order_status] = "canceled"
)
Why I'm using [Total orders]

You already have Total orders in your field list, so we're reusing your existing measure rather than creating another COUNT() unnecessarily.

This measure means:

Take the total number of orders, but only where order_status = "canceled".

Cancelled Orders =
CALCULATE(
    [Total orders],
    olist_orders_dataset[order_status] = "canceled"
)

=====================================
Next visual: Cancellation Trend by Month

Business question:

“Are cancellations happening consistently, or were there particular months where cancellations increased?”


Next: Monthly Cancellation Rate

This is the better analysis because count alone can mislead us.

For example, August 2018 had 84 cancellations. But if August had a very large number of total orders, 84 might not be unusual.

So our question is:

“What percentage of that month's orders were cancelled?”

We'll create that measure and put it on a new line chart.

Let's do only the DAX measure first:

Monthly Cancellation Rate =
DIVIDE(
    CALCULATE(
        COUNT(olist_orders_dataset[order_id]),
        olist_orders_dataset[order_status] = "canceled"
    ),
    COUNT(olist_orders_dataset[order_id])
)

The real insight

August 2018: 84 cancellations, but only 1.29% cancellation rate → lots of orders that month, so the 84 cancellations are largely explained by high order volume.

September 2018: 5 cancellations, but 93.75% rate → only a tiny number of orders existed in that month.

October 2018: 4 cancellations, 100% rate → again, extremely small order volume.

So Sep–Oct 2018 should NOT be presented as a major cancellation problem. It's an incomplete/low-volume tail of the dataset.

What I would put in our project insight

Cancellation rate remained below ~1.3% during the meaningful high-volume period, while the extreme rates in Sep–Oct 2018 are driven by very low order volume and incomplete data.

That's a much stronger analyst conclusion than simply saying "cancellations reached 100%."

And notice something else: Feb 2018 = 1.09% and Aug 2018 = 1.29%. Those are the months worth investigating further because they combine high cancellation counts with a meaningful rate.
==================================================================
What we've actually learned

This cancellation work gave you some genuinely useful analyst skills:

Count vs rate
Numerator vs denominator
Filter context
Why date context can come from the visual
Why count alone can mislead
Why percentage alone can mislead when the denominator is tiny
Identifying incomplete data periods
Avoiding unsupported business conclusions

Those are interview-level analytical skills, not wasted time.
===========================================



