/* ============================================================================
   Reliance Supermarket Management System
   Database Management Systems Course Project

   File: 04_maintenance_queries.sql

   Author: D. Ravi Theja
   Institution: National Institute of Technology Warangal
   Program: B.Tech Electrical Engineering
   Minor: Computer Science

   Description:
   This file contains maintenance and administrative SQL operations used to
   update and maintain the supermarket database.

   NOTE:
   These queries modify database records. Execute them only after loading
   the sample database.

   SQL Concepts Demonstrated:
   • UPDATE
   • DELETE
   • JOIN
   • Derived Tables
   • Referential Integrity

   ============================================================================
*/


/* ============================================================================
   Query 1
   Update Customer Loyalty Points

   Objective:
   Award one loyalty point for every ₹10 spent on completed purchases.

   SQL Concepts:
   UPDATE, JOIN, Derived Table
   ============================================================================
*/

UPDATE Customer c
INNER JOIN
(
    SELECT
        customer_id,
        SUM(total_amount) AS total_spent
    FROM Bill
    WHERE status='Paid'
    GROUP BY customer_id
) AS spending
ON c.customer_id = spending.customer_id

SET c.loyalty_points =
    c.loyalty_points +
    FLOOR(spending.total_spent / 10);


/* Verify Updated Loyalty Points */

SELECT
    customer_id,
    CONCAT(first_name,' ',last_name) AS customer_name,
    loyalty_points
FROM Customer
ORDER BY loyalty_points DESC;


/* ============================================================================
   Query 2
   Delete Cancelled Bills

   Objective:
   Remove cancelled bills while maintaining referential integrity.

   SQL Concepts:
   DELETE, Subqueries, Foreign Key Dependency
   ============================================================================
*/


/* Step 1 : Delete bill items */

DELETE FROM Bill_Item
WHERE bill_id IN
(
    SELECT bill_id
    FROM Bill
    WHERE status='Cancelled'
);


/* Step 2 : Delete payment records */

DELETE FROM Payment
WHERE bill_id IN
(
    SELECT bill_id
    FROM Bill
    WHERE status='Cancelled'
);


/* Step 3 : Delete cancelled bills */

DELETE FROM Bill
WHERE status='Cancelled';


/* Verify Cleanup */

SELECT
    status,
    COUNT(*) AS count
FROM Bill
GROUP BY status;