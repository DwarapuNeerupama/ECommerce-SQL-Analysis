CREATE DATABASE IF NOT EXISTS ecommerce_project;

USE ecommerce_project;


CREATE TABLE customers
(
customer_id VARCHAR(50),
customer_unique_id VARCHAR(50),
customer_zip_code_prefix INT,
customer_city VARCHAR(100),
customer_state VARCHAR(10)
);

CREATE TABLE orders
(
order_id VARCHAR(50),
customer_id VARCHAR(50),
order_status VARCHAR(30),
order_purchase_timestamp DATETIME,
order_approved_at DATETIME,
order_delivered_carrier_date DATETIME,
order_delivered_customer_date DATETIME,
order_estimated_delivery_date DATETIME
);


CREATE TABLE order_items
(
order_id VARCHAR(50),
order_item_id INT,
product_id VARCHAR(50),
seller_id VARCHAR(50),
shipping_limit_date DATETIME,
price DECIMAL(10,2),
freight_value DECIMAL(10,2)
);


CREATE TABLE payments
(
order_id VARCHAR(50),
payment_sequential INT,
payment_type VARCHAR(30),
payment_installments INT,
payment_value DECIMAL(10,2)
);

SET GLOBAL local_infile = 1;

-- update the file paths below to wherever you've saved the Olist CSVs locally
-- dataset: https://www.kaggle.com/datasets/olistbr/brazilian-ecommerce

LOAD DATA LOCAL INFILE 
'/path/to/olist_orders_dataset.csv'

INTO TABLE orders

FIELDS TERMINATED BY ','

ENCLOSED BY '"'

LINES TERMINATED BY '\n'

IGNORE 1 ROWS;

LOAD DATA LOCAL INFILE 
'/path/to/olist_order_items_dataset.csv'

INTO TABLE order_items

FIELDS TERMINATED BY ','

ENCLOSED BY '"'

LINES TERMINATED BY '\n'

IGNORE 1 ROWS;

LOAD DATA LOCAL INFILE 
'/path/to/olist_order_payments_dataset.csv'

INTO TABLE payments

FIELDS TERMINATED BY ','

ENCLOSED BY '"'

LINES TERMINATED BY '\n'

IGNORE 1 ROWS;

SELECT COUNT(*) AS orders_count 
FROM orders;


SELECT COUNT(*) AS order_items_count 
FROM order_items;


SELECT COUNT(*) AS payments_count 
FROM payments;

LOAD DATA LOCAL INFILE 
'/path/to/olist_customers_dataset.csv'

INTO TABLE customers

FIELDS TERMINATED BY ','

ENCLOSED BY '"'

LINES TERMINATED BY '\n'

IGNORE 1 ROWS;

SELECT COUNT(*) AS customers_count 
FROM customers;

SELECT *
FROM customers
LIMIT 5;

SELECT *
FROM orders
LIMIT 5;

SELECT *
FROM payments
LIMIT 5;