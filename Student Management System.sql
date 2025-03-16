-- Student Management System (SMS)
CREATE DATABASE IF NOT EXISTS CollegeDB;
USE CollegeDB;

CREATE TABLE IF NOT EXISTS Learners (
    learner_id INT PRIMARY KEY AUTO_INCREMENT,
    first_name VARCHAR(50),
    last_name VARCHAR(50),
    email VARCHAR(100) UNIQUE,
    date_of_birth DATE,
    phone VARCHAR(15)
);

CREATE TABLE IF NOT EXISTS Faculties (
    faculty_id INT PRIMARY KEY AUTO_INCREMENT,
    faculty_name VARCHAR(100)
);

CREATE TABLE IF NOT EXISTS Subjects (
    subject_id INT PRIMARY KEY AUTO_INCREMENT,
    subject_name VARCHAR(100),
    faculty_id INT,
    FOREIGN KEY (faculty_id) REFERENCES Faculties(faculty_id)
);

CREATE TABLE IF NOT EXISTS Registrations (
    registration_id INT PRIMARY KEY AUTO_INCREMENT,
    learner_id INT,
    subject_id INT,
    registration_date DATE,
    FOREIGN KEY (learner_id) REFERENCES Learners(learner_id),
    FOREIGN KEY (subject_id) REFERENCES Subjects(subject_id)
);

INSERT INTO Learners (first_name, last_name, email, date_of_birth, phone) VALUES
('John', 'Doe', 'john.doe@email.com', '2000-05-15', '1234567890'),
('Alice', 'Smith', 'alice.smith@email.com', '2001-08-22', '9876543210');

INSERT INTO Faculties (faculty_name) VALUES
('Computer Science'),
('Mathematics');

INSERT INTO Subjects (subject_name, faculty_id) VALUES
('Data Structures', 1),
('Linear Algebra', 2);

INSERT INTO Registrations (learner_id, subject_id, registration_date) VALUES
(1, 1, '2024-02-01'),
(2, 2, '2024-02-02');

SELECT * FROM Learners;

SELECT s.subject_name, f.faculty_name FROM Subjects s
JOIN Faculties f ON s.faculty_id = f.faculty_id;

SELECT r.registration_id, l.first_name, l.last_name, s.subject_name, r.registration_date 
FROM Registrations r
JOIN Learners l ON r.learner_id = l.learner_id
JOIN Subjects s ON r.subject_id = s.subject_id;

INSERT INTO Learners (first_name, last_name, email, date_of_birth, phone)
VALUES ('Emily', 'Davis', 'emily.davis@email.com', '2002-03-10', '5551234567');

UPDATE Learners
SET phone = '5559876543'
WHERE email = 'alice.smith@email.com';

SELECT s.subject_name, f.faculty_name
FROM Subjects s
JOIN Faculties f ON s.faculty_id = f.faculty_id;

INSERT INTO Registrations (learner_id, subject_id, registration_date)
VALUES (1, 2, '2024-03-15');

DELETE FROM Registrations
WHERE registration_id = 1;

SELECT f.faculty_name, COUNT(r.learner_id) AS num_learners
FROM Faculties f
LEFT JOIN Subjects s ON f.faculty_id = s.faculty_id
LEFT JOIN Registrations r ON s.subject_id = r.subject_id
GROUP BY f.faculty_name;
