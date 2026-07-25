/* ============================================================================
   Reliance Supermarket Management System
   Database Management Systems Course Project

   File: 02_insert_sample_data.sql

   Author: D. Ravi Theja
   Institution: National Institute of Technology Warangal
   Program: B.Tech Electrical Engineering
   Minor: Computer Science

   Description:
   This script populates the Reliance Supermarket Management System database
   with realistic sample data for testing, validation, and demonstration.

   Data is inserted in dependency order to satisfy all foreign key constraints.

   Records Included:
   • Category          : 10
   • Supplier          : 10
   • Product           : 10
   • Customer          : 10
   • Employee          : 10
   • Bill              : 10
   • Bill_Item         : 15
   • Purchase_Order    : 10
   • Payment           : 10

   Total Sample Records:
   95+

   Prerequisites:
   Execute 01_schema_definition.sql before running this script.

   ============================================================================
*/

-- ═══════════════════════════════════════════════════════════════
-- DML — INSERT statements (insert in dependency order)
-- ═══════════════════════════════════════════════════════════════

/* ============================================================================
   Step 1
   Insert Category Data

   Purpose:
   Stores product categories used throughout the supermarket database.

   Records Inserted:
   10
   ============================================================================ */
INSERT INTO Category (cat_id, cat_name, description) VALUES
('CAT001', 'Dairy',               'Milk, butter, cheese, and other dairy products'),
('CAT002', 'Beverages',           'Cold drinks, juices, water, and energy drinks'),
('CAT003', 'Snacks',              'Chips, biscuits, namkeen, and packaged snacks'),
('CAT004', 'Personal Care',       'Soaps, shampoos, toothpaste, and hygiene products'),
('CAT005', 'Household',           'Cleaning agents, detergents, and home utilities'),
('CAT006', 'Bakery',              'Bread, cakes, buns, and baked items'),
('CAT007', 'Frozen Foods',        'Frozen fries, nuggets, ice cream, and ready meals'),
('CAT008', 'Fruits & Vegetables', 'Fresh produce: fruits and vegetables'),
('CAT009', 'Electronics',         'Earphones, chargers, small gadgets'),
('CAT010', 'Stationery',          'Notebooks, pens, files, and office supplies');

/* ============================================================================
   Step 2
   Insert Supplier Data

   Purpose:
   Stores supplier details used for procurement and inventory management.

   Records Inserted:
   10
   ============================================================================ */
INSERT INTO Supplier (supplier_id, name, contact_person, phone, email, address) VALUES
('SUP001', 'Fresh Farms Pvt Ltd',     'Ramesh Agarwal',   '9801122334', 'ramesh@freshfarms.in',    'Plot 12, Anand Nagar, Pune'),
('SUP002', 'DrinksCo Industries',     'Sunita Mehta',     '9812233445', 'sunita@drinksco.in',      '5th Floor, Nariman Point, Mumbai'),
('SUP003', 'SnackWorld Distributors', 'Anil Verma',       '9823344556', 'anil@snackworld.in',      'Sector 22, Noida, UP'),
('SUP004', 'CareProducts Ltd',        'Kavitha Reddy',    '9834455667', 'kavitha@careproducts.in', 'MG Road, Bengaluru'),
('SUP005', 'HomeEssentials Corp',     'Deepak Shah',      '9845566778', 'deepak@homeessentials.in','Ring Road, Surat, Gujarat'),
('SUP006', 'BakeBest Foods',          'Prerna Joshi',     '9856677889', 'prerna@bakebest.in',      'Industrial Area, Ludhiana'),
('SUP007', 'FrostLine Pvt Ltd',       'Sameer Kulkarni',  '9867788990', 'sameer@frostline.in',     'Cold Storage Zone, Nagpur'),
('SUP008', 'GreenHarvest Agro',       'Nirmala Devi',     '9878899001', 'nirmala@greenharvest.in', 'Village Mandi, Nashik'),
('SUP009', 'TechGoods Wholesale',     'Rajan Pillai',     '9889900112', 'rajan@techgoods.in',      'Lamington Road, Mumbai'),
('SUP010', 'PaperPlus Stationery',    'Asha Trivedi',     '9890011223', 'asha@paperplus.in',       'Civil Lines, Jaipur');

