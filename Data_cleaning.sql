-- data_cleaning
-- checking the data before I start doing any real analysis on it
-- want to make sure theres no duplicates or missing keys messing things up
 USE ecommerce_project;
 
-- checking if customers table has any duplicate ids
SELECT customer_id, COUNT(*) AS dupe_count
FROM customers
GROUP BY customer_id
HAVING COUNT(*) > 1;

-- same thing but for orders
SELECT order_id, COUNT(*) AS dupe_count
FROM orders
GROUP BY order_id
HAVING COUNT(*) > 1;

-- making sure every order actually has a matching customer
-- if this returns rows that means we have orders pointing to customers that dont exist
SELECT o.order_id, o.customer_id
FROM orders o
LEFT JOIN customers c ON o.customer_id = c.customer_id
WHERE c.customer_id IS NULL;

-- same idea, checking order_items links back to a real order
SELECT oi.order_id
FROM order_items oi
LEFT JOIN orders o ON oi.order_id = o.order_id
WHERE o.order_id IS NULL;


 
-- how many orders dont have a delivery date, broken down by status
-- makes sense that canceled/processing orders wouldnt have one since they never got delivered
SELECT order_status, COUNT(*) AS num_orders
FROM orders
WHERE order_delivered_customer_date IS NULL
GROUP BY order_status
ORDER BY num_orders DESC;

-- checking for weird prices/payments that are 0 or negative, shouldnt exist but just checking
SELECT * FROM order_items WHERE price <= 0;
SELECT * FROM payments WHERE payment_value <= 0;

-- checking if any order got "delivered" before it was even purchased lol
-- would mean theres a data entry error somewhere
SELECT order_id, order_purchase_timestamp, order_delivered_customer_date
FROM orders
WHERE order_delivered_customer_date < order_purchase_timestamp;

 
-- quick look at all the state codes just to make sure they're consistent (all 2 letters etc)
SELECT DISTINCT customer_state
FROM customers
ORDER BY customer_state;

-- notes after running these:
-- no duplicate customer_id or order_id, good
-- no orphaned orders/order_items, all the joins are clean
-- around 2980 orders have no delivery date which makes sense since those are
-- canceled/unavailable/processing/shipped orders that never actually got delivered
-- state codes all look fine, no cleanup needed there