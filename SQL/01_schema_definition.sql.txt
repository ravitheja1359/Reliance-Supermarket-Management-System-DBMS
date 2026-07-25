/* ============================================================================
   Reliance Supermarket Management System
   Database Management Systems Course Project

   File: 01_schema_definition.sql

   Author: D. Ravi Theja
   Institution: National Institute of Technology Warangal
   Program: B.Tech Electrical Engineering
   Minor: Computer Science

   Description:
   This script creates the complete relational database schema for the
   Reliance Supermarket Management System.

   The tables are created in dependency order to ensure that all foreign
   key constraints are successfully established without dependency errors.

   Database Objects Created:
   • Category
   • Supplier
   • Product
   • Customer
   • Employee
   • Bill
   • Bill_Item
   • Purchase_Order
   • Payment

   SQL Concepts Demonstrated:
   • CREATE DATABASE
   • CREATE TABLE
   • PRIMARY KEY
   • FOREIGN KEY
   • UNIQUE Constraints
   • CHECK Constraints
   • DEFAULT Values
   • ENUM Data Types

   ============================================================================
*/


/* ============================================================================
   Step 1
   Create Database
   ============================================================================ */

CREATE DATABASE IF NOT EXISTS reliance_supermarket;

USE reliance_supermarket;


/* ============================================================================
   Table 1
   Category

   Purpose:
   Stores the product categories available in the supermarket.

   Dependencies:
   None
   ============================================================================ */

CREATE TABLE Category (
    cat_id       VARCHAR(10)  NOT NULL,
    cat_name     VARCHAR(50)  NOT NULL,
    description  TEXT,
    CONSTRAINT pk_category PRIMARY KEY (cat_id),
    CONSTRAINT uq_cat_name UNIQUE (cat_name)
);


/* ============================================================================
   Table 2
   Supplier

   Purpose:
   Stores supplier information for procurement and inventory management.

   Dependencies:
   None
   ============================================================================ */

CREATE TABLE Supplier (
    supplier_id    VARCHAR(10)  NOT NULL,
    name           VARCHAR(100) NOT NULL,
    contact_person VARCHAR(100),
    phone          VARCHAR(15)  NOT NULL,
    email          VARCHAR(100),
    address        TEXT,
    CONSTRAINT pk_supplier PRIMARY KEY (supplier_id),
    CONSTRAINT uq_sup_phone UNIQUE (phone),
    CONSTRAINT uq_sup_email UNIQUE (email)
);


/* ============================================================================
   Table 3
   Product

   Purpose:
   Stores product details including category, supplier, pricing and inventory.

   Dependencies:
   Category
   Supplier
   ============================================================================ */

CREATE TABLE Product (
    product_id   VARCHAR(10)   NOT NULL,
    product_name VARCHAR(100)  NOT NULL,
    cat_id       VARCHAR(10)   NOT NULL,
    supplier_id  VARCHAR(10)   NOT NULL,
    price        DECIMAL(10,2) NOT NULL,
    stock_qty    INT           NOT NULL DEFAULT 0,
    reorder_level INT          NOT NULL DEFAULT 10,
    unit         VARCHAR(20),
    CONSTRAINT pk_product PRIMARY KEY (product_id),
    CONSTRAINT fk_prod_cat FOREIGN KEY (cat_id)
        REFERENCES Category(cat_id),
    CONSTRAINT fk_prod_sup FOREIGN KEY (supplier_id)
        REFERENCES Supplier(supplier_id),
    CONSTRAINT chk_price CHECK (price > 0),
    CONSTRAINT chk_stock CHECK (stock_qty >= 0)
);


/* ============================================================================
   Table 4
   Customer

   Purpose:
   Stores customer information and loyalty program details.

   Dependencies:
   None
   ============================================================================ */

CREATE TABLE Customer (
    customer_id    VARCHAR(10) NOT NULL,
    first_name     VARCHAR(50) NOT NULL,
    last_name      VARCHAR(50) NOT NULL,
    phone          VARCHAR(15) NOT NULL,
    email          VARCHAR(100),
    address        TEXT,
    loyalty_points INT NOT NULL DEFAULT 0,
    CONSTRAINT pk_customer PRIMARY KEY (customer_id),
    CONSTRAINT uq_cust_phone UNIQUE (phone),
    CONSTRAINT uq_cust_email UNIQUE (email),
    CONSTRAINT chk_lp CHECK (loyalty_points >= 0)
);


/* ============================================================================
   Table 5
   Employee

   Purpose:
   Stores employee information and cashier details.

   Dependencies:
   None
   ============================================================================ */

