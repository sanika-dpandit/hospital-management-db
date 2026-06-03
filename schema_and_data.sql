DROP DATABASE IF EXISTS ISTE230_Group3;
CREATE DATABASE ISTE230_Group3;
USE ISTE230_Group3;
CREATE TABLE IF NOT EXISTS Department (
    department_id INT PRIMARY KEY,
    department_name VARCHAR(50),
    department_description TEXT
);
CREATE TABLE IF NOT EXISTS Doctor (
    doctor_id INT PRIMARY KEY,
    first_name VARCHAR(50),
    last_name VARCHAR(50),
    start_date DATE,
    gender ENUM('M', 'F') NOT NULL,
    email_address VARCHAR(100),
    phone_number VARCHAR(15),
    department_id INT NOT NULL,
    FOREIGN KEY (department_id) REFERENCES Department(department_id)
);
CREATE TABLE IF NOT EXISTS Patient (
    patient_id INT PRIMARY KEY,
    first_name VARCHAR(50),
    last_name VARCHAR(50),
    date_of_birth DATE,
    gender ENUM('M', 'F') NOT NULL,
    email_address VARCHAR(100),
    number VARCHAR(15)
);
CREATE TABLE IF NOT EXISTS Appointment (
    appointment_id INT PRIMARY KEY,
    patient_id INT,
    doctor_id INT,
    appointment_date DATE,
    appointment_status ENUM('Scheduled', 'Completed', 'Cancelled', 'No-show') NOT NULL,
    FOREIGN KEY (patient_id) REFERENCES Patient(patient_id),
    FOREIGN KEY (doctor_id) REFERENCES Doctor(doctor_id)
);
CREATE TABLE IF NOT EXISTS Prescription (
    prescription_id INT PRIMARY KEY,
    appointment_id INT,
    medicine_name VARCHAR(255),
    prescription_date DATE,
    prescription_instruction TEXT,
    FOREIGN KEY (appointment_id) REFERENCES Appointment(appointment_id)
);
CREATE TABLE IF NOT EXISTS Invoice (
    invoice_id INT PRIMARY KEY,
    patient_id INT,
    invoice_date DATE,
    subtotal DECIMAL(10, 2),
    status ENUM('Paid', 'Unpaid', 'Pending'),  -- Example statuses
    FOREIGN KEY (patient_id) REFERENCES Patient(patient_id)
);
CREATE TABLE IF NOT EXISTS Service (
    service_id INT PRIMARY KEY,
    department_id INT,
    cost DECIMAL(10, 2),
    service_type VARCHAR(255),
    service_description TEXT,
    FOREIGN KEY (department_id) REFERENCES Department(department_id)
);
CREATE TABLE IF NOT EXISTS InvoiceService (
    invoice_service_id INT PRIMARY KEY,
    invoice_id INT,
    service_id INT,
    quantity INT,
    FOREIGN KEY (invoice_id) REFERENCES Invoice(invoice_id),
    FOREIGN KEY (service_id) REFERENCES Service(service_id)
);

CREATE TABLE IF NOT EXISTS LabTech (
    lab_tech_id INT PRIMARY KEY,
    first_name VARCHAR(255),
    last_name VARCHAR(255),
    gender ENUM('M','F'),  -- Example genders
    email_address VARCHAR(255),
    phone_number VARCHAR(15),
    department_id INT,
    FOREIGN KEY (department_id) REFERENCES Department(department_id)
);

-- Creating the LabReport table
CREATE TABLE IF NOT EXISTS LabReport (
    lab_report_id INT PRIMARY KEY,
    doctor_id INT,
    patient_id INT,
    lab_tech_id INT,
    test_type VARCHAR(255),
    test_result TEXT,
    report_date DATE,
    report_status ENUM('Complete', 'Pending', 'Cancelled'),  
    FOREIGN KEY (doctor_id) REFERENCES Doctor(doctor_id),
    FOREIGN KEY (patient_id) REFERENCES Patient(patient_id),
    FOREIGN KEY (lab_tech_id) REFERENCES LabTech(lab_tech_id)
);

-- Inserting data into Department
INSERT INTO Department (department_id, department_name, department_description)
VALUES
(1, 'Cardiology', 'Handles heart related diseases and conditions.'),
(2, 'Neurology', 'Deals with disorders of the nervous system.'),
(3, 'Orthopedics', 'Focuses on diseases and injuries of the musculoskeletal system.'),
(4, 'Pediatrics', 'Provides medical care for infants, children, and teenagers.'),
(5, 'Dermatology', 'Concerned with disorders of the skin.');

