--  Creating Database
CREATE DATABASE IF NOT EXISTS EduManagementDB;
USE EduManagementDB;

--  Creating Tables
CREATE TABLE IF NOT EXISTS Learners (
    learner_id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(100) NOT NULL,
    email VARCHAR(100) UNIQUE NOT NULL,
    dob DATE NOT NULL
);

CREATE TABLE IF NOT EXISTS Subjects (
    subject_id INT AUTO_INCREMENT PRIMARY KEY,
    subject_name VARCHAR(100) NOT NULL,
    credits INT NOT NULL
);

CREATE TABLE IF NOT EXISTS Registrations (
    registration_id INT AUTO_INCREMENT PRIMARY KEY,
    learner_id INT,
    subject_id INT,
    registration_date DATE NOT NULL,
    FOREIGN KEY (learner_id) REFERENCES Learners(learner_id) ON DELETE CASCADE,
    FOREIGN KEY (subject_id) REFERENCES Subjects(subject_id) ON DELETE CASCADE
);

CREATE TABLE IF NOT EXISTS Instructors (
    instructor_id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(100) NOT NULL,
    email VARCHAR(100) UNIQUE NOT NULL,
    department VARCHAR(100) NOT NULL
);

CREATE TABLE IF NOT EXISTS Assignments (
    assignment_id INT AUTO_INCREMENT PRIMARY KEY,
    instructor_id INT,
    subject_id INT,
    semester VARCHAR(50) NOT NULL,
    FOREIGN KEY (instructor_id) REFERENCES Instructors(instructor_id) ON DELETE CASCADE,
    FOREIGN KEY (subject_id) REFERENCES Subjects(subject_id) ON DELETE CASCADE
);

--  Inserting Data
INSERT INTO Learners (name, email, dob) VALUES 
('Alice Johnson', 'alice@example.com', '2000-05-12'),
('Bob Smith', 'bob@example.com', '1999-08-22'),
('Charlie Brown', 'charlie@example.com', '2001-01-15');

INSERT INTO Subjects (subject_name, credits) VALUES 
('Database Systems', 4),
('Operating Systems', 3),
('Computer Networks', 3);

INSERT INTO Registrations (learner_id, subject_id, registration_date) VALUES 
(1, 1, '2024-01-10'),
(2, 2, '2024-01-12'),
(3, 3, '2024-01-15'),
(1, 2, '2024-01-18');

INSERT INTO Instructors (name, email, department) VALUES 
('Dr. Alan Turing', 'turing@example.com', 'Computer Science'),
('Dr. Ada Lovelace', 'ada@example.com', 'Mathematics');

INSERT INTO Assignments (instructor_id, subject_id, semester) VALUES 
(1, 1, 'Spring 2024'),
(2, 2, 'Spring 2024');

--  JOIN Queries

-- 1. INNER JOIN: Retrieve learners who are registered for subjects
SELECT Learners.name AS Learner, Subjects.subject_name AS Subject
FROM Learners
INNER JOIN Registrations ON Learners.learner_id = Registrations.learner_id
INNER JOIN Subjects ON Registrations.subject_id = Subjects.subject_id;

-- 2. LEFT JOIN: Retrieve all learners, even those not registered for any subject
SELECT Learners.name AS Learner, Subjects.subject_name AS Subject
FROM Learners
LEFT JOIN Registrations ON Learners.learner_id = Registrations.learner_id
LEFT JOIN Subjects ON Registrations.subject_id = Subjects.subject_id;

-- 3. RIGHT JOIN: Retrieve all subjects, even those without registered learners
SELECT Learners.name AS Learner, Subjects.subject_name AS Subject
FROM Learners
RIGHT JOIN Registrations ON Learners.learner_id = Registrations.learner_id
RIGHT JOIN Subjects ON Registrations.subject_id = Subjects.subject_id;

-- 4. FULL OUTER JOIN (Using UNION)
SELECT Learners.name AS Learner, Subjects.subject_name AS Subject
FROM Learners
LEFT JOIN Registrations ON Learners.learner_id = Registrations.learner_id
LEFT JOIN Subjects ON Registrations.subject_id = Subjects.subject_id

UNION

SELECT Learners.name AS Learner, Subjects.subject_name AS Subject
FROM Learners
RIGHT JOIN Registrations ON Learners.learner_id = Registrations.learner_id
RIGHT JOIN Subjects ON Registrations.subject_id = Subjects.subject_id;

-- 5. SELF JOIN: Retrieve instructors who teach in the same department
SELECT A.name AS Instructor1, B.name AS Instructor2, A.department
FROM Instructors A
JOIN Instructors B ON A.department = B.department AND A.instructor_id <> B.instructor_id;
