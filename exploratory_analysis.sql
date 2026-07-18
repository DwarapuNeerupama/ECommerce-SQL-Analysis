-- exploratory_analysis
-- just poking around the data to get a feel for it before going deeper

USE ecommerce_project;

-- how many total orders do we actually have
SELECT COUNT(DISTINCT order_id) AS total_orders
FROM orders;

-- breakdown of order status, want to see how many are delivered vs canceled etc
SELECT
    order_status,
    COUNT(*) AS total_orders
FROM orders
GROUP BY order_status
ORDER BY total_orders DESC;

-- orders per month over time, curious if theres a growth trend
SELECT
    YEAR(order_purchase_timestamp) AS year,
    MONTH(order_purchase_timestamp) AS month,
    COUNT(*) AS total_orders
FROM orders
GROUP BY year, month
ORDER BY year, month;

-- highest price per product, good way to spot outliers/expensive items
SELECT
    product_id,
    MAX(price) AS highest_price
FROM order_items
GROUP BY product_id
ORDER BY highest_price DESC
LIMIT 10;

-- just listing out the state codes to make sure geography data looks normal
SELECT DISTINCT customer_state
FROM customers
ORDER BY customer_state;