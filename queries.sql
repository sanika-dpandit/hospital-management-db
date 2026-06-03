-- Selecting all doctors who have scheduled appointments
SELECT *
FROM Doctor
WHERE EXISTS (
        SELECT *
        FROM Appointment
        WHERE Doctor.doctor_id = Appointment.doctor_id
            AND appointment_status = 'Scheduled'
    );
 -- Selecting doctors where their email address is not null and their last name starts with 'S'
SELECT *
FROM Doctor
WHERE email_address IS NOT NULL
AND last_name LIKE 'S%';

-- Deleting appointments marked as 'Cancelled' or 'No-show'
DELETE FROM Appointment
WHERE appointment_status IN ('Cancelled', 'No-show');

-- Updating the status of unpaid invoices to 'Pending'
UPDATE Invoice
SET status = 'Pending'
WHERE status = 'Unpaid';

-- Finding patients with appointments with specific doctors
SELECT *
FROM Patient
WHERE patient_id IN (
        SELECT patient_id
        FROM Appointment
        WHERE doctor_id IN (1, 2, 3)  -- IDs of specific doctors
    );
    
-- Retrieving patients with either scheduled appointments or unpaid invoices
SELECT patient_id, first_name, last_name
FROM Patient
WHERE patient_id IN (
        SELECT patient_id
        FROM Appointment
        WHERE appointment_status = 'Scheduled'
    )
UNION
SELECT patient_id, first_name, last_name
FROM Patient
WHERE patient_id IN (
        SELECT patient_id
        FROM Invoice
        WHERE status = 'Unpaid'
    );