-- Inserting data into Doctor
INSERT INTO Doctor (doctor_id, first_name, last_name, start_date, gender, email_address, phone_number, department_id)
VALUES
(1, 'Alice', 'Smith', '2015-02-10', 'F', 'alice.smith@email.com', '555-0101', 1),
(2, 'Bob', 'Jones', '2010-03-15', 'M', 'bob.jones@email.com', '555-0102', 2),
(3, 'Carol', 'Johnson', '2018-07-25', 'F', 'carol.johnson@email.com', '555-0103', 3),
(4, 'David', 'Lee', '2012-12-01', 'M', 'david.lee@email.com', '555-0104', 4),
(5, 'Eva', 'Brown', '2020-01-20', 'F', 'eva.brown@email.com', '555-0105', 5);

-- Inserting data into Patient
INSERT INTO Patient (patient_id, first_name, last_name, date_of_birth, gender, email_address, number)
VALUES
(1, 'John', 'Doe', '1990-04-01', 'M', 'john.doe@email.com', '555-0201'),
(2, 'Mary', 'Davis', '1982-05-10', 'F', 'mary.davis@email.com', '555-0202'),
(3, 'Sam', 'Wilson', '1975-06-15', 'M', 'sam.wilson@email.com', '555-0203'),
(4, 'Linda', 'Moore', '1998-07-20', 'F', 'linda.moore@email.com', '555-0204'),
(5, 'James', 'Taylor', '2000-08-30', 'M', 'james.taylor@email.com', '555-0205');

-- Inserting data into Appointment
INSERT INTO Appointment (appointment_id, patient_id, doctor_id, appointment_date, appointment_status)
VALUES
(1, 1, 1, '2023-04-15', 'Scheduled'),
(2, 2, 2, '2023-04-17', 'Completed'),
(3, 3, 3, '2023-04-18', 'Cancelled'),
(4, 4, 4, '2023-04-19', 'No-show'),
(5, 5, 5, '2023-04-20', 'Scheduled');

INSERT INTO Prescription (prescription_id, appointment_id, medicine_name, prescription_date, prescription_instruction)
VALUES
(1, 1, 'Amoxicillin', '2023-04-12', 'Take one tablet three times a day'),
(2, 2, 'Ibuprofen', '2023-04-13', 'Take two tablets twice a day'),
(3, 3, 'Acetaminophen', '2023-04-14', 'Take one tablet every 6 hours'),
(4, 4, 'Metformin', '2023-04-15', 'Take one tablet twice a day with meals'),
(5, 5, 'Simvastatin', '2023-04-16', 'Take one tablet in the evening');

INSERT INTO Invoice (invoice_id, patient_id, invoice_date, subtotal, status)
VALUES
(1, 1, '2023-04-12', 150.00, 'Paid'),
(2, 2, '2023-04-13', 200.00, 'Unpaid'),
(3, 3, '2023-04-14', 250.00, 'Pending'),
(4, 4, '2023-04-15', 300.00, 'Paid'),
(5, 5, '2023-04-16', 350.00, 'Unpaid');



INSERT INTO Service (service_id, department_id, cost, service_type, service_description)
VALUES
(1, 1, 100.00, 'Echocardiogram', 'Ultrasound of the heart'),
(2, 2, 200.00, 'MRI Brain', 'Magnetic resonance imaging of the brain'),
(3, 3, 150.00, 'X-Ray', 'Radiography used to view the internal form of objects'),
(4, 4, 120.00, 'Vaccination', 'Administration of a vaccine'),
(5, 5, 130.00, 'Skin Allergy Test', 'Test for allergic reactions on the skin');

INSERT INTO InvoiceService (invoice_service_id, invoice_id, service_id, quantity)
VALUES
(1, 1, 1, 1),
(2, 2, 2, 2),
(3, 3, 3, 3),
(4, 4, 4, 1),
(5, 5, 5, 2);

INSERT INTO LabTech (lab_tech_id, first_name, last_name, gender, email_address, phone_number, department_id)
VALUES
(1, 'Liam', 'Gray', 'M', 'liamgray@example.com', '555-0300', 1),
(2, 'Sophia', 'Frost', 'F', 'sophiafrost@example.com', '555-0301', 2),
(3, 'Noah', 'Stone', 'M', 'noahstone@example.com', '555-0302', 3),
(4, 'Emma', 'River', 'F', 'emmariver@example.com', '555-0303', 4),
(5, 'Oliver', 'Lake', 'M', 'oliverlake@example.com', '555-0304', 5);

INSERT INTO LabReport (lab_report_id, doctor_id, patient_id, lab_tech_id, test_type, test_result, report_date, report_status)
VALUES
(1, 1, 1, 1, 'Blood Test', 'Normal', '2023-04-12', 'Complete'),
(2, 2, 2, 2, 'Urine Test', 'Abnormal', '2023-04-13', 'Pending'),
(3, 3, 3, 3, 'Biopsy', 'Benign', '2023-04-14', 'Cancelled'),
(4, 4, 4, 4, 'CT Scan', 'Normal', '2023-04-15', 'Complete'),
(5, 5, 5, 5, 'ECG', 'Irregular', '2023-04-16', 'Complete');