/* ============================================================================
   Step 3
   Insert Product Data

   Purpose:
   Stores supermarket products, pricing, inventory levels and supplier information.

   Records Inserted:
   10
   ============================================================================ */
INSERT INTO Product (product_id, product_name, cat_id, supplier_id, price, stock_qty, reorder_level, unit) VALUES
('PRD001', 'Amul Full Cream Milk 1L',   'CAT001', 'SUP001', 28.00,  150, 30,  'Litre'),
('PRD002', 'Coca-Cola 2L Bottle',       'CAT002', 'SUP002', 65.00,  200, 40,  'Bottle'),
('PRD003', "Lay's Classic Salted Chips",'CAT003', 'SUP003', 20.00,  300, 50,  'Packet'),
('PRD004', 'Dove Beauty Soap 100g',     'CAT004', 'SUP004', 45.00,  180, 35,  'Piece'),
('PRD005', 'Vim Dishwash Bar 200g',     'CAT005', 'SUP005', 22.00,  250, 40,  'Piece'),
('PRD006', 'Britannia Whole Wheat Bread','CAT006','SUP006', 35.00,  120, 25,  'Loaf'),
('PRD007', 'McCain French Fries 400g', 'CAT007',  'SUP007', 120.00,  90, 20,  'Pack'),
('PRD008', 'Fresh Tomatoes 1kg',        'CAT008', 'SUP008', 40.00,   80, 15,  'kg'),
('PRD009', 'boAt Bassheads 100 Earphones','CAT009','SUP009',799.00,  50, 10,  'Piece'),
('PRD010', 'Classmate Single Line Notebook','CAT010','SUP010',55.00,200, 30, 'Piece');

/* ============================================================================
   Step 4
   Insert Customer Data

   Purpose:
   Stores customer details and loyalty information.

   Records Inserted:
   10
   ============================================================================ */
INSERT INTO Customer (customer_id, first_name, last_name, phone, email, address, loyalty_points) VALUES
('CUST001', 'Aarav',    'Sharma',   '9700011111', 'aarav.sharma@gmail.com',   'B-12, Vasant Vihar, Delhi',      50),
('CUST002', 'Priya',    'Patel',    '9700022222', 'priya.patel@gmail.com',    '45, Paldi, Ahmedabad',           120),
('CUST003', 'Rohan',    'Mehta',    '9700033333', 'rohan.mehta@yahoo.com',    '7, Koregaon Park, Pune',         30),
('CUST004', 'Sneha',    'Reddy',    '9700044444', 'sneha.reddy@gmail.com',    '22, Banjara Hills, Hyderabad',   200),
('CUST005', 'Karan',    'Singh',    '9700055555', 'karan.singh@hotmail.com',  '101, Sector 15, Chandigarh',     75),
('CUST006', 'Ananya',   'Nair',     '9700066666', 'ananya.nair@gmail.com',    '8, Indiranagar, Bengaluru',      90),
('CUST007', 'Vikram',   'Joshi',    '9700077777', 'vikram.joshi@gmail.com',   '33, Borivali West, Mumbai',      15),
('CUST008', 'Deepika',  'Gupta',    '9700088888', 'deepika.gupta@gmail.com',  'Flat 4B, Salt Lake, Kolkata',    60),
('CUST009', 'Aditya',   'Kumar',    '9700099999', 'aditya.kumar@gmail.com',   '19, Anna Nagar, Chennai',        40),
('CUST010', 'Pooja',    'Verma',    '9700010101', 'pooja.verma@outlook.com',  '55, Civil Lines, Lucknow',       85);

/* ============================================================================
   Step 5
   Insert Employee Data

   Purpose:
   Stores employee records.

   Records Inserted:
   10
   ============================================================================ */
