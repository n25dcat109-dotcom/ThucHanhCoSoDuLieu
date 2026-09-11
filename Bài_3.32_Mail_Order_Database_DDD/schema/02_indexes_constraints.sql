USE mail_order_db;

-- Indexes
CREATE INDEX idx_orders_customer ON orders (cust_no);
CREATE INDEX idx_orders_employee ON orders (emp_no);
CREATE INDEX idx_part_name ON part (part_name);

-- Constraints
ALTER TABLE orders ADD CONSTRAINT chk_ship_dates 
CHECK (actual_ship_date IS NULL OR actual_ship_date >= receipt_date);