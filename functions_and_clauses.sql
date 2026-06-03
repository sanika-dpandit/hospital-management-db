-- Using LOWER() to find doctors with email addresses containing 'gmail'
SELECT *
FROM Doctor
WHERE LOWER(email_address) LIKE '%gmail%';

-- Finding the length of last names of patients
SELECT last_name, LENGTH(last_name) AS name_length
FROM Patient;

-- Using CONCAT() to combine first name and last name of doctors
SELECT CONCAT(first_name, ' ', last_name) AS full_name
FROM Doctor;

-- Finding the minimum and maximum appointment dates
SELECT MIN(appointment_date) AS min_date, MAX(appointment_date) AS max_date
FROM Appointment;


-- Calculating the total cost of services for each invoice
SELECT InS.invoice_id, SUM(S.cost * InS.quantity) AS total_cost
FROM InvoiceService InS
JOIN Service S ON InS.service_id = S.service_id
GROUP BY InS.invoice_id;


-- Counting the number of appointments per doctor and ordering the result by the count
SELECT doctor_id, COUNT(*) AS appointment_count
FROM Appointment
GROUP BY doctor_id
ORDER BY appointment_count DESC;

-- Finding the average cost of services for each department, only including departments with an average cost greater than 100
SELECT department_id, AVG(cost) AS avg_cost
FROM Service
GROUP BY department_id
HAVING avg_cost > 100;