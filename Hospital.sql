
CREATE TABLE Hospital (
  hospital_id INT PRIMARY KEY,
  h_name VARCHAR(50) NOT NULL,
  address VARCHAR(50), 
  phone_number VARCHAR(15)
);

CREATE TABLE Department (
  department_id INT PRIMARY KEY,
  hospital_id INT NOT NULL,
  d_name VARCHAR(30) NOT NULL, 
  FOREIGN KEY (hospital_id) REFERENCES Hospital(hospital_id)
);

CREATE TABLE Doctor (
  doctor_id INT PRIMARY KEY,
  department_id INT NOT NULL,
  doctor_name VARCHAR(50) NOT NULL,
  phone_number VARCHAR(15),
  start_working TIME,
  end_working TIME,
  FOREIGN KEY (department_id) REFERENCES Department(department_id)
);

CREATE TABLE Staff (
  staff_id INT PRIMARY KEY,
  department_id INT NOT NULL,
  s_name VARCHAR(30) NOT NULL,
  phone_number VARCHAR(15),
  FOREIGN KEY (department_id) REFERENCES Department(department_id)
);

CREATE TABLE Pharmacy (
  pharmacy_id INT PRIMARY KEY,
  ph_name VARCHAR(50) NOT NULL, 
  address VARCHAR(50),
  phone_number VARCHAR(15)
);

CREATE TABLE Patient (
  patient_id INT PRIMARY KEY,
  pharmacy_id INT NOT NULL,
  phone_number VARCHAR(15),
  f_name VARCHAR(20) NOT NULL, 
  l_name VARCHAR(20) NOT NULL, 
  FOREIGN KEY (pharmacy_id) REFERENCES Pharmacy(pharmacy_id)
);

CREATE TABLE Room (
  room_id INT PRIMARY KEY,
  patient_id INT UNIQUE,
  staff_id INT NOT NULL,
  admission_date DATE,
  FOREIGN KEY (patient_id) REFERENCES Patient(patient_id),
  FOREIGN KEY (staff_id) REFERENCES Staff(staff_id)
);

CREATE TABLE Prescription (
  prescription_id INT PRIMARY KEY,
  patient_id INT NOT NULL,
  medication_name VARCHAR(100),
  date_of_appointment DATE,
  FOREIGN KEY (patient_id) REFERENCES Patient(patient_id)
);

CREATE TABLE Invoice (
  invoice_id INT PRIMARY KEY,
  patient_id INT NOT NULL,
  description VARCHAR(100),
  cost DECIMAL(10,2), 
  FOREIGN KEY (patient_id) REFERENCES Patient(patient_id)
);

CREATE TABLE Appointment (
  appointment_id INT PRIMARY KEY,
  patient_id INT NOT NULL,
  doctor_id INT NOT NULL,
  date_time DATE,
  FOREIGN KEY (patient_id) REFERENCES Patient(patient_id),
  FOREIGN KEY (doctor_id) REFERENCES Doctor(doctor_id)
);


\dt

INSERT INTO Hospital (hospital_id, h_name, address, phone_number) VALUES
(1, 'Houston Medical Center', '123 Medical Dr, Houston, Texas', '5557777'),
(2, 'Austin Regional Hospital', '456 Oak St, Austin, Texas', '5558888'),
(3, 'New York Presbyterian Hospital', '789 Park Ave, New York, NY', '5559999');


INSERT INTO Department (department_id, hospital_id, d_name) VALUES
(101, 1, 'Cardiology'),
(102, 1, 'Orthopedics'),
(103, 2, 'Pediatrics');


INSERT INTO Doctor (doctor_id, department_id, doctor_name, phone_number, start_working, end_working) VALUES
(201, 101, 'Dr. Smith', '5551111', '09:00:00', '17:00:00'),
(202, 102, 'Dr. Johnson', '5552222', '10:30:00', '18:30:00');


INSERT INTO Staff (staff_id, department_id, s_name, phone_number) VALUES
(301, 103, 'Nurse Davis', 5553333),
(302, 101, 'Admin Assistant', 5554444);


INSERT INTO Pharmacy (pharmacy_id, ph_name, address, phone_number) VALUES
(1, 'Pharmacy', '789 Elm St', 5557777),
(2, 'Pharmacy2', '890 Pine Ave', 5558888);


INSERT INTO Patient (patient_id, pharmacy_id, phone_number, f_name, l_name) VALUES
(401, 1, 5555555, 'John', 'Doe'),
(402, 2, 5556666, 'Jane', 'Smith');


INSERT INTO Room (room_id, patient_id, staff_id, admission_date) VALUES
(501, 401, 301, '2024-02-05'),
(502, 402, 302, '2024-02-06');


INSERT INTO Prescription (prescription_id, patient_id, medication_name, date_of_appointment) VALUES
(601, 401, 'Aspirin', '2024-02-07'),
(602, 402, 'Antibiotics', '2024-02-08');


INSERT INTO Invoice (invoice_id, patient_id, description, cost) VALUES
(701, 401, 'Covid', '45.00'),
(702, 402, 'Heart surgery', '100.00');


INSERT INTO Appointment (appointment_id, patient_id, doctor_id, date_time) VALUES
(801, 401, 201, '2024-02-10 14:00:00'),
(802, 402, 202, '2024-02-11 15:30:00');