CREATE TABLE Employee (
    emp_id VARCHAR(10) NOT NULL,
    first_name VARCHAR(50) NOT NULL,
    last_name VARCHAR(50) NOT NULL,
    role VARCHAR(50) NOT NULL,
    phone VARCHAR(15) NOT NULL,
    email VARCHAR(100),
    salary DECIMAL(10,2) NOT NULL,
    hire_date DATE NOT NULL,
    CONSTRAINT pk_employee PRIMARY KEY (emp_id),
    CONSTRAINT uq_emp_phone UNIQUE (phone),
    CONSTRAINT uq_emp_email UNIQUE (email),
    CONSTRAINT chk_salary CHECK (salary > 0)
);


/* ============================================================================
   Table 6
   Bill

   Purpose:
   Stores customer billing transactions.

   Dependencies:
   Customer
   Employee
   ============================================================================ */

CREATE TABLE Bill (
    bill_id VARCHAR(10) NOT NULL,
    customer_id VARCHAR(10),
    emp_id VARCHAR(10) NOT NULL,
    bill_date DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
    total_amount DECIMAL(10,2) NOT NULL,
    payment_method ENUM('Cash','Card','UPI','Wallet') NOT NULL,
    status ENUM('Paid','Pending','Cancelled') NOT NULL DEFAULT 'Paid',
    CONSTRAINT pk_bill PRIMARY KEY (bill_id),
    CONSTRAINT fk_bill_cust FOREIGN KEY (customer_id)
        REFERENCES Customer(customer_id),
    CONSTRAINT fk_bill_emp FOREIGN KEY (emp_id)
        REFERENCES Employee(emp_id),
    CONSTRAINT chk_bill_amount CHECK (total_amount >= 0)
);


/* ============================================================================
   Table 7
   Bill_Item

   Purpose:
   Stores individual products associated with each customer bill.

   Dependencies:
   Bill
   Product
   ============================================================================ */

CREATE TABLE Bill_Item (
    item_id VARCHAR(10) NOT NULL,
    bill_id VARCHAR(10) NOT NULL,
    product_id VARCHAR(10) NOT NULL,
    quantity INT NOT NULL,
    unit_price DECIMAL(10,2) NOT NULL,
    subtotal DECIMAL(10,2) NOT NULL,
    CONSTRAINT pk_bill_item PRIMARY KEY (item_id),
    CONSTRAINT fk_bi_bill FOREIGN KEY (bill_id)
        REFERENCES Bill(bill_id),
    CONSTRAINT fk_bi_prod FOREIGN KEY (product_id)
        REFERENCES Product(product_id),
    CONSTRAINT chk_quantity CHECK (quantity > 0)
);


/* ============================================================================
   Table 8
   Purchase_Order

   Purpose:
   Stores purchase orders issued to suppliers for inventory replenishment.

   Dependencies:
   Supplier
   Employee
   ============================================================================ */

CREATE TABLE Purchase_Order (
    po_id VARCHAR(10) NOT NULL,
    supplier_id VARCHAR(10) NOT NULL,
    emp_id VARCHAR(10) NOT NULL,
    order_date DATE NOT NULL,
    expected_date DATE,
    status ENUM('Pending','Received','Cancelled')
        NOT NULL DEFAULT 'Pending',
    total_amount DECIMAL(10,2) NOT NULL,
    CONSTRAINT pk_po PRIMARY KEY (po_id),
    CONSTRAINT fk_po_sup FOREIGN KEY (supplier_id)
        REFERENCES Supplier(supplier_id),
    CONSTRAINT fk_po_emp FOREIGN KEY (emp_id)
        REFERENCES Employee(emp_id)
);


/* ============================================================================
   Table 9
   Payment

   Purpose:
   Stores payment information for customer bills.

   A UNIQUE constraint on bill_id enforces a one-to-one relationship between
   Bill and Payment.

   Dependencies:
   Bill
   ============================================================================ */

CREATE TABLE Payment (
    payment_id VARCHAR(10) NOT NULL,
    bill_id VARCHAR(10) NOT NULL,
    payment_date DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
    amount DECIMAL(10,2) NOT NULL,
    payment_mode ENUM('Cash','Card','UPI','Wallet') NOT NULL,
    transaction_ref VARCHAR(50),
    CONSTRAINT pk_payment PRIMARY KEY (payment_id),
    CONSTRAINT uq_pay_bill UNIQUE (bill_id),
    CONSTRAINT fk_pay_bill FOREIGN KEY (bill_id)
        REFERENCES Bill(bill_id)
);