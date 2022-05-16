Proposed Metrics


PRODUCT
fct_order_items > count of orders by product - view overtime with timeframe flexiblity, total sales by product

MARKETING
fct_customers > count of orders, total spend, average spend, first order date, last order date, retention metrics (percent of customers who made 2nd order, Nth order)
note. a sales funnel would be a nice to have for a marketing team. But do not seem to have these data points available. 

fct_order (possibly simply fct_order_items) > order review metrics, average score by demographic/product/timeframe

FINANCE
fct_order_items > total gross revenue, total net revenue, revenue vs budget/forecast by select timeframe/granularity. 
                > total sales by seller, total SOP by seller

LOGISTICS
fct_order_items > total freight value, average freight value
transportation costs 
### not sure how we want to calc this

CEO
Business overview Dashboard

Top selling products, worst performing products 
Total/Average Sales
Retention %
Total Gross/Net revenue 
Revenue vs Budget
Average customer review


**SCOPED METRICS**

**Metric:**  count of orders
**Definition:** `count(distinct(order_id)) as count_of_orders`; this can be grouped by things like product_category_name, customer, customer_state, payment_type, sellers, etc. Does not necessarily need to be filtered by any particular field.
**Visualization:** Count of orders over time and product category; Line chart where the x-axis is `extract(month from order_purchase_timestamp)`, the y-axis is `count(distinct(order_id))` , pivoted on (one line per) `products.product_category_name`. Filtered on last 12 months


**Metric:**  customer age
**Definition:** `date_diff(date customer_first_order_date, date customer_last_order_date, DAY) AS customer_age;`; this customer dimension can be used to measure how long a customer has been making orders at the time of purchase.
**Visualization:** Average Customer Age by Product Category; Bar chart where the x-axis is `products.product_category_name`, the y-axis is `avg(customer_age)`.

**Visualization:** Count of Customers by Age; Bar chart where the x-axis is `customer_age`, the y-axis is `count(distinct((customer_id))`.


**Metric:**  time to deliver
**Definition:** `date_diff(date (date(timestamp order_purchase_timestamp), date order_delivered_customer_date, DAY) AS days_to_deliver;`; this dimension can be used to measure the amount of time in days from the moment an order was purchased to when it was delivered.
**Visualization:** Average Time to Deliver by Seller State; Bar chart where the x-axis is `sellers.seller_state`, the y-axis is `avg(days_to_deliver)`.