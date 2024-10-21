-- Database Creation
CREATE DATABASE IF NOT EXISTS `Laboratory_Managment_System`;
USE `laboratory_managment_system`;

-- Table Definitions for the tables Labs, Labs Maintenance, Lab Equipment, Issues, Lab Status, Location, Students, Lab Card, Modules, Module Coordinator, Assessments and Admins
-- Labs
CREATE TABLE IF NOT EXISTS labs (lab_id INTEGER PRIMARY KEY AUTO_INCREMENT,lab_name VARCHAR(255) NOT NULL);

-- Labs Maintenance
CREATE TABLE IF NOT EXISTS Labs_Maintenances (Lab_Maintenance_ID INTEGER PRIMARY KEY AUTO_INCREMENT,Name VARCHAR(255) NOT NULL,Age INTEGER NOT NULL,Gender VARCHAR(255) NOT NULL,Lab_ID INTEGER NOT NULL,FOREIGN KEY (Lab_ID) REFERENCES labs(lab_id) ON DELETE NO ACTION ON UPDATE CASCADE);

-- Lab Equipment
CREATE TABLE IF NOT EXISTS Lab_equipment (Equipment_ID INTEGER PRIMARY KEY AUTO_INCREMENT, IP_Address VARCHAR(255) NOT NULL,Lab_ID INTEGER NOT NULL,FOREIGN KEY (Lab_ID) REFERENCES labs(lab_id) ON DELETE NO ACTION ON UPDATE CASCADE);

-- Issues
CREATE TABLE IF NOT EXISTS Issues (Issues_ID INTEGER PRIMARY KEY AUTO_INCREMENT,Issue VARCHAR(255) NOT NULL,Equipment_ID INTEGER NOT NULL,FOREIGN KEY (Equipment_ID) REFERENCES Lab_equipment(Equipment_ID) ON DELETE NO ACTION ON UPDATE CASCADE);

-- Lab Status
CREATE TABLE IF NOT EXISTS Lab_Status (Date DATE NOT NULL,Current_Status VARCHAR(255) NOT NULL,Network_Connectivity VARCHAR(255) NOT NULL);

-- Location
CREATE TABLE IF NOT EXISTS Location (Location_ID INTEGER PRIMARY KEY AUTO_INCREMENT,Lab_Name VARCHAR(255) NOT NULL,Department VARCHAR(255) NOT NULL,Lab_ID INTEGER NOT NULL,FOREIGN KEY (Lab_ID) REFERENCES labs(lab_id) ON DELETE NO ACTION ON UPDATE CASCADE);

-- Students
CREATE TABLE IF NOT EXISTS Students (Student_ID VARCHAR(255) PRIMARY KEY NOT NULL,Student_Name VARCHAR(255) NOT NULL,Semester INTEGER NOT NULL,Password VARCHAR(255) NOT NULL,Username VARCHAR(255) NOT NULL,Department VARCHAR(255) NOT NULL,Street_No INTEGER NOT NULL,Street_Name VARCHAR(255) NOT NULL,Town VARCHAR(255) NOT NULL,Leadr_ID VARCHAR(255) DEFAULT NULL);

-- Lab Card
CREATE TABLE IF NOT EXISTS Lab_Card (Lab_Card_ID INTEGER PRIMARY KEY AUTO_INCREMENT,Student_ID VARCHAR(255) NOT NULL,Batch_No INTEGER NOT NULL,FOREIGN KEY (Student_ID) REFERENCES Students(Student_ID) ON DELETE NO ACTION ON UPDATE CASCADE);

-- Modules
CREATE TABLE IF NOT EXISTS Modules (Module_Code VARCHAR(255) PRIMARY KEY NOT NULL,Module_Name VARCHAR(255) NOT NULL,Module_Description VARCHAR(255) NOT NULL);

-- Module Coordinator
CREATE TABLE IF NOT EXISTS Module_Coordinator (Coordinator_ID VARCHAR(255) PRIMARY KEY NOT NULL,Module_Code VARCHAR(255) NOT NULL,Name VARCHAR(255) NOT NULL,Email VARCHAR(255) NOT NULL,Department VARCHAR(255) NOT NULL,FOREIGN KEY (Module_Code) REFERENCES Modules(Module_Code) ON DELETE NO ACTION ON UPDATE
 CASCADE);
 
 -- Assessments
CREATE TABLE IF NOT EXISTS Assessments (Assessment_ID INTEGER PRIMARY KEY AUTO_INCREMENT,Student_ID VARCHAR(255) NOT NULL,Name VARCHAR(255) NOT NULL,Mark INTEGER NOT NULL DEFAULT 0,Coordinator_ID VARCHAR(255) NOT NULL,FOREIGN KEY (Coordinator_ID) REFERENCES Module_Coordinator(Coordinator_ID) ON DELETE NO
 ACTION ON UPDATE CASCADE,FOREIGN KEY (Student_ID) REFERENCES Students(Student_ID) ON DELETE NO ACTION ON UPDATE CASCADE);
 
 -- Definition of the Derived Attribute 'Grade' in Assessments table
 CREATE VIEW Assessments_With_Grade AS
 SELECT Assessment_ID, Student_ID, Name, Mark,
 CASE
 WHEN Mark >= 75 THEN 'A'
 WHEN Mark >= 65 THEN 'B'
 WHEN Mark >= 50 THEN 'C'
 WHEN Mark >= 35 THEN 'C-'
 ELSE 'F'
 END AS Grade,
 Coordinator_ID
 FROM Assessments;
 
 -- Admins
 CREATE TABLE IF NOT EXISTS Admins(User_Name VARCHAR(255) NOT NULL,Password VARCHAR(255) NOT NULL,Department VARCHAR(255) NOT NULL);
 
 -- Inserting Data into the tables
 INSERT INTO labs (lab_name)
    VALUES ('Physics Lab'),
     ('Chemistry Lab'),
     ('Biology Lab'),
     ('Computer Science Lab'),
	 ('Mathematics Lab'),
     ('English Lab');
     
 INSERT INTO  Labs_Maintenances(Name, Age, Gender, Lab_ID)
     VALUES ('John Doe', 30, 'Male', 1),
     ('Jane Smith', 32, 'Female', 2),
     ('Robert Johnson', 28, 'Male', 3),
     ('Mary Williams', 35, 'Female', 4),
     ('James Brown', 33, 'Male', 5),
     ('Patricia Davis', 31, 'Female', 6);
     
 INSERT INTO Lab_equipment (IP_Address, Lab_ID)
     VALUES ('192.168.1.1',  1),
     ('192.168.1.2',  2),
     ('192.168.1.3',  3),
     ('192.168.1.4',  4),
     ('192.168.1.5',  5),
     ('192.168.1.6',  6);
     
 INSERT INTO Issues (Issue, Equipment_ID)
     VALUES ('Issue 1', 2),
     ('Issue 2', 2),
     ('Issue 3', 3),
     ('Issue 4', 4),
     ('Issue 5', 5),
     ('Issue 6', 6);
     
 INSERT INTO Lab_Status (Date, Current_Status, Network_Connectivity)
     VALUES ('2022-01-01', 'Operational', 'Connected'),
     ('2022-02-01', 'Operational', 'Disconnected'),
     ('2022-03-01', 'Under Maintenance', 'Connected'),
     ('2022-04-01', 'Operational', 'Connected'),
     ('2022-05-01', 'Under Maintenance', 'Disconnected'),
     ('2022-06-01', 'Operational', 'Connected');
     
 INSERT INTO Location (Lab_Name, Department, Lab_ID)
     VALUES ('Physics Lab', 'Physics Department', 1),
     ('Chemistry Lab', 'Chemistry Department', 2),
     ('Biology Lab', 'Biology Department', 3),
     ('Computer Science Lab', 'Computer Science Department', 4),
     ('Mathematics Lab', 'Mathematics Department', 5),
     ('English Lab', 'English Department', 6);
     
 INSERT INTO Students (Student_ID, Student_Name, Semester, Password, Username, Department, Street_No, Street_Name, Town)
     VALUES ('S1', 'Student 1', 1, 'password1', 'username1', 'Computer Science', 123, 'Street 1', 'Town 1'),
     ('S2', 'Student 2', 2, 'password2', 'username2', 'Computer Science', 456, 'Street 2', 'Town 2'),
     ('S3', 'Student 3', 1, 'password3', 'username3', 'Computer Science', 789, 'Street 3', 'Town 3'),
     ('S4', 'Student 4', 2, 'password4', 'username4', 'Mathematics', 321, 'Street 4', 'Town 4'),
     ('S5', 'Student 5', 1, 'password5', 'username5', 'English', 654, 'Street 5', 'Town 5'),
     ('S6', 'Student 6', 2, 'password6', 'username6', 'Physics', 987, 'Street 6', 'Town 6');
     
 INSERT INTO Lab_Card (Student_ID, Batch_No)
     VALUES ('S1', 2021),
     ('S2', 2021),
     ('S3', 2022),
     ('S4', 2021),
     ('S5', 2022),
     ('S6', 2021);
     
 INSERT INTO Modules (Module_Code, Module_Name, Module_Description)
     VALUES ('CS101', 'Computer Science Basics', 'Introduction to Computer Science'),
     ('CS102', 'Advanced Computer Science', 'Advanced topics in Computer Science'),
     ('MA101', 'Mathematics Basics', 'Introduction to Mathematics'),
     ('EN101', 'English Basics', 'Introduction to English'),
     ('PH101', 'Physics Basics', 'Introduction to Physics'),
     ('CH101', 'Chemistry Basics', 'Introduction to Chemistry');
     
 INSERT INTO Module_Coordinator (Coordinator_ID, Module_Code, Name, Email, Department)
     VALUES ('C1', 'CS101', 'Dr.Emily Johnson', 'emily.johnson@google.com', 'Computer Science'),
     ('C2', 'CS102', 'Michael Brown', 'michael.brown@yahoo.com', 'Computer Science'),
     ('C3', 'MA101', 'Robert Johnson', 'robertjohnson@example.com', 'Mathematics'),
     ('C4', 'EN101', 'Sarah Lee', 'sarah.lee@gmail.com', 'English'),
     ('C5', 'PH101', 'David Wang', 'david.wang@hotmail.com', 'Physics'),
     ('C6', 'CH101', 'Ms.Lisa Taylor', 'lisa.taylor@yahoo.com', 'Chemistry');
     
 INSERT INTO Assessments (Student_ID, Name, Mark, Coordinator_ID)
     VALUES ('S1', 'Assessment 1', 85, 'C1'),
     ('S2', 'Assessment 2', 90, 'C2'),
     ('S3', 'Assessment 3', 95, 'C3'),
     ('S4', 'Assessment 4', 80, 'C4'),
     ('S5', 'Assessment 5', 75, 'C5'),
     ('S6', 'Assessment 6', 70, 'C6');
     
 INSERT INTO Admins (User_Name, Password, Department)
     VALUES ('admin1', 'password1', 'Computer Science'),
     ('admin2', 'password2', 'Mathematics'),
     ('admin3', 'password3', 'Physics'),
     ('admin4', 'password4', 'Chemistry'),
     ('admin5', 'password5', 'Biology'),
     ('admin6', 'password6', 'English');

-- Upadating     
 UPDATE labs
     SET lab_name = 'New Lab Name 1'
     WHERE lab_id = 1;
     
 UPDATE labs
     SET lab_name = 'New Lab Name 2'
     WHERE lab_id = 2;
     
 UPDATE Labs_Maintenances
     SET name = 'New Name 1', age = 30
     WHERE lab_maintenance_id = 1;
     
 UPDATE Labs_Maintenances
     SET name = 'New Name 2', age = 31
     WHERE lab_maintenance_id = 2;
 
 UPDATE Lab_equipment
     SET IP_Address = '192.168.1.8'
	 WHERE Equipment_ID = 1;
     
 UPDATE Lab_equipment
     SET IP_Address = '192.168.1.9'
     WHERE Equipment_ID = 2;
     
 UPDATE Issues
     SET Issue = 'Updated Issue'
     WHERE Issues_ID = 1;
     
 UPDATE Issues
	 SET Issue = 'IP error'
	 WHERE Issues_ID = 3;
     
 UPDATE Lab_Status
	 SET Current_Status = 'Under Maintenance', Network_Connectivity = 'Disconnected'
     WHERE DATE = '2022-01-01';
     
 UPDATE Lab_Status
     SET Current_Status = 'Removed', Network_Connectivity = 'Disconnected'
     WHERE Date = '2022-02-01';
     
 UPDATE Location
     SET Lab_Name = 'New Lab Name 1', department = 'New Department 1'
     WHERE Location_ID = 1;
     
 UPDATE Location
     SET Lab_Name = 'New Lab Name 2', department = 'New Department 2'
     WHERE Location_ID = 2;
     
 UPDATE Students
     SET Student_Name = 'New Student Name 1', Semester = 2
     WHERE Student_ID = 'S1';
 
 UPDATE Students
     SET Student_Name = 'New Student Name 2', Semester = 3
     WHERE Student_ID = 'S2';
     
 UPDATE Lab_Card
     SET Batch_No = 2022
     WHERE Lab_Card_ID = 1;
     
 UPDATE Lab_Card
     SET Batch_No = 2023
     WHERE Lab_Card_ID = 2;
     
 UPDATE Modules
     SET Module_Name = 'New Module Name 1', Module_Description = 'New Description 1'
     WHERE Module_Code = 'CS101';
    
 UPDATE Modules
     SET Module_Name = 'New Module Name 2', Module_Description = 'New Description 2'
     WHERE Module_Code = 'CS102';
     
 UPDATE Module_Coordinator
     SET Name = 'Dr.Michael Brown', email = 'newemail1@example.com'
     WHERE Coordinator_ID = 'C2';
    
 UPDATE Module_Coordinator
     SET Name = 'Dr.Robert Johnson', email = 'newemail2@example.com'
     WHERE Coordinator_ID = 'C3';
    
 UPDATE Module_Coordinator
     SET Name = 'Dr.Sarah Lee'
     WHERE Coordinator_ID = 'C4';
    
 UPDATE Module_Coordinator
     SET Name = 'Mr.David Wang'
     WHERE Coordinator_ID = 'C5';
    
 UPDATE Module_Coordinator
     SET Name = 'Mr.David Young'
     WHERE Coordinator_ID = 'C5';
     
 UPDATE Assessments
     SET name = 'New Assessment Name 1', mark = 90
     WHERE assessment_id = 1;
    
 UPDATE assessments
     SET name = 'New Assessment Name 2', mark = 95
     WHERE assessment_id = 2;
    
 UPDATE admins
     SET password = 'newpassword1', department = 'New Department 1'
     WHERE user_name = 'admin1';
    
 UPDATE admins
     SET password = 'newpassword2', department = 'New Department 2'
     WHERE user_name = 'admin2';

-- Deleting     
DELETE FROM labs_maintenances WHERE lab_maintenance_id = 1;

DELETE FROM lab_equipment WHERE equipment_id = 1;

DELETE FROM issues WHERE issues_id = 1;

DELETE FROM lab_status WHERE Date = '2022-01-01';

DELETE FROM location WHERE location_id = 1;

DELETE FROM lab_card WHERE lab_card_id = 1;

DELETE FROM assessments WHERE assessment_id = 1;

DELETE FROM admins WHERE user_name = 'admin1';

DELETE FROM module_coordinator WHERE coordinator_id = 'C1';

DELETE FROM modules WHERE module_code = 'CS101';

DELETE FROM students WHERE student_id = 'S1';

DELETE FROM labs WHERE lab_id = 1;

-- Queries 
-- Simple Queries

-- 1. Select all records from the `labs` table - Select Opertaion
SELECT * FROM labs;

-- 2. Select all records from the `lab_equipment` table where `lab_id` is 2 - Select Operation
SELECT * FROM lab_equipment WHERE lab_id = 2;

-- 3. Select only the `lab_name` column from the `labs` table - Project Operation
SELECT lab_name FROM labs;

-- 4. Cartesian Product Operation between the 'Labs' and 'Lab Equipment' tables
SELECT * FROM labs CROSS JOIN lab_equipment;

-- 5. Creating a user view
CREATE VIEW lab_view AS SELECT lab_name FROM labs;

-- 6. Rename the Column 'Lab Name' in Labs table
SELECT lab_name AS Laboratory_Name FROM labs;

-- 7. Maximum age from Labs Maintenance table
SELECT MAX(age) AS Maximum_Age FROM labs_maintenances;

-- 8. Use of the 'LIKE' Keyword
SELECT * FROM labs WHERE lab_name LIKE '%Lab%';

-- Complex Queries

-- Without User Views
-- 1. Union Operation
SELECT student_id AS id, student_name AS name, department
    FROM students
    UNION
    SELECT user_name AS id, user_name AS name, department
    FROM admins;

-- 2. Intersection Operation
SELECT s.department FROM students AS s INNER JOIN admins AS a ON s.department = a.department;

-- 3. Set Difference Operation
SELECT l.* FROM labs AS l
    WHERE NOT EXISTS (SELECT 1 FROM lab_equipment AS le WHERE l.lab_id = le.lab_id);
 
 -- 4. Division Operation
SELECT mc.coordinator_id, mc.name FROM module_coordinator AS mc
    WHERE NOT EXISTS ( SELECT m.module_code FROM modules AS m
    WHERE NOT EXISTS (SELECT mc2.module_code FROM module_coordinator AS mc2
    WHERE mc2.coordinator_id = mc.coordinator_id AND mc2.module_code = m.module_code));

-- With User views
-- 5. Inner Join
CREATE VIEW labs_and_equipment_view AS
    SELECT l.lab_id, l.lab_name, le.equipment_id, le.ip_address
    FROM labs AS l
    INNER JOIN lab_equipment AS le ON l.lab_id = le.lab_id;
SELECT * FROM labs_and_equipment_view;

-- 6. Natural Join
CREATE VIEW labs_equipment_view AS
    SELECT * FROM labs
    NATURAL JOIN lab_equipment;
SELECT * FROM labs_equipment_view;

-- 7. Left Outer Join
CREATE VIEW student_lab_card_view AS
    SELECT s.student_id, s.student_name, lc.lab_card_id, lc.batch_no
    FROM students AS s
    LEFT OUTER JOIN lab_card AS lc ON s.student_id = lc.student_id;
SELECT * FROM student_lab_card_view;

-- 8. Right Outer Join
	SELECT s.student_id, s.student_name, lc.lab_card_id
    FROM students AS s
    RIGHT OUTER JOIN lab_card AS lc ON s.student_id = lc.student_id;

-- 8. Right Outer Join
CREATE VIEW student_lab_card_right_view AS
    SELECT s.student_id, lc.lab_card_id, lc.batch_no
    FROM students AS s
    RIGHT OUTER JOIN lab_card AS lc ON s.student_id = lc.student_id;
SELECT * FROM student_lab_card_right_view;

-- 9. Full Outer Join
CREATE VIEW student_lab_card_full_view AS
    SELECT s.student_id, s.student_name, lc.lab_card_id, lc.batch_no
    FROM students AS s
    LEFT JOIN lab_card AS lc ON s.student_id = lc.student_id
    UNION
    SELECT s.student_id, s.student_name, lc.lab_card_id, lc.batch_no
    FROM students AS s
    RIGHT JOIN lab_card AS lc ON s.student_id = lc.student_id;
SELECT * FROM student_lab_card_full_view;

-- 9. Full Outer Join
CREATE VIEW coordinator_assessments_view AS
    SELECT mc.coordinator_id, mc.module_code, mc.name, mc.email, mc.department, a.assessment_id, a.student_id, a.name AS assessment_name, a.mark
    FROM module_coordinator AS mc
    LEFT JOIN assessments AS a ON mc.coordinator_id = a.coordinator_id
    UNION
    SELECT mc.coordinator_id, mc.module_code, mc.name, mc.email, mc.department, a.assessment_id, a.student_id, a.name AS assessment_name, a.mark
    FROM module_coordinator AS mc
    RIGHT JOIN assessments AS a ON mc.coordinator_id = a.coordinator_id;
SELECT * FROM coordinator_assessments_view;

-- 10. Outer Union
CREATE VIEW students_exists_view AS
    SELECT * FROM students AS s
    WHERE EXISTS (SELECT 1 FROM lab_card AS lc
    WHERE lc.student_id = s.student_id AND lc.batch_no = 2021);
SELECT * FROM students_exists_view;

-- Nested Queries

-- 1
SELECT student_id, name FROM assessments WHERE mark > 75;

-- 2
SELECT s.student_name, a.mark FROM students AS s JOIN assessments AS a ON s.student_id = a.student_id;

-- 3
SELECT s.student_id, s.student_name
    FROM students AS s JOIN assessments AS a ON s.student_id = a.student_id
    WHERE a.mark > (SELECT AVG(mark) FROM assessments);

-- Database Tuning

-- Tuned Query 1
EXPLAIN SELECT student_id, name FROM assessments WHERE mark > 75;

CREATE INDEX idx_mark ON assessments(mark);
CREATE INDEX idx_student_id ON assessments(student_id);

EXPLAIN SELECT student_id, name FROM assessments WHERE mark > 75;
 
SELECT student_id, name
    FROM assessments
    WHERE mark > 75;

-- Tuned Query 2    
EXPLAIN SELECT * FROM student_lab_card_view;

CREATE INDEX idx_student_id ON students(student_id);
CREATE INDEX idx_student_id ON lab_card(student_id);

EXPLAIN SELECT * FROM student_lab_card_view;

SELECT s.student_id, s.student_name, lc.lab_card_id, lc.batch_no
    FROM students AS s
    LEFT OUTER JOIN lab_card AS lc USING (student_id);
drop  INDEX idx_student_id ON students;

-- Tuned Query 3
EXPLAIN SELECT * FROM student_lab_card_full_view;

CREATE INDEX idx_student_id_students ON students(student_id);
create INDEX idx_student_id_lab_card ON lab_card(student_id);

EXPLAIN SELECT * FROM student_lab_card_full_view;

SELECT * FROM student_lab_card_full_view;

-- Tuned Query 4
EXPLAIN SELECT * FROM coordinator_assessments_view;

CREATE INDEX idx_coordinator_id_module_coordinator ON module_coordinator(coordinator_id);
CREATE INDEX idx_assessments_coordinator_id ON assessments(coordinator_id); 

EXPLAIN SELECT * FROM coordinator_assessments_view;

SELECT * FROM coordinator_assessments_view;

-- Tuned Query 5
explain SELECT * FROM students_exists_view;

CREATE VIEW students_exists_view_tuned AS
    SELECT s.*
    FROM students AS s
    JOIN lab_card AS lc ON s.student_id = lc.student_id
    WHERE lc.batch_no = 2021;
    
Explain Select * FROM students_exists_view_tuned;

Select * FROM students_exists_view_tuned;

-- Tuned Query 6
explain SELECT student_id AS id, student_name AS name, department FROM students UNION SELECT user_name AS id, user_name AS name, department FROM admins;

SELECT student_id AS id, student_name AS name, department
    FROM students
    UNION ALL
    SELECT user_name AS id, user_name AS name, department
    FROM admins;
    
EXPLAIN
    SELECT student_id AS id, student_name AS name, department
    FROM students
    UNION ALL
    SELECT user_name AS id, user_name AS name, department
    FROM admins;

-- Tuned Query 7
EXPLAIN SELECT s.department FROM students AS s INNER JOIN admins AS a ON s.department = a.department;

SELECT DISTINCT s.department
    FROM students AS s
    WHERE EXISTS (
    SELECT 1 FROM admins AS a WHERE s.department = a.department);
    
EXPLAIN SELECT DISTINCT s.department FROM students AS s WHERE EXISTS (SELECT 1 FROM admins AS a WHERE s.department = a.department);

-- Tuned Query 8
EXPLAIN SELECT le.lab_id FROM lab_equipment AS le WHERE NOT EXISTS (SELECT i.issue FROM issues AS i WHERE NOT EXISTS ( SELECT le2.equipment_id FROM lab_equipment AS le2 INNER JOIN issues AS i2 ON le2.equipment_id = i2.equipment_id  WHERE le2.lab_id = le.lab_id AND i2.issue = i.issue  ));

SELECT DISTINCT le.lab_id
    FROM lab_equipment AS le
    LEFT JOIN issues AS i ON le.equipment_id = i.equipment_id WHERE i.issue IS NULL;
    
EXPLAIN SELECT DISTINCT le.lab_id FROM lab_equipment AS le LEFT JOIN issues AS i ON le.equipment_id = i.equipment_id WHERE i.issue IS NULL;

-- Tuned Query 9
 EXPLAIN SELECT s.student_id, s.student_name FROM students AS s JOIN assessments AS a ON s.student_id = a.student_id WHERE a.mark > (  SELECT AVG(mark) FROM assessments);
 
 SELECT DISTINCT s.student_id, s.student_name
    FROM students AS s
    JOIN assessments AS a ON s.student_id = a.student_id
    JOIN (
    SELECT AVG(mark) AS avg_mark
    FROM assessments
    ) AS avg_table ON a.mark > avg_table.avg_mark;
    
EXPLAIN SELECT DISTINCT s.student_id, s.student_name FROM students AS s JOIN assessments AS a ON s.student_id = a.student_id JOIN (SELECT AVG(mark) AS avg_mark FROM assessments ) AS avg_table ON a.mark > avg_table.avg_mark;

-- Tuned Query 10
EXPLAIN SELECT l.* FROM labs AS l  WHERE NOT EXISTS (SELECT 1 FROM lab_equipment AS le  WHERE l.lab_id = le.lab_id);

SELECT l.*
    FROM labs AS l
    LEFT JOIN lab_equipment AS le ON l.lab_id = le.lab_id
    WHERE le.lab_id IS NULL;
    
EXPLAIN SELECT l.* FROM labs AS l LEFT JOIN lab_equipment AS le ON l.lab_id = le.lab_id WHERE le.lab_id IS NULL;


    
    
    