INSERT INTO Employee (emp_id, first_name, last_name, role, phone, email, salary, hire_date) VALUES
('EMP001', 'Rajesh',  'Kumar',   'Store Manager',    '8800011111', 'rajesh.kumar@reliance.in',   55000.00, '2019-04-01'),
('EMP002', 'Priya',   'Sharma',  'Cashier',          '8800022222', 'priya.sharma@reliance.in',   28000.00, '2020-07-15'),
('EMP003', 'Amit',    'Singh',   'Cashier',          '8800033333', 'amit.singh@reliance.in',     27500.00, '2021-01-10'),
('EMP004', 'Sunita',  'Patel',   'Stock Manager',    '8800044444', 'sunita.patel@reliance.in',   35000.00, '2018-09-20'),
('EMP005', 'Vikram',  'Rao',     'Cashier',          '8800055555', 'vikram.rao@reliance.in',     28500.00, '2021-06-01'),
('EMP006', 'Neha',    'Gupta',   'Sales Associate',  '8800066666', 'neha.gupta@reliance.in',     24000.00, '2022-03-10'),
('EMP007', 'Rahul',   'Mehta',   'Security Guard',   '8800077777', 'rahul.mehta@reliance.in',    20000.00, '2022-08-05'),
('EMP008', 'Deepa',   'Nair',    'Accounts Officer', '8800088888', 'deepa.nair@reliance.in',     38000.00, '2017-11-12'),
('EMP009', 'Arjun',   'Reddy',   'Cashier',          '8800099999', 'arjun.reddy@reliance.in',    27000.00, '2023-02-01'),
('EMP010', 'Kavita',  'Joshi',   'HR Manager',       '8800010101', 'kavita.joshi@reliance.in',   45000.00, '2016-05-30');

/* ============================================================================
   Step 6
   Insert Bill Data

   Purpose:
   Stores customer billing transactions.

   Records Inserted:
   10
   ============================================================================ */
INSERT INTO Bill (bill_id, customer_id, emp_id, bill_date, total_amount, payment_method, status) VALUES
('BILL001', 'CUST001', 'EMP002', '2025-01-05 10:15:00', 124.00,  'Cash',   'Paid'),
('BILL002', 'CUST002', 'EMP003', '2025-01-06 11:30:00', 175.00,  'UPI',    'Paid'),
('BILL003', 'CUST003', 'EMP002', '2025-01-07 14:00:00', 136.00,  'Card',   'Paid'),
('BILL004', 'CUST004', 'EMP005', '2025-01-08 09:45:00', 360.00,  'Cash',   'Paid'),
('BILL005', 'CUST005', 'EMP003', '2025-01-09 16:20:00', 799.00,  'Card',   'Paid'),
('BILL006', 'CUST006', 'EMP009', '2025-01-10 13:00:00', 275.00,  'UPI',    'Paid'),
('BILL007', 'CUST007', 'EMP002', '2025-01-11 10:50:00', 335.00,  'Cash',   'Paid'),
('BILL008', 'CUST008', 'EMP005', '2025-01-12 17:10:00',  80.00,  'Wallet', 'Paid'),
('BILL009', 'CUST009', 'EMP003', '2025-01-13 12:00:00',  35.00,  'UPI',    'Paid'),
('BILL010', 'CUST010', 'EMP009', '2025-01-14 15:30:00',  90.00,  'Card',   'Paid');

/* ============================================================================
   Step 7
   Insert Bill Item Data

   Purpose:
   Stores individual products associated with each bill.

   Records Inserted:
   15
   ============================================================================ */
INSERT INTO Bill_Item (item_id, bill_id, product_id, quantity, unit_price, subtotal) VALUES
('BI001',  'BILL001', 'PRD001', 3,  28.00,  84.00),
('BI002',  'BILL001', 'PRD003', 2,  20.00,  40.00),
('BI003',  'BILL002', 'PRD002', 2,  65.00, 130.00),
('BI004',  'BILL002', 'PRD004', 1,  45.00,  45.00),
('BI005',  'BILL003', 'PRD006', 2,  35.00,  70.00),
('BI006',  'BILL003', 'PRD005', 3,  22.00,  66.00),
('BI007',  'BILL004', 'PRD007', 2, 120.00, 240.00),
('BI008',  'BILL004', 'PRD008', 3,  40.00, 120.00),
('BI009',  'BILL005', 'PRD009', 1, 799.00, 799.00),
('BI010',  'BILL006', 'PRD010', 5,  55.00, 275.00),
('BI011',  'BILL007', 'PRD001', 5,  28.00, 140.00),
('BI012',  'BILL007', 'PRD002', 3,  65.00, 195.00),
('BI013',  'BILL008', 'PRD003', 4,  20.00,  80.00),
('BI014',  'BILL009', 'PRD006', 1,  35.00,  35.00),
('BI015',  'BILL010', 'PRD004', 2,  45.00,  90.00);

