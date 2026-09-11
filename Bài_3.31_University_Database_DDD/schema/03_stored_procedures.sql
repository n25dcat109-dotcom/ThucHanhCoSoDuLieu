-- ============================================================
-- 3. STORED PROCEDURES & FUNCTIONS
-- Project: UNIVERSITY DATABASE (Bài 3.31)
-- ============================================================

USE university_extended_db;

DELIMITER //

-- Thủ tục: getStudentPreviousEducation
-- Mục đích: Tra cứu toàn bộ lịch sử học tập tại trường cũ của sinh viên (Trường đã học, Bằng cấp, Bảng điểm)
-- Tham số đầu vào: p_student_number INT
CREATE PROCEDURE getStudentPreviousEducation (
    IN p_student_number INT
)
BEGIN
    -- 1. Liệt kê các trường đại học/cao đẳng đã từng theo học
    SELECT 
        college_name AS 'Trường đã học', 
        start_date AS 'Ngày bắt đầu', 
        end_date AS 'Ngày kết thúc'
    FROM attendance 
    WHERE student_number = p_student_number;
    
    -- 2. Danh sách bằng cấp đã nhận từ các trường cũ
    SELECT 
        a.college_name AS 'Tên trường', 
        d.degree_name AS 'Tên bằng cấp', 
        d.month_awarded AS 'Tháng cấp', 
        d.year_awarded AS 'Năm cấp'
    FROM prev_degree d
    JOIN attendance a ON d.student_number = a.student_number AND d.start_date = a.start_date
    WHERE d.student_number = p_student_number;

    -- 3. Bảng điểm chi tiết các môn học tích lũy tại trường cũ
    SELECT 
        a.college_name AS 'Tên trường', 
        t.course_name AS 'Tên môn học', 
        t.semester AS 'Học kỳ', 
        t.year AS 'Năm học', 
        t.grade AS 'Điểm số'
    FROM prev_transcript t
    JOIN attendance a ON t.student_number = a.student_number AND t.start_date = a.start_date
    WHERE t.student_number = p_student_number;
END //

DELIMITER ;