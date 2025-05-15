CREATE TABLE Students(
student_id NUMBER(8) PRIMARY KEY,
full_name NVARCHAR2(25) NOT NULL,
email NVARCHAR2(100) NOT NULL UNIQUE,
phone NUMBER(10) NOT NULL,
gender CHAR(1)
);

-- to view the list of tables--
SELECT table_name from TABS;

--to view the structure of the table students--
DESCRIBE Students;

--To create a child table [Referenced table]
CREATE TABLE Payments
(
payment_id NUMBER(8) PRIMARY KEY,
amount NUMERIC(10,2) NOT NULL,
paidDate DATE NOT NULL,
student_id NUMBER(8) NOT NULL,
FOREIGN KEY(student_id) REFERENCES Students(student_id)
);

--to view the structure of the table payments--
DESCRIBE Payments;


--to view the student table for inserting
describe Students;


--To Insert into the table [Parent]
INSERT INTO Students
(student_id, full_name, email, phone, gender)
VALUES
(101, 'Rama Poudel', 'rama@gmail.com', 9876543210, 'F');
COMMIT;

--To view the records 
SELECT * FROM Students;

--to view the structure of the table payments--
DESCRIBE Payments;

INSERT INTO Payments
(payment_id, amount, paidDate, student_id)
VALUES
(1105, 25000, to_date('2025-04-27', 'YYYY-MM-DD'), 101);
COMMIT;

--to view the records of payment table
SELECT * FROM Payments;

--Inserting 8 new records in the students table
INSERT INTO Students (student_id, full_name, email, phone, gender) 
VALUES (102, 'Sita Sharma', 'sita@gmail.com', 9861234567, 'F');
COMMIT;

INSERT INTO Students (student_id, full_name, email, phone, gender) 
VALUES (103, 'Hari Thapa', 'hari@gmail.com', 9856781234, 'M');
COMMIT;

INSERT INTO Students (student_id, full_name, email, phone, gender) 
VALUES (104, 'Gita Karki', 'gita@gmail.com', 9843217890, 'F');
COMMIT;

INSERT INTO Students (student_id, full_name, email, phone, gender) 
VALUES (105, 'Bikash Bhandari', 'bikash@gmail.com', 9801112233, 'M');
COMMIT;

INSERT INTO Students (student_id, full_name, email, phone, gender) 
VALUES (106, 'Kiran Lama', 'kiran@gmail.com', 9812345678, 'M');
COMMIT;

INSERT INTO Students (student_id, full_name, email, phone, gender) 
VALUES (107, 'Pramila Tamang', 'pramila@gmail.com', 9823456789, 'F');
COMMIT;

INSERT INTO Students (student_id, full_name, email, phone, gender) 
VALUES (108, 'Ramesh Shrestha', 'ramesh@gmail.com', 9834567890, 'M');
COMMIT;

INSERT INTO Students (student_id, full_name, email, phone, gender) 
VALUES (109, 'Sunita Adhikari', 'sunita@gmail.com', 9845678901, 'F');
COMMIT;

--to view records in the students table
SELECT * FROM Students;

--Inserting 8 new records in the payments table
INSERT INTO Payments (payment_id, amount, paidDate, student_id) 
VALUES (1105, 25000, TO_DATE('2025-04-27', 'YYYY-MM-DD'), 101);
COMMIT;

INSERT INTO Payments (payment_id, amount, paidDate, student_id) 
VALUES (1106, 26000, TO_DATE('2025-04-28', 'YYYY-MM-DD'), 102);
COMMIT;

INSERT INTO Payments (payment_id, amount, paidDate, student_id) 
VALUES (1107, 25500, TO_DATE('2025-04-29', 'YYYY-MM-DD'), 103);
COMMIT;

INSERT INTO Payments (payment_id, amount, paidDate, student_id) 
VALUES (1108, 27000, TO_DATE('2025-04-30', 'YYYY-MM-DD'), 104);
COMMIT;

INSERT INTO Payments (payment_id, amount, paidDate, student_id) 
VALUES (1109, 24000, TO_DATE('2025-05-01', 'YYYY-MM-DD'), 105);
COMMIT;

INSERT INTO Payments (payment_id, amount, paidDate, student_id) 
VALUES (1110, 26500, TO_DATE('2025-05-02', 'YYYY-MM-DD'), 106);
COMMIT;

INSERT INTO Payments (payment_id, amount, paidDate, student_id) 
VALUES (1111, 25000, TO_DATE('2025-05-03', 'YYYY-MM-DD'), 107);
COMMIT;

INSERT INTO Payments (payment_id, amount, paidDate, student_id) 
VALUES (1112, 27500, TO_DATE('2025-05-04', 'YYYY-MM-DD'), 108);
COMMIT;

--to view the records in the payment table
SELECT * FROM Payments;


--to update the records in the table
UPDATE Students SET full_name = 'Dinesh Rana' WHERE student_id = 101;
COMMIT;

UPDATE Students SET email = 'dinesh@gmail.com' WHERE student_id = 101;
COMMIT;

SELECT * FROM Students;

--to delete the records from the database
DELETE FROM Students WHERE student_id = 102;

DELETE FROM payments WHERE payment_id = 1111;


--to add new column in the table
ALTER TABLE Students ADD guardian_phone NUMBER(10);

DESCRIBE Students;


ALTER TABLE Students DROP COLUMN guardian_phone;


--to change the datatype of the column
ALTER TABLE Students MODIFY gender char(1);

--to change the col_name;
ALTER TABLE Students RENAME COLUMN full_name TO student_name;

--CREATE TABLE Project(project_id NUMBER(10) PRIMARY KEY NOT NULL, name NVARCHAR2(50) );

--to remvoe the table from the database
DROP TABLE Students;

DROP TABLE Project;