/* ============================================================================
   Step 8
   Insert Purchase Order Data

   Purpose:
   Stores purchase orders.

   Records Inserted:
   10
   ============================================================================ */
INSERT INTO Purchase_Order (po_id, supplier_id, emp_id, order_date, expected_date, status, total_amount) VALUES
('PO001', 'SUP001', 'EMP004', '2025-01-02', '2025-01-06', 'Received',  5600.00),
('PO002', 'SUP002', 'EMP004', '2025-01-03', '2025-01-07', 'Received',  9750.00),
('PO003', 'SUP003', 'EMP004', '2025-01-05', '2025-01-09', 'Received',  4000.00),
('PO004', 'SUP004', 'EMP008', '2025-01-06', '2025-01-12', 'Pending',   6300.00),
('PO005', 'SUP005', 'EMP004', '2025-01-07', '2025-01-11', 'Received',  3300.00),
('PO006', 'SUP006', 'EMP008', '2025-01-08', '2025-01-14', 'Pending',   4200.00),
('PO007', 'SUP007', 'EMP004', '2025-01-09', '2025-01-13', 'Received', 10800.00),
('PO008', 'SUP008', 'EMP004', '2025-01-10', '2025-01-15', 'Pending',   3200.00),
('PO009', 'SUP009', 'EMP008', '2025-01-11', '2025-01-18', 'Pending',  39950.00),
('PO010', 'SUP010', 'EMP004', '2025-01-12', '2025-01-16', 'Received',  5500.00);

/* ============================================================================
   Step 9
   Insert Payment Data

   Purpose:
   Stores payment details.

   Records Inserted:
   10
   ============================================================================ */
INSERT INTO Payment (payment_id, bill_id, payment_date, amount, payment_mode, transaction_ref) VALUES
('PAY001', 'BILL001', '2025-01-05 10:15:30', 124.00,  'Cash',   NULL),
('PAY002', 'BILL002', '2025-01-06 11:31:00', 175.00,  'UPI',    'UPI20250106-88421'),
('PAY003', 'BILL003', '2025-01-07 14:01:00', 136.00,  'Card',   'CARD20250107-11329'),
('PAY004', 'BILL004', '2025-01-08 09:46:00', 360.00,  'Cash',   NULL),
('PAY005', 'BILL005', '2025-01-09 16:21:00', 799.00,  'Card',   'CARD20250109-54981'),
('PAY006', 'BILL006', '2025-01-10 13:01:00', 275.00,  'UPI',    'UPI20250110-30017'),
('PAY007', 'BILL007', '2025-01-11 10:51:00', 335.00,  'Cash',   NULL),
('PAY008', 'BILL008', '2025-01-12 17:11:00',  80.00,  'Wallet', 'WLLT20250112-66203'),
('PAY009', 'BILL009', '2025-01-13 12:01:00',  35.00,  'UPI',    'UPI20250113-10445'),
('PAY010', 'BILL010', '2025-01-14 15:31:00',  90.00,  'Card',   'CARD20250114-78932');

/* ============================================================================
   Verification Queries

   Purpose:
   Verify that all sample data has been inserted successfully.
   ============================================================================ */

SELECT COUNT(*) AS categories FROM Category;
SELECT COUNT(*) AS suppliers FROM Supplier;
SELECT COUNT(*) AS products FROM Product;
SELECT COUNT(*) AS customers FROM Customer;
SELECT COUNT(*) AS employees FROM Employee;
SELECT COUNT(*) AS bills FROM Bill;
SELECT COUNT(*) AS bill_items FROM Bill_Item;
SELECT COUNT(*) AS purchase_orders FROM Purchase_Order;
SELECT COUNT(*) AS payments FROM Payment;
