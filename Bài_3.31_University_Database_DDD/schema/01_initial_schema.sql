-- ============================================================
-- 1. INITIAL SCHEMA: TABLES & CONSTRAINTS
-- Project: UNIVERSITY DATABASE (3.31)
-- ============================================================

CREATE DATABASE IF NOT EXISTS university_extended_db;
USE university_extended_db;

-- Bảng 1: DEPARTMENT (Khoa)
CREATE TABLE department (
    dept_code INT PRIMARY KEY COMMENT 'Mã khoa (Duy nhất)',
    dept_name VARCHAR(100) UNIQUE NOT NULL COMMENT 'Tên khoa',
    office VARCHAR(50) NOT NULL COMMENT 'Văn phòng khoa',
    phone VARCHAR(20) NOT NULL COMMENT 'Số điện thoại khoa',
    college VARCHAR(100) NOT NULL COMMENT 'Trường trực thuộc'
);

-- Bảng 2: STUDENT (Sinh viên)
CREATE TABLE student (
    student_number INT PRIMARY KEY AUTO_INCREMENT COMMENT 'Mã sinh viên',
    ssn VARCHAR(11) UNIQUE NOT NULL COMMENT 'Số CMND/CCCD',
    fname VARCHAR(50) NOT NULL COMMENT 'Tên',
    mname VARCHAR(50) COMMENT 'Tên đệm',
    lname VARCHAR(50) NOT NULL COMMENT 'Họ',
    dob DATE NOT NULL COMMENT 'Ngày sinh',
    sex CHAR(1) COMMENT 'Giới tính (M/F/O)',
    class_level VARCHAR(20) COMMENT 'Năm học (Freshman, Sophomore,...)',
    degree_program VARCHAR(20) COMMENT 'Chương trình đào tạo (B.S., M.S., Ph.D.)',
    
    -- Địa chỉ hiện tại
    curr_street VARCHAR(100),
    curr_city VARCHAR(50),
    curr_state VARCHAR(50),
    curr_zip VARCHAR(20),
    curr_phone VARCHAR(20),
    
    -- Địa chỉ thường trú
    perm_street VARCHAR(100),
    perm_city VARCHAR(50),
    perm_state VARCHAR(50),
    perm_zip VARCHAR(20),
    perm_phone VARCHAR(20),
    
    -- Khoa chính và Khoa phụ
    major_dept_code INT NOT NULL,
    minor_dept_code INT,
    FOREIGN KEY (major_dept_code) REFERENCES department(dept_code) ON DELETE RESTRICT ON UPDATE CASCADE,
    FOREIGN KEY (minor_dept_code) REFERENCES department(dept_code) ON DELETE SET NULL ON UPDATE CASCADE
);

-- Bảng 3: COURSE (Môn học)
CREATE TABLE course (
    course_number VARCHAR(20) PRIMARY KEY COMMENT 'Mã môn học',
    course_name VARCHAR(100) NOT NULL COMMENT 'Tên môn học',
    description TEXT COMMENT 'Mô tả môn học',
    credits INT NOT NULL CHECK (credits > 0) COMMENT 'Số tín chỉ',
    level INT CHECK (level BETWEEN 1 AND 6) COMMENT 'Cấp độ môn học (1-6)',
    dept_code INT NOT NULL COMMENT 'Khoa phụ trách môn học',
    FOREIGN KEY (dept_code) REFERENCES department(dept_code) ON DELETE RESTRICT ON UPDATE CASCADE
);

-- Bảng 4: SECTION (Lớp học phần)
CREATE TABLE section (
    sec_id INT PRIMARY KEY AUTO_INCREMENT COMMENT 'Mã định danh lớp học phần',
    course_number VARCHAR(20) NOT NULL,
    sec_number INT NOT NULL,
    semester VARCHAR(10) NOT NULL,
    year INT NOT NULL,
    instructor_name VARCHAR(100) NOT NULL,
    FOREIGN KEY (course_number) REFERENCES course(course_number) ON DELETE CASCADE ON UPDATE CASCADE
);

-- Bảng 5: ATTENDANCE (Thực thể yếu - Quá trình học trường cũ)
CREATE TABLE attendance (
    student_number INT NOT NULL,
    start_date DATE NOT NULL,
    end_date DATE,
    college_name VARCHAR(150) NOT NULL,
    PRIMARY KEY (student_number, start_date),
    FOREIGN KEY (student_number) REFERENCES student(student_number) ON DELETE CASCADE ON UPDATE CASCADE
);

-- Bảng 6: PREV_DEGREE (Thực thể yếu con - Bằng cấp đã nhận)
CREATE TABLE prev_degree (
    student_number INT NOT NULL,
    start_date DATE NOT NULL,
    degree_name VARCHAR(100) NOT NULL,
    month_awarded INT,
    year_awarded INT NOT NULL,
    PRIMARY KEY (student_number, start_date, degree_name),
    FOREIGN KEY (student_number, start_date) REFERENCES attendance(student_number, start_date) ON DELETE CASCADE ON UPDATE CASCADE
);

-- Bảng 7: PREV_TRANSCRIPT (Thực thể yếu con - Bảng điểm trường cũ)
CREATE TABLE prev_transcript (
    student_number INT NOT NULL,
    start_date DATE NOT NULL,
    course_name VARCHAR(100) NOT NULL,
    semester VARCHAR(10),
    year INT,
    grade VARCHAR(5),
    PRIMARY KEY (student_number, start_date, course_name),
    FOREIGN KEY (student_number, start_date) REFERENCES attendance(student_number, start_date) ON DELETE CASCADE ON UPDATE CASCADE
);