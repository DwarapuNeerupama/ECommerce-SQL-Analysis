-- sales_analysis
-- digging into revenue, products, and payments
 
USE ecommerce_project;
 
-- total revenue for the whole dataset
SELECT ROUND(SUM(payment_value), 2) AS total_revenue
FROM payments;
 
-- average order value
SELECT ROUND(AVG(payment_value), 2) AS average_order_value
FROM payments;
 
-- revenue and number of transactions broken down by payment type
-- curious if credit card is way ahead of everything else
SELECT
    payment_type,
    COUNT(*) AS transactions,
    ROUND(SUM(payment_value), 2) AS total_revenue
FROM payments
GROUP BY payment_type
ORDER BY total_revenue DESC;
 
-- monthly revenue trend
SELECT
    YEAR(o.order_purchase_timestamp) AS year,
    MONTH(o.order_purchase_timestamp) AS month,
    ROUND(SUM(p.payment_value), 2) AS revenue
FROM orders o
JOIN payments p ON o.order_id = p.order_id
GROUP BY year, month
ORDER BY year, month;
 
-- top 10 products by revenue
SELECT
    product_id,
    COUNT(*) AS units_sold,
    ROUND(SUM(price), 2) AS revenue
FROM order_items
GROUP BY product_id
ORDER BY revenue DESC
LIMIT 10;
 
-- top 10 sellers by revenue
SELECT
    seller_id,
    ROUND(SUM(price), 2) AS total_revenue
FROM order_items
GROUP BY seller_id
ORDER BY total_revenue DESC
LIMIT 10;