--  Creating Database
CREATE DATABASE IF NOT EXISTS EduHubDB;
USE EduHubDB;

-- Creating Tables

CREATE TABLE IF NOT EXISTS Students (
    student_id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(100) NOT NULL,
    email VARCHAR(100) UNIQUE NOT NULL,
    dob DATE NOT NULL
);

CREATE TABLE IF NOT EXISTS Subjects (
    subject_id INT AUTO_INCREMENT PRIMARY KEY,
    subject_name VARCHAR(100) NOT NULL,
    department_id INT
);

CREATE TABLE IF NOT EXISTS Departments (
    department_id INT AUTO_INCREMENT PRIMARY KEY,
    department_name VARCHAR(100) NOT NULL
);

CREATE TABLE IF NOT EXISTS Instructors (
    instructor_id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(100) NOT NULL,
    email VARCHAR(100) UNIQUE NOT NULL,
    department_id INT,
    FOREIGN KEY (department_id) REFERENCES Departments(department_id) ON DELETE CASCADE
);

CREATE TABLE IF NOT EXISTS Grades (
    grade_id INT AUTO_INCREMENT PRIMARY KEY,
    student_id INT,
    subject_id INT,
    grade CHAR(2),
    FOREIGN KEY (student_id) REFERENCES Students(student_id) ON DELETE CASCADE,
    FOREIGN KEY (subject_id) REFERENCES Subjects(subject_id) ON DELETE CASCADE
);

-- Inserting Data

INSERT INTO Departments (department_name) VALUES 
('Computer Science'), ('Mathematics'), ('Physics');

INSERT INTO Students (name, email, dob) VALUES 
('Alice Johnson', 'alice@example.com', '2000-05-12'),
('Bob Smith', 'bob@example.com', '1999-08-22'),
('Charlie Brown', 'charlie@example.com', '2001-01-15');

INSERT INTO Subjects (subject_name, department_id) VALUES 
('Database Systems', 1),
('Linear Algebra', 2),
('Quantum Physics', 3);

INSERT INTO Instructors (name, email, department_id) VALUES 
('Dr. Alan Turing', 'turing@example.com', 1),
('Dr. Ada Lovelace', 'ada@example.com', 2),
('Dr. Albert Einstein', 'einstein@example.com', 3);

INSERT INTO Grades (student_id, subject_id, grade) VALUES 
(1, 1, 'A'),
(2, 2, 'B'),
(3, 3, 'A'),
(1, 2, 'C');


-- 1. Retrieve a specific value from a related table and use it in a query
-- Find all students who scored the same grade as Alice
SELECT name FROM Students 
WHERE student_id IN (
    SELECT student_id FROM Grades 
    WHERE grade = (SELECT grade FROM Grades WHERE student_id = 1 LIMIT 1)
);

-- 2. Retrieve multiple values and use them in a query with IN, ANY, or ALL
-- Find students who scored any grade higher than 'C'
SELECT name FROM Students 
WHERE student_id IN (
    SELECT student_id FROM Grades 
    WHERE grade > 'C'
);

-- 3. Write a query where the subquery depends on the outer query
-- Find students who have taken subjects offered by the "Mathematics" department
SELECT name FROM Students 
WHERE student_id IN (
    SELECT student_id FROM Grades 
    WHERE subject_id IN (
        SELECT subject_id FROM Subjects 
        WHERE department_id = (
            SELECT department_id FROM Departments WHERE department_name = 'Mathematics'
        )
    )
);
