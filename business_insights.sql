-- business_insights
-- looking at delivery performance and a few other operational things
 
USE ecommerce_project;
 
-- average delivery time in days (purchase date to when customer actually got it)
-- only counting orders that were actually delivered, obviously
SELECT
    ROUND(
        AVG(DATEDIFF(order_delivered_customer_date, order_purchase_timestamp)),
    2) AS average_delivery_days
FROM orders
WHERE order_delivered_customer_date IS NOT NULL;
 
-- average shipping cost per item
SELECT ROUND(AVG(freight_value), 2) AS average_freight_cost
FROM order_items;
 
-- revenue split by order status
-- wanted to see how much money is basically stuck in canceled/unavailable orders
SELECT
    o.order_status,
    ROUND(SUM(p.payment_value), 2) AS revenue
FROM orders o
JOIN payments p ON o.order_id = p.order_id
GROUP BY o.order_status
ORDER BY revenue DESC;
 
-- how many orders showed up late (after the estimated delivery date)
-- and what percent of delivered orders that actually is
SELECT
    COUNT(*) AS late_orders,
    ROUND(
        100.0 * COUNT(*) / (SELECT COUNT(*) FROM orders WHERE order_delivered_customer_date IS NOT NULL),
    2) AS pct_of_delivered_orders
FROM orders
WHERE order_delivered_customer_date > order_estimated_delivery_date;
 
-- freight cost as a % of item price, just wanted to see if shipping
-- is eating up a big chunk of the price on average
SELECT
    ROUND(AVG(freight_value / price) * 100, 2) AS avg_freight_pct_of_price
FROM order_items
WHERE price > 0;
 
 
 SELECT
    ROUND(
        AVG(DATEDIFF(order_delivered_customer_date, order_purchase_timestamp)),
    2) AS average_delivery_days
FROM orders
WHERE order_delivered_customer_date IS NOT NULL;

-- finding: average delivery time is 12.5 days from purchase to delivery
-- thats decent for e-commerce, most orders seem to get there within about
-- 2 weeks. combined with the late delivery check below (8.11% arrive late),
-- shows most deliveries are on time but theres still room to improve for
-- that ~8% that miss the estimated date