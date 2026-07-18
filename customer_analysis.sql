-- customer_analysis
-- looking at who the customers are and how often they actually buy stuff
 
USE ecommerce_project;
 
-- repeat customers -- people who ordered more than once
-- using customer_unique_id here since customer_id is actually different per order in this dataset (weird but thats how olist did it)
SELECT
    c.customer_unique_id,
    COUNT(o.order_id) AS total_orders
FROM customers c
JOIN orders o
    ON c.customer_id = o.customer_id
GROUP BY c.customer_unique_id
HAVING COUNT(o.order_id) > 1
ORDER BY total_orders DESC;
 
-- top 10 customers by how much they spent total
SELECT
    o.customer_id,
    ROUND(SUM(p.payment_value), 2) AS total_spent
FROM orders o
JOIN payments p ON o.order_id = p.order_id
GROUP BY o.customer_id
ORDER BY total_spent DESC
LIMIT 10;
 
-- ranking every customer by revenue, using a window function here
-- this was actually kinda fun to figure out lol
WITH customer_sales AS (
    SELECT
        o.customer_id,
        SUM(p.payment_value) AS revenue
    FROM orders o
    JOIN payments p ON o.order_id = p.order_id
    GROUP BY o.customer_id
)
SELECT
    customer_id,
    ROUND(revenue, 2) AS revenue,
    RANK() OVER (ORDER BY revenue DESC) AS customer_rank
FROM customer_sales;
 
-- top 10 states by revenue
SELECT
    c.customer_state,
    ROUND(SUM(p.payment_value), 2) AS revenue
FROM customers c
JOIN orders o ON c.customer_id = o.customer_id
JOIN payments p ON o.order_id = p.order_id
GROUP BY c.customer_state
ORDER BY revenue DESC
LIMIT 10;
 
-- top 10 cities by revenue
SELECT
    c.customer_city,
    ROUND(SUM(p.payment_value), 2) AS revenue
FROM customers c
JOIN orders o ON c.customer_id = o.customer_id
JOIN payments p ON o.order_id = p.order_id
GROUP BY c.customer_city
ORDER BY revenue DESC
LIMIT 10;