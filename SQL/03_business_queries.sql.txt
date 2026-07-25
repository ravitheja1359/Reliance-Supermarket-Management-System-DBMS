/* ============================================================================
   Reliance Supermarket Management System
   Database Management Systems Course Project

   File: 03_business_queries.sql

   Author: <Your Name>
   Institution: National Institute of Technology Warangal
   Program: B.Tech Electrical Engineering
   Minor: Computer Science

   Description:
   This file contains analytical SQL queries developed to solve practical
   business problems for a supermarket management system.

   SQL Concepts Demonstrated:
   • INNER JOIN
   • LEFT JOIN
   • GROUP BY
   • HAVING
   • Aggregate Functions
   • Scalar Subqueries
   • ORDER BY
   • LIMIT

   ============================================================================
*/


/* ============================================================================
   Query 1
   Inventory Reorder Report

   Objective:
   Identify products whose stock has fallen below the reorder level and display
   the corresponding supplier information for inventory replenishment.

   SQL Concepts:
   INNER JOIN, WHERE, ORDER BY
   ============================================================================
*/

SELECT
    p.product_id,
    p.product_name,
    p.stock_qty AS current_stock,
    p.reorder_level,
    (p.reorder_level - p.stock_qty) AS shortage,
    p.unit,
    s.name AS supplier_name,
    s.phone AS supplier_phone
FROM Product p
INNER JOIN Supplier s
ON p.supplier_id = s.supplier_id
WHERE p.stock_qty < p.reorder_level
ORDER BY shortage DESC;


/* ============================================================================
   Query 2
   Category-wise Sales Analysis

   Objective:
   Calculate revenue, units sold, and number of transactions for each product
   category considering only completed (Paid) bills.

   SQL Concepts:
   INNER JOIN, GROUP BY, Aggregate Functions
   ============================================================================
*/

SELECT
    c.cat_id,
    c.cat_name AS category,
    COUNT(DISTINCT bi.bill_id) AS total_transactions,
    SUM(bi.quantity) AS total_units_sold,
    SUM(bi.subtotal) AS total_revenue
FROM Category c
INNER JOIN Product p
ON c.cat_id = p.cat_id
INNER JOIN Bill_Item bi
ON p.product_id = bi.product_id
INNER JOIN Bill b
ON bi.bill_id = b.bill_id
WHERE b.status = 'Paid'
GROUP BY c.cat_id, c.cat_name
ORDER BY total_revenue DESC;


/* ============================================================================
   Query 3
   Top Customers

   Objective:
   Identify the highest spending customers for loyalty programs and marketing.

   SQL Concepts:
   GROUP BY, ORDER BY, LIMIT
   ============================================================================
*/

SELECT
    c.customer_id,
    CONCAT(c.first_name,' ',c.last_name) AS customer_name,
    c.phone,
    COUNT(b.bill_id) AS total_bills,
    SUM(b.total_amount) AS total_spent,
    c.loyalty_points AS current_points
FROM Customer c
INNER JOIN Bill b
ON c.customer_id = b.customer_id
WHERE b.status='Paid'
GROUP BY
    c.customer_id,
    c.first_name,
    c.last_name,
    c.phone,
    c.loyalty_points
ORDER BY total_spent DESC
LIMIT 5;


/* ============================================================================
   Query 4
   Bills Above Average Value

   Objective:
   Find transactions whose value exceeds the average bill amount.

   SQL Concepts:
   Scalar Subquery
   ============================================================================
*/

SELECT
    b.bill_id,
    CONCAT(c.first_name,' ',c.last_name) AS customer_name,
    b.bill_date,
    b.total_amount,
    b.payment_method,
    ROUND(
        (SELECT AVG(total_amount)
         FROM Bill
         WHERE status='Paid'),2
    ) AS avg_bill_amount
FROM Bill b
INNER JOIN Customer c
ON b.customer_id = c.customer_id
WHERE b.total_amount >
(
    SELECT AVG(total_amount)
    FROM Bill
    WHERE status='Paid'
)
ORDER BY b.total_amount DESC;


/* ============================================================================
   Query 5
   Employee Sales Performance

   Objective:
   Display employees who processed two or more customer bills.

   SQL Concepts:
   GROUP BY, HAVING
   ============================================================================
*/

SELECT
    e.emp_id,
    CONCAT(e.first_name,' ',e.last_name) AS employee_name,
    e.role,
    COUNT(b.bill_id) AS bills_processed,
    SUM(b.total_amount) AS total_sales_handled
FROM Employee e
INNER JOIN Bill b
ON e.emp_id = b.emp_id
GROUP BY
    e.emp_id,
    e.first_name,
    e.last_name,
    e.role
HAVING bills_processed >= 2
ORDER BY bills_processed DESC,
         total_sales_handled DESC;


/* ============================================================================
   Query 6
   Unsold Products

   Objective:
   Identify products that have never appeared in any customer bill.

   SQL Concepts:
   LEFT JOIN, IS NULL
   ============================================================================
*/

SELECT
    p.product_id,
    p.product_name,
    c.cat_name AS category,
    p.price,
    p.stock_qty AS units_in_stock,
    p.unit
FROM Product p
LEFT JOIN Bill_Item bi
ON p.product_id = bi.product_id
INNER JOIN Category c
ON p.cat_id = c.cat_id
WHERE bi.item_id IS NULL
ORDER BY p.stock_qty DESC;


/* ============================================================================
   Query 7
   Complete Bill Register

   Objective:
   Generate a consolidated billing report including customer, cashier,
   purchased items and payment information.

   SQL Concepts:
   Multiple INNER JOINs, GROUP BY
   ============================================================================
*/

SELECT
    b.bill_id,
    b.bill_date,
    CONCAT(c.first_name,' ',c.last_name) AS customer_name,
    CONCAT(e.first_name,' ',e.last_name) AS cashier_name,
    COUNT(bi.item_id) AS distinct_products,
    SUM(bi.quantity) AS total_units,
    b.total_amount,
    b.payment_method,
    b.status
FROM Bill b
INNER JOIN Customer c
ON b.customer_id = c.customer_id
INNER JOIN Employee e
ON b.emp_id = e.emp_id
INNER JOIN Bill_Item bi
ON b.bill_id = bi.bill_id
GROUP BY
    b.bill_id,
    b.bill_date,
    c.first_name,
    c.last_name,
    e.first_name,
    e.last_name,
    b.total_amount,
    b.payment_method,
    b.status
ORDER BY b.bill_date;


/* ============================================================================
   Query 8
   Pending Purchase Orders

   Objective:
   Display suppliers having pending purchase orders and the corresponding
   pending procurement value.

   SQL Concepts:
   INNER JOIN, GROUP BY, HAVING
   ============================================================================
*/

SELECT
    s.supplier_id,
    s.name AS supplier_name,
    s.phone AS supplier_phone,
    CONCAT(e.first_name,' ',e.last_name) AS managed_by,
    COUNT(po.po_id) AS pending_orders,
    SUM(po.total_amount) AS total_pending_value,
    MIN(po.expected_date) AS earliest_delivery
FROM Supplier s
INNER JOIN Purchase_Order po
ON s.supplier_id = po.supplier_id
INNER JOIN Employee e
ON po.emp_id = e.emp_id
WHERE po.status='Pending'
GROUP BY
    s.supplier_id,
    s.name,
    s.phone,
    e.first_name,
    e.last_name
HAVING pending_orders >= 1
ORDER BY total_pending_value DESC;