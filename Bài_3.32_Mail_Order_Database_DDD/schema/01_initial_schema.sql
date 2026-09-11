-- Database creation for Exercise 3.32: MAIL_ORDER Database
CREATE DATABASE IF NOT EXISTS mail_order_db;
USE mail_order_db;

-- 1. Table: ZIP_CODE
CREATE TABLE zip_code (
    zip_code VARCHAR(10) PRIMARY KEY COMMENT 'Unique Zip Code',
    city VARCHAR(50) COMMENT 'City name',
    state VARCHAR(50) COMMENT 'State name'
);

-- 2. Table: EMPLOYEE
CREATE TABLE employee (
    emp_no INT PRIMARY KEY AUTO_INCREMENT COMMENT 'Unique employee identifier',
    fname VARCHAR(50) NOT NULL COMMENT 'First name',
    lname VARCHAR(50) NOT NULL COMMENT 'Last name',
    zip_code VARCHAR(10) NOT NULL COMMENT 'Employee Zip Code',
    FOREIGN KEY (zip_code) REFERENCES zip_code(zip_code) ON DELETE RESTRICT ON UPDATE CASCADE
);

-- 3. Table: CUSTOMER
CREATE TABLE customer (
    cust_no INT PRIMARY KEY AUTO_INCREMENT COMMENT 'Unique customer identifier',
    fname VARCHAR(50) NOT NULL COMMENT 'First name',
    lname VARCHAR(50) NOT NULL COMMENT 'Last name',
    zip_code VARCHAR(10) NOT NULL COMMENT 'Customer Zip Code',
    FOREIGN KEY (zip_code) REFERENCES zip_code(zip_code) ON DELETE RESTRICT ON UPDATE CASCADE
);

-- 4. Table: PART
CREATE TABLE part (
    part_no INT PRIMARY KEY AUTO_INCREMENT COMMENT 'Unique part identifier',
    part_name VARCHAR(100) NOT NULL COMMENT 'Part name',
    price DECIMAL(10, 2) NOT NULL CHECK (price >= 0) COMMENT 'Unit price',
    qty_in_stock INT NOT NULL CHECK (qty_in_stock >= 0) COMMENT 'Quantity available in stock'
);

-- 5. Table: ORDERS
CREATE TABLE orders (
    order_no INT PRIMARY KEY AUTO_INCREMENT COMMENT 'Unique order identifier',
    receipt_date DATE NOT NULL COMMENT 'Date order was received',
    expected_ship_date DATE COMMENT 'Expected shipping date',
    actual_ship_date DATE COMMENT 'Actual shipping date',
    cust_no INT NOT NULL COMMENT 'Customer who placed the order',
    emp_no INT NOT NULL COMMENT 'Employee who took the order',
    FOREIGN KEY (cust_no) REFERENCES customer(cust_no) ON DELETE RESTRICT ON UPDATE CASCADE,
    FOREIGN KEY (emp_no) REFERENCES employee(emp_no) ON DELETE RESTRICT ON UPDATE CASCADE
);

-- 6. Table: ORDER_DETAIL
CREATE TABLE order_detail (
    order_no INT NOT NULL COMMENT 'Order ID',
    part_no INT NOT NULL COMMENT 'Part ID',
    quantity INT NOT NULL CHECK (quantity > 0) COMMENT 'Quantity of part ordered',
    PRIMARY KEY (order_no, part_no),
    FOREIGN KEY (order_no) REFERENCES orders(order_no) ON DELETE CASCADE ON UPDATE CASCADE,
    FOREIGN KEY (part_no) REFERENCES part(part_no) ON DELETE RESTRICT ON UPDATE CASCADE
);