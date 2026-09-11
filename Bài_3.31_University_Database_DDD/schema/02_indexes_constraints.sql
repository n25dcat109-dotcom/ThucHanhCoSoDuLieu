-- ============================================================
-- 2. INDEXES & CONSTRAINTS DOCUMENTATION
-- Project: UNIVERSITY DATABASE (Bài 3.31)
-- ============================================================

USE university_extended_db;

-- ------------------------------------------------------------
-- INDEXES
-- ------------------------------------------------------------

-- Index 1: Tối ưu truy vấn tra cứu nhanh sinh viên theo SSN/CCCD
CREATE UNIQUE INDEX idx_student_ssn ON student (ssn);

-- Index 2: Đáp ứng Yêu cầu 3.16 - Tra cứu địa chỉ thường trú (City, State, Zip)
CREATE INDEX idx_student_perm_addr ON student (perm_city, perm_state, perm_zip);

-- Index 3: Tối ưu hiển thị danh sách lớp học phần theo học kỳ & năm học
CREATE INDEX idx_section_term ON section (course_number, semester, year);

-- ------------------------------------------------------------
-- ADDITIONAL CONSTRAINTS
-- ------------------------------------------------------------

-- Constraint 1: Số thứ tự lớp (sec_number) là duy nhất trong cùng 1 môn, 1 học kỳ và 1 năm học
ALTER TABLE section ADD CONSTRAINT uq_section_term 
UNIQUE (course_number, sec_number, semester, year);

-- Constraint 2: Giới hạn các giá trị hợp lệ cho năm học của sinh viên
ALTER TABLE student ADD CONSTRAINT chk_class_level 
CHECK (class_level IN ('Freshman', 'Sophomore', 'Junior', 'Senior', 'Graduate'));