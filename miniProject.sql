CREATE DATABASE OnlineLearningSystem;

USE OnlineLearningSystem;

-- BẢNG CHA  
CREATE TABLE Students (
	student_id INT PRIMARY KEY AUTO_INCREMENT, 
    full_name VARCHAR(50) NOT NULL,
    dob DATE NOT NULL,
    email VARCHAR(50) NOT NULL UNIQUE
);

CREATE TABLE Teachers (
	teacher_id INT PRIMARY KEY AUTO_INCREMENT, 
    full_name VARCHAR(50) NOT NULL,
    email VARCHAR(50) NOT NULL UNIQUE
);

-- BẢNG CON
CREATE TABLE Courses (
    course_id INT PRIMARY KEY AUTO_INCREMENT,
    course_name VARCHAR(100) NOT NULL,
    course_description TEXT, 
    total_lessons INT CHECK (total_lessons > 0),
    teacher_id INT,
    FOREIGN KEY (teacher_id) REFERENCES Teachers(teacher_id)  -- Một khóa học chỉ do một giảng viên phụ trách 
);

CREATE TABLE Enrollments (
	enrollment_id INT PRIMARY KEY AUTO_INCREMENT, 
    student_id INT NOT NULL,
    course_id INT NOT NULL,
    registration_date DATE DEFAULT(CURRENT_DATE),
	UNIQUE (student_id, course_id), -- Không được đăng ký trùng cùng một khóa học cho cùng một sinh viên
    FOREIGN KEY (student_id) REFERENCES Students(student_id), -- Một khóa học có thể có nhiều sinh viên 
    FOREIGN KEY (course_id) REFERENCES Courses(course_id)
);

CREATE TABLE Scores (
	score_id INT PRIMARY KEY AUTO_INCREMENT,
	student_id INT NOT NULL,
    course_id INT NOT NULL,
    midterm_score FLOAT NOT NULL CHECK (midterm_score >= 0 and midterm_score <= 10), -- Điểm nằm trong khoảng từ 0 đến 10 
    final_score FLOAT NOT NULL CHECK (final_score >= 0 and final_score <= 10),
    UNIQUE (student_id, course_id), -- Mỗi sinh viên chỉ có một kết quả cho mỗi khóa học 
    FOREIGN KEY (student_id) REFERENCES Students(student_id),
    FOREIGN KEY (course_id) REFERENCES Courses(course_id)
);


