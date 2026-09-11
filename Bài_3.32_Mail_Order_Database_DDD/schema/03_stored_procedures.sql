USE mail_order_db;

DELIMITER //

CREATE PROCEDURE getOrderInvoice (
    IN p_order_no INT
)
BEGIN
    -- Informational overview
    SELECT 
        o.order_no AS 'Mã đơn hàng',
        o.receipt_date AS 'Ngày nhận',
        o.actual_ship_date AS 'Ngày giao',
        CONCAT(c.fname, ' ', c.lname) AS 'Khách hàng',
        CONCAT(e.fname, ' ', e.lname) AS 'Nhân viên tiếp nhận'
    FROM orders o
    JOIN customer c ON o.cust_no = c.cust_no
    JOIN employee e ON o.emp_no = e.emp_no
    WHERE o.order_no = p_order_no;

    -- Order items and total calculation
    SELECT 
        p.part_no AS 'Mã sản phẩm',
        p.part_name AS 'Tên sản phẩm',
        od.quantity AS 'Số lượng',
        p.price AS 'Đơn giá',
        (od.quantity * p.price) AS 'Thành tiền'
    FROM order_detail od
    JOIN part p ON od.part_no = p.part_no
    WHERE od.order_no = p_order_no;
END //

DELIMITER ;