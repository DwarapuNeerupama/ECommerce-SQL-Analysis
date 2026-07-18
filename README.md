## E-commerce Customer & Sales Analytics (SQL)

## Business Question

How is an e-commerce business actually performing — where's the revenue coming from, who are the customers driving it, and where are the operational weak points (late deliveries, canceled orders, shipping costs)? I wanted to answer that entirely in SQL, working with a relational schema the way an analyst would query a real production database.

 ## About the data

Built on the Olist Brazilian e-commerce dataset (https://www.kaggle.com/datasets/olistbr/brazilian-ecommerce) — customers, orders, order items, and payments across four related tables. Set up a MySQL database (ecommerce_project) and loaded the raw CSVs in myself rather than starting from a pre-cleaned file.

## Database Schema

The project uses a relational database consisting of four normalized tables.


customers – Customer location and identification information.
orders – Order details and purchase timestamps.
order_items – Product-level information including price and freight cost.
payments – Payment method, installments, and payment value.


## Relationships


One customer can place multiple orders.
One order can contain multiple products.
One order can have multiple payment records.


The database schema was designed and implemented in MySQL Workbench.
<img width="745" height="603" alt="image" src="https://github.com/user-attachments/assets/6fe5629a-892c-4c76-8d03-2e72c09c54ad" />

## What's in this repo


Database_Setup.sql – creates the schema (customers, orders, order_items, payments) and loads the raw CSVs

Data_cleaning.sql – checks for duplicate IDs, orphaned records (orders with no matching customer, order_items with no matching order), invalid prices/payments, and delivery dates that don't make sense

exploratory_analysis.sql – first pass at the data: order counts, order status breakdown, orders over time, price outliers

customer_analysis.sql – repeat customers, top spenders, customer ranking with a window function, revenue by state and city

sales_analysis.sql – total revenue, average order value, revenue by payment type, monthly revenue trend, top products and sellers

business_insights.sql – delivery performance: average delivery time, late delivery rate, freight cost as a % of item price


## What I found

Average delivery time came out to about 12.5 days, and roughly 8% of delivered orders arrived after the estimated delivery date. That's a reasonable baseline for e-commerce, but it's also a clear spot to flag if this were a real ops review — that ~8% late rate is where I'd focus a follow-up.

## SQL concepts used

Joins across 4 tables, aggregates (SUM, AVG, COUNT), GROUP BY/HAVING, subqueries, CTEs, window functions (RANK), DATEDIFF for delivery time calculations

## Tools

MySQL

## Note

The dataset isn't included in this repo — it's a public Kaggle dataset (linked above). Download the CSVs yourself and update the file paths in Database_Setup.sql (the /path/to/... placeholders) to wherever you save them locally.
