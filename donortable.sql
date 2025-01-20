create database Bloodbank;
use bloodbank
CREATE TABLE Bloodbank.Donor (
    DonorID INT PRIMARY KEY AUTO_INCREMENT,
    Name VARCHAR(30) NOT NULL,
    DOB DATE,
    Gender ENUM('Male', 'Female', 'Other'),
    BloodGroup varchar(3) NOT NULL,
    Contact VARCHAR(15),
    EmergencyContact VARCHAR(15),
    email VARCHAR(100),  
    Address VARCHAR(100),
    City Varchar(20),
    PreferredDonationType ENUM('Whole', 'Plasma', 'Platelets', 'RBC', 'WBC'), 
    HealthConditions TEXT,
    Allergies TEXT,
    VaccinationStatus varchar(30) not null,
    Remarks TEXT
   );
   

CREATE TABLE Bloodbank.Recipient (
    RecipientID INT PRIMARY KEY AUTO_INCREMENT,
    Name VARCHAR(50) NOT NULL,    
    DOB DATE,
    BloodGroup VARCHAR(3) NOT NULL,
    ContactDetails VARCHAR(15),   
    EmergencyContact VARCHAR(15), 
    Urgency ENUM('low','med','high'),
    RequestStatus ENUM('Pending', 'Fulfilled', 'Cancelled') DEFAULT 'Pending', 
    Gender ENUM('Male', 'Female', 'Other'),   
    Address VARCHAR(100),  
    City VARCHAR(30),
    MedicalCondition TEXT,                    
    BloodUnitsRequired INT,                   
    RequestDate DATE
);

CREATE TABLE BloodBank.Bloodbanks (
    BloodBankID INT PRIMARY KEY AUTO_INCREMENT,
    Name VARCHAR(50),
    Location VARCHAR(50),
    City VARCHAR(30),
    ContactDetails VARCHAR(15),
    email varchar(40),
    bloodbanktype enum('Gov','Private','NGO')
);

CREATE TABLE BloodBank.BloodStock (
    StockID INT PRIMARY KEY AUTO_INCREMENT,
    BloodGroup VARCHAR(3),
    UnitsAvailable INT,
    BloodBankID INT,
    collectiondate date,
    expirydate date,
    BloodComponentType ENUM('Whole', 'Plasma', 'Platelets', 'RBC','WBC'),
    FOREIGN KEY (BloodBankID) REFERENCES BloodBanks(BloodBankID)
);
CREATE TABLE BloodBank.Donation (
    DonationID INT PRIMARY KEY AUTO_INCREMENT,
    DonorID INT,
    BloodBankID INT,
	Weight DECIMAL(5,2), -- Weight in kilograms
    HB DECIMAL(4,2), -- Hemoglobin level in g/dL
    Statusofdonation ENUM('successful','failed'),
    DonationDate DATE,
    nexteligibledate DATE,
    FOREIGN KEY (DonorID) REFERENCES Donor(DonorID),
    FOREIGN KEY (BloodBankID) REFERENCES BloodBanks(BloodBankID)
);
CREATE TABLE BloodBank.BloodRequest (
    RequestID INT PRIMARY KEY AUTO_INCREMENT,
    RecipientID INT,
    BloodBankID INT,
    BloodGroup VARCHAR(3),
    UnitsRequested INT,
    RequestDate DATE,
    Status VARCHAR(20),
    FOREIGN KEY (RecipientID) REFERENCES Recipient(RecipientID),
    FOREIGN KEY (BloodBankID) REFERENCES BloodBanks(BloodBankID)
);

ALTER TABLE Bloodbank.bloodrequest
DROP COLUMN requestdate;

INSERT INTO Bloodbank.Donor (Name, DOB, Gender, BloodGroup, Contact, EmergencyContact, Email, Address, City, PreferredDonationType, 
HealthConditions, Allergies, VaccinationStatus, Remarks) VALUES
('Aarav Sharma', '1990-05-15', 'Male', 'A+', '9876543210', '9876543211', 'aarav.sharma@example.com', '123 Sector 1', 'Chandigarh', 'Whole', 'None', 'None', 'Fully Vaccinated', 'Regular donor.'),
('Vivaan Gupta', '1988-02-20', 'Male', 'B-', '9876543212', '9876543213', 'vivaan.gupta@example.com', '456 Sector 2', 'Chandigarh', 'Plasma', 'Asthma', 'Peanuts', 'Fully Vaccinated', 'Has asthma but regular donor.'),
('Anaya Singh', '1992-09-25', 'Female', 'O+', '9876543214', '9876543215', 'anaya.singh@example.com', '789 Sector 3', 'Chandigarh', 'Platelets', 'None', 'None', 'Fully Vaccinated', 'New donor.'),
('Reyansh Patel', '1991-12-10', 'Male', 'AB+', '9876543216', '9876543217', 'reyansh.patel@example.com', '135 Sector 4', 'Chandigarh', 'RBC', 'Hypertension', 'None', 'Fully Vaccinated', 'Medication for hypertension.'),
('Aadhya Verma', '1995-04-05', 'Female', 'B+', '9876543218', '9876543219', 'aadhya.verma@example.com', '246 Sector 5', 'Chandigarh', 'Whole', 'None', 'None', 'Fully Vaccinated', 'Healthy donor.'),
('Arjun Iyer', '1990-07-30', 'Male', 'O-', '9876543220', '9876543221', 'arjun.iyer@example.com', '357 Sector 6', 'Chandigarh', 'Plasma', 'Diabetes', 'None', 'Fully Vaccinated', 'Well controlled diabetes.'),
('Saanvi Joshi', '1993-03-15', 'Female', 'A-', '9876543222', '9876543223', 'saanvi.joshi@example.com', '468 Sector 7', 'Chandigarh', 'Platelets', 'None', 'None', 'Fully Vaccinated', 'Regular donor.'),
('Siddharth Rao', '1991-11-11', 'Male', 'AB-', '9876543224', '9876543225', 'siddharth.rao@example.com', '579 Sector 8', 'Chandigarh', 'RBC', 'None', 'None', 'Fully Vaccinated', 'Active in community service.'),
('Diya Kapoor', '1985-06-18', 'Female', 'O+', '9876543226', '9876543227', 'diya.kapoor@example.com', '680 Sector 9', 'Chandigarh', 'Whole', 'Thyroid', 'None', 'Fully Vaccinated', 'Regular check-ups.'),
('Krishna Mehta', '1989-08-01', 'Male', 'B+', '9876543228', '9876543229', 'krishna.mehta@example.com', '791 Sector 10', 'Chandigarh', 'Plasma', 'None', 'None', 'Fully Vaccinated', 'Passionate about helping others.'),
('Nisha Nair', '1994-10-30', 'Female', 'AB+', '9876543230', '9876543231', 'nisha.nair@example.com', '902 Sector 11', 'Chandigarh', 'Platelets', 'Allergy to dust', 'None', 'Fully Vaccinated', 'Careful about allergies.'),
('Rahul Choudhary', '1992-01-15', 'Male', 'O-', '9876543232', '9876543233', 'rahul.choudhary@example.com', '321 Sector 12', 'Chandigarh', 'RBC', 'None', 'None', 'Fully Vaccinated', 'Regular donor, fit and healthy.'),
('Riya Sethi', '1987-03-28', 'Female', 'A+', '9876543234', '9876543235', 'riya.sethi@example.com', '654 Sector 13', 'Chandigarh', 'Whole', 'None', 'None', 'Fully Vaccinated', 'Donates every six months.'),
('Karan Singh', '1996-07-04', 'Male', 'B-', '9876543236', '9876543237', 'karan.singh@example.com', '852 Sector 14', 'Chandigarh', 'Plasma', 'None', 'None', 'Fully Vaccinated', 'Promotes blood donation.'),
('Pooja Sharma', '1995-12-12', 'Female', 'O+', '9876543238', '9876543239', 'pooja.sharma@example.com', '963 Sector 15', 'Chandigarh', 'Platelets', 'None', 'None', 'Fully Vaccinated', 'First-time donor.'),
('Ajay Kumar', '1998-05-20', 'Male', 'AB-', '9876543240', '9876543241', 'ajay.kumar@example.com', '147 Sector 16', 'Chandigarh', 'RBC', 'None', 'None', 'Fully Vaccinated', 'Encourages peers to donate.'),
('Neha Rani', '1983-09-09', 'Female', 'A+', '9876543242', '9876543243', 'neha.rani@example.com', '258 Sector 17', 'Chandigarh', 'Whole', 'None', 'None', 'Fully Vaccinated', 'Community volunteer.'),
('Rohit Sharma', '1990-11-22', 'Male', 'O+', '9876543244', '9876543245', 'rohit.sharma@example.com', '369 Sector 18', 'Chandigarh', 'Plasma', 'None', 'None', 'Fully Vaccinated', 'Active participant in health camps.'),
('Divya Gupta', '1995-06-01', 'Female', 'B-', '9876543246', '9876543247', 'divya.gupta@example.com', '159 Sector 19', 'Chandigarh', 'Platelets', 'Allergy to pollen', 'None', 'Fully Vaccinated', 'Seasonal allergies.'),
('Mohit Singh', '1988-03-15', 'Male', 'AB+', '9876543248', '9876543249', 'mohit.singh@example.com', '753 Sector 20', 'Chandigarh', 'RBC', 'None', 'None', 'Fully Vaccinated', 'Loves volunteering.'),
('Anjali Verma', '1992-01-05', 'Female', 'O-', '9876543250', '9876543251', 'anjali.verma@example.com', '951 Sector 21', 'Chandigarh', 'Whole', 'None', 'None', 'Fully Vaccinated', 'Regular contributor to social causes.'),
('Pranav Joshi', '1991-04-10', 'Male', 'B+', '9876543252', '9876543253', 'pranav.joshi@example.com', '753 Sector 22', 'Chandigarh', 'Plasma', 'Hypertension', 'None', 'Fully Vaccinated', 'Maintains healthy lifestyle.'),
('Priti Nair', '1993-08-08', 'Female', 'A-', '9876543254', '9876543255', 'priti.nair@example.com', '159 Sector 23', 'Chandigarh', 'Platelets', 'None', 'None', 'Fully Vaccinated', 'Active in local charities.'),
('Vikram Yadav', '1985-12-15', 'Male', 'AB-', '9876543256', '9876543257', 'vikram.yadav@example.com', '321 Sector 24', 'Chandigarh', 'RBC', 'None', 'None', 'Fully Vaccinated', 'Engaged in community service.'),
('Shreya Mehta', '1994-09-25', 'Female', 'O+', '9876543258', '9876543259', 'shreya.mehta@example.com', '654 Sector 25', 'Chandigarh', 'Whole', 'None', 'None', 'Fully Vaccinated', 'Encourages blood donation drives.'),
('Siddharth Agarwal', '1990-03-18', 'Male', 'B+', '9876543260', '9876543261', 'siddharth.agarwal@example.com', '987 Sector 26', 'Chandigarh', 'Plasma', 'None', 'None', 'Fully Vaccinated', 'Donates frequently.'),
('Ruchi Bansal', '1995-06-22', 'Female', 'A-', '9876543262', '9876543263', 'ruchi.bansal@example.com', '321 Sector 27', 'Chandigarh', 'Platelets', 'Allergy to nuts', 'None', 'Fully Vaccinated', 'Promotes awareness about blood donation.'),
('Karan Verma', '1992-10-01', 'Male', 'O-', '9876543264', '9876543265', 'karan.verma@example.com', '654 Sector 28', 'Chandigarh', 'RBC', 'None', 'None', 'Fully Vaccinated', 'Supports local health initiatives.'),
('Komal Rathi', '1989-04-11', 'Female', 'B+', '9876543266', '9876543267', 'komal.rathi@example.com', '987 Sector 29', 'Chandigarh', 'Whole', 'None', 'None', 'Fully Vaccinated', 'Volunteer in health camps.'),
('Gaurav Kapoor', '1990-05-30', 'Male', 'AB-', '9876543268', '9876543269', 'gaurav.kapoor@example.com', '123 Sector 30', 'Chandigarh', 'Plasma', 'None', 'None', 'Fully Vaccinated', 'Active in blood donation awareness.'),
('Meera Chaudhary', '1994-07-20', 'Female', 'O+', '9876543270', '9876543271', 'meera.chaudhary@example.com', '456 Sector 31', 'Chandigarh', 'Platelets', 'Allergy to dust', 'None', 'Fully Vaccinated', 'Supports community health drives.'),
('Rajesh Yadav', '1985-09-15', 'Male', 'B-', '9876543272', '9876543273', 'rajesh.yadav@example.com', '789 Sector 32', 'Chandigarh', 'RBC', 'None', 'None', 'Fully Vaccinated', 'Encourages youth to donate.'),
('Sonia Sharma', '1991-11-10', 'Female', 'AB+', '9876543274', '9876543275', 'sonia.sharma@example.com', '321 Sector 33', 'Chandigarh', 'Whole', 'None', 'None', 'Fully Vaccinated', 'Regular donor with good health.'),
('Anushka Jain', '1993-03-05', 'Female', 'O-', '9876543276', '9876543277', 'anushka.jain@example.com', '654 Sector 34', 'Chandigarh', 'Plasma', 'None', 'None', 'Fully Vaccinated', 'Actively promotes blood donation.'),
('Harsh Patel', '1988-02-28', 'Male', 'A+', '9876543278', '9876543279', 'harsh.patel@example.com', '789 Sector 35', 'Chandigarh', 'Platelets', 'None', 'None', 'Fully Vaccinated', 'Regularly donates plasma.'),
('Nandini Rani', '1990-07-07', 'Female', 'B+', '9876543280', '9876543281', 'nandini.rani@example.com', '123 Sector 36', 'Chandigarh', 'Whole', 'Hypertension', 'None', 'Fully Vaccinated', 'Controlled hypertension, healthy otherwise.'),
('Aarav Kapoor', '1995-10-18', 'Male', 'AB-', '9876543282', '9876543283', 'aarav.kapoor@example.com', '456 Sector 37', 'Chandigarh', 'RBC', 'None', 'None', 'Fully Vaccinated', 'Community health activist.'),
('Tanya Choudhary', '1986-01-12', 'Female', 'O+', '9876543284', '9876543285', 'tanya.choudhary@example.com', '789 Sector 38', 'Chandigarh', 'Plasma', 'None', 'None', 'Fully Vaccinated', 'Involved in health campaigns.'),
('Rohan Gupta', '1994-12-05', 'Male', 'B-', '9876543286', '9876543287', 'rohan.gupta@example.com', '321 Sector 39', 'Chandigarh', 'Platelets', 'None', 'None', 'Fully Vaccinated', 'Regular contributor to blood banks.'),
('Isha Rathi', '1993-05-23', 'Female', 'A-', '9876543288', '9876543289', 'isha.rathi@example.com', '654 Sector 40', 'Chandigarh', 'RBC', 'None', 'None', 'Fully Vaccinated', 'Promotes health awareness in schools.');

INSERT INTO Bloodbank.Recipient (Name, DOB, BloodGroup, ContactDetails, EmergencyContact, Urgency, RequestStatus, 
Gender, Address, City, MedicalCondition, BloodUnitsRequired, RequestDate) VALUES
('Aarav Sharma', '1988-05-15', 'A+', '9876543210', '9876543211', 'high', 'Pending', 'Male', '123 Sector 1', 'Chandigarh', 'Anemia', 2, '2024-10-01'),
('Saanvi Gupta', '1990-04-20', 'B-', '9876543212', '9876543213', 'med', 'Pending', 'Female', '456 Sector 2', 'Chandigarh', 'Thalassemia', 3, '2024-10-02'),
('Arjun Iyer', '1985-12-10', 'O+', '9876543214', '9876543215', 'low', 'Pending', 'Male', '789 Sector 3', 'Chandigarh', 'Post-surgery recovery', 1, '2024-10-03'),
('Diya Patel', '1992-09-25', 'AB+', '9876543216', '9876543217', 'high', 'Pending', 'Female', '135 Sector 4', 'Chandigarh', 'Cancer treatment', 5, '2024-10-04'),
('Reyansh Verma', '1993-06-30', 'B+', '9876543218', '9876543219', 'med', 'Pending', 'Male', '246 Sector 5', 'Chandigarh', 'Severe injuries from an accident', 4, '2024-10-05'),
('Ananya Joshi', '1991-03-15', 'O-', '9876543220', '9876543221', 'high', 'Pending', 'Female', '357 Sector 6', 'Chandigarh', 'Pregnancy complications', 2, '2024-10-06'),
('Karan Yadav', '1994-08-12', 'A-', '9876543222', '9876543223', 'med', 'Pending', 'Male', '468 Sector 7', 'Chandigarh', 'Kidney failure', 6, '2024-10-07'),
('Neha Rani', '1996-11-01', 'B+', '9876543224', '9876543225', 'low', 'Pending', 'Female', '579 Sector 8', 'Chandigarh', 'Sickle cell anemia', 3, '2024-10-08'),
('Rohan Singh', '1987-10-18', 'AB-', '9876543226', '9876543227', 'high', 'Pending', 'Male', '680 Sector 9', 'Chandigarh', 'Heart surgery', 4, '2024-10-09'),
('Pooja Sharma', '1995-05-25', 'O+', '9876543228', '9876543229', 'med', 'Pending', 'Female', '791 Sector 10', 'Chandigarh', 'Bone marrow transplant', 5, '2024-10-10'),
('Krishna Nair', '1991-02-14', 'A+', '9876543230', '9876543231', 'low', 'Pending', 'Male', '902 Sector 11', 'Chandigarh', 'Liver cirrhosis', 2, '2024-10-11'),
('Shreya Mehta', '1989-01-29', 'B-', '9876543232', '9876543233', 'high', 'Pending', 'Female', '321 Sector 12', 'Chandigarh', 'Severe anemia', 3, '2024-10-12'),
('Siddharth Agarwal', '1990-03-18', 'O-', '9876543234', '9876543235', 'med', 'Pending', 'Male', '654 Sector 13', 'Chandigarh', 'Thyroid issues', 2, '2024-10-13'),
('Aadhya Kapoor', '1992-12-07', 'AB+', '9876543236', '9876543237', 'low', 'Pending', 'Female', '987 Sector 14', 'Chandigarh', 'Dengue', 3, '2024-10-14'),
('Vikram Joshi', '1988-07-22', 'B+', '9876543238', '9876543239', 'high', 'Pending', 'Male', '147 Sector 15', 'Chandigarh', 'Thalassemia', 4, '2024-10-15'),
('Meera Choudhary', '1996-11-30', 'A-', '9876543240', '9876543241', 'med', 'Pending', 'Female', '258 Sector 16', 'Chandigarh', 'Surgery recovery', 2, '2024-10-16'),
('Rahul Gupta', '1991-09-09', 'O+', '9876543242', '9876543243', 'low', 'Pending', 'Male', '369 Sector 17', 'Chandigarh', 'Post-surgery', 3, '2024-10-17'),
('Ritika Rani', '1993-03-28', 'B-', '9876543244', '9876543245', 'high', 'Pending', 'Female', '951 Sector 18', 'Chandigarh', 'Leukemia treatment', 5, '2024-10-18'),
('Ajay Kumar', '1985-08-19', 'AB-', '9876543246', '9876543247', 'med', 'Pending', 'Male', '753 Sector 19', 'Chandigarh', 'Lung cancer', 6, '2024-10-19'),
('Tanya Verma', '1995-10-10', 'O+', '9876543248', '9876543249', 'low', 'Pending', 'Female', '951 Sector 20', 'Chandigarh', 'Blood clotting disorder', 2, '2024-10-20'),
('Raghav Singh', '1990-06-01', 'A+', '9876543250', '9876543251', 'high', 'Pending', 'Male', '852 Sector 21', 'Chandigarh', 'Severe injuries', 4, '2024-10-21'),
('Isha Sharma', '1994-12-05', 'B+', '9876543252', '9876543253', 'med', 'Pending', 'Female', '963 Sector 22', 'Chandigarh', 'Pneumonia', 3, '2024-10-22'),
('Anushka Jain', '1989-01-18', 'O-', '9876543254', '9876543255', 'low', 'Pending', 'Female', '147 Sector 23', 'Chandigarh', 'Complications in pregnancy', 2, '2024-10-23'),
('Karan Yadav', '1995-03-21', 'AB+', '9876543256', '9876543257', 'high', 'Pending', 'Male', '258 Sector 24', 'Chandigarh', 'Acute renal failure', 5, '2024-10-24'),
('Siddharth Rathi', '1991-07-13', 'B-', '9876543258', '9876543259', 'med', 'Pending', 'Male', '369 Sector 25', 'Chandigarh', 'Heart condition', 3, '2024-10-25'),
('Prisha Singh', '1987-05-06', 'O+', '9876543260', '9876543261', 'low', 'Pending', 'Female', '987 Sector 26', 'Chandigarh', 'Multiple injuries', 4, '2024-10-26'),
('Aarav Kapoor', '1992-08-29', 'A-', '9876543262', '9876543263', 'high', 'Pending', 'Male', '654 Sector 27', 'Chandigarh', 'Cancer treatment', 6, '2024-10-27'),
('Megha Nair', '1993-04-18', 'AB+', '9876543264', '9876543265', 'med', 'Pending', 'Female', '852 Sector 28', 'Chandigarh', 'Surgical procedure', 2, '2024-10-28'),
('Karthik Kumar', '1996-10-30', 'B-', '9876543266', '9876543267', 'low', 'Pending', 'Male', '963 Sector 29', 'Chandigarh', 'Blood transfusion', 3, '2024-10-29'),
('Shruti Verma', '1989-06-15', 'O+', '9876543268', '9876543269', 'high', 'Pending', 'Female', '147 Sector 30', 'Chandigarh', 'Organ transplant', 4, '2024-10-30'),
('Rohan Joshi', '1990-12-24', 'A+', '9876543270', '9876543271', 'med', 'Pending', 'Male', '258 Sector 31', 'Chandigarh', 'Accident recovery', 3, '2024-10-31'),
('Poonam Rani', '1992-11-02', 'AB-', '9876543272', '9876543273', 'low', 'Pending', 'Female', '369 Sector 32', 'Chandigarh', 'Chronic illness', 2, '2024-11-01'),
('Tanvi Gupta', '1994-08-11', 'O+', '9876543274', '9876543275', 'high', 'Pending', 'Female', '456 Sector 33', 'Chandigarh', 'Severe blood loss', 5, '2024-11-02'),
('Siddharth Iyer', '1988-03-27', 'B-', '9876543276', '9876543277', 'med', 'Pending', 'Male', '789 Sector 34', 'Chandigarh', 'Kidney transplant', 6, '2024-11-03'),
('Anjali Chaudhary', '1995-05-17', 'A+', '9876543278', '9876543279', 'low', 'Pending', 'Female', '123 Sector 35', 'Chandigarh', 'Malaria', 3, '2024-11-04');

INSERT INTO BloodBank.Bloodbanks (Name, Location, City, ContactDetails, email, bloodbanktype) VALUES
('PGIMER Blood Bank', 'Nehru Hospital, Sector 12', 'Chandigarh', '0172-2756481', 'bloodbank@pgimer.edu.in', 'Gov'),
('Rotary Blood Bank', 'Plot No. 4, Dakshin Marg, Sector 37A', 'Chandigarh', '0172-2696057', 'info@rotarybloodbankchd.org', 'NGO'),
('Government Medical College and Hospital Blood Bank', 'Sector 32', 'Chandigarh', '0172-22601023', 'gmcchd@gmail.com', 'Gov'),
('Government Multispeciality Hospital Blood Bank', 'Sector 16', 'Chandigarh', '0172-2701288', 'gmhchd@gmail.com', 'Gov'),
('Fortis Hospital Blood Bank', 'Sector 62', 'Mohali', '0172-5095555', 'info@fortishealthcare.com', 'Private'),
('Max Super Specialty Hospital Blood Bank', 'Sector 19', 'Mohali', '0172-5099000', 'info@maxhealthcare.com', 'Private'),
('Jain Blood Bank', 'Sector 20', 'Chandigarh', '0172-2720647', 'jainbloodbank@gmail.com', 'Private'),
('Mediwell Blood Bank', 'Mandi Gobindgarh, near Chandigarh', 'Punjab', '01763-228717', 'mediwellbloodbank@gmail.com', 'Private'),
('Sunrise Hospital Blood Bank', 'Sector 70, Mohali', 'Mohali', '0172-5070707', 'info@sunrisehospital.in', 'Private'),
('Indira Gandhi Medical College Blood Bank', 'Sector 19, Chandigarh', 'Chandigarh', '0172-2740540', 'igmcchd@gmail.com', 'Gov');

-- Inserting entries for blood banks in Tricity
INSERT INTO BloodBank.Bloodbanks (Name, Location, City, ContactDetails, email, bloodbanktype)
VALUES 
('Alchemist Hospital Blood Bank', 'Sector 21', 'Panchkula', '01722561536', 'info@alchemisthospital.com', 'Private'),
('Ivy Health and Life Sciences Blood Bank', 'Sector 71', 'Mohali', '01727170121', 'info@ivyhospital.com', 'Private');


INSERT INTO BloodBank.BloodStock (BloodGroup, UnitsAvailable, BloodBankID, CollectionDate, ExpiryDate, BloodComponentType) VALUES
('A+', 15, 1, '2024-10-01', '2025-04-01', 'Whole'),
('B+', 10, 1, '2024-10-02', '2025-04-02', 'Plasma'),
('O-', 8, 1, '2024-10-03', '2025-04-03', 'Platelets'),
('AB+', 12, 2, '2024-10-04', '2025-04-04', 'RBC'),
('A-', 20, 2, '2024-10-05', '2025-04-05', 'Whole'),
('B-', 5, 3, '2024-10-06', '2025-04-06', 'WBC'),
('O+', 30, 3, '2024-10-07', '2025-04-07', 'Plasma'),
('AB-', 18, 4, '2024-10-08', '2025-04-08', 'Platelets'),
('A+', 25, 4, '2024-10-09', '2025-04-09', 'RBC'),
('O-', 10, 5, '2024-10-10', '2025-04-10', 'Whole'),
('B+', 22, 5, '2024-10-11', '2025-04-11', 'Plasma'),
('AB+', 14, 6, '2024-10-12', '2025-04-12', 'Platelets'),
('A-', 17, 6, '2024-10-13', '2025-04-13', 'RBC'),
('B-', 8, 7, '2024-10-14', '2025-04-14', 'WBC'),
('O+', 19, 7, '2024-10-15', '2025-04-15', 'Plasma'),
('AB-', 16, 8, '2024-10-16', '2025-04-16', 'Platelets'),
('A+', 11, 8, '2024-10-17', '2025-04-17', 'RBC'),
('O-', 9, 9, '2024-10-18', '2025-04-18', 'Whole'),
('B+', 13, 9, '2024-10-19', '2025-04-19', 'Plasma'),
('AB+', 6, 10, '2024-10-20', '2025-04-20', 'Platelets'),
('A-', 4, 10, '2024-10-21', '2025-04-21', 'RBC');


INSERT INTO BloodBank.Donation (DonorID, BloodBankID, Weight, HB, StatusofDonation, DonationDate, NextEligibleDate) VALUES
(1, 1, 70.00, 14.5, 'successful', '2024-10-01', '2025-01-01'),
(2, 1, 68.50, 11.8, 'failed', NULL, NULL),
(3, 2, 75.00, 15.0, 'successful', '2024-10-02', '2025-01-02'),
(4, 3, 65.00, 12.0, 'failed', NULL, NULL),
(5, 4, 80.00, 14.2, 'successful', '2024-10-01', '2025-01-01'),
(6, 5, 58.50, 12.3, 'failed', NULL, NULL),
(7, 6, 72.00, 14.0, 'successful', '2024-10-03', '2025-01-03'),
(8, 7, 82.00, 15.5, 'successful', '2024-10-01', '2025-01-01'),
(9, 8, 69.00, 13.0, 'successful', '2024-10-01', '2025-01-01'),
(10, 9, 77.50, 11.5, 'failed', NULL, NULL),
(11, 1, 65.50, 12.9, 'failed', NULL, NULL),
(12, 2, 70.00, 14.1, 'successful', '2024-10-01', '2025-01-01'),
(13, 3, 74.00, 14.8, 'successful', '2024-10-04', '2025-01-04'),
(14, 4, 69.50, 13.5, 'successful', '2024-10-01', '2025-01-01'),
(15, 5, 71.00, 11.0, 'failed', NULL, NULL),
(16, 6, 78.00, 15.2, 'successful', '2024-10-01', '2025-01-01'),
(17, 7, 64.00, 13.3, 'successful', '2024-10-05', '2025-01-05'),
(18, 8, 68.00, 12.1, 'failed', NULL, NULL),
(19, 9, 73.00, 14.6, 'successful', '2024-10-01', '2025-01-01'),
(20, 10, 76.00, 14.0, 'successful', '2024-10-01', '2025-01-01');

INSERT INTO BloodBank.BloodRequest (RecipientID, BloodBankID, BloodGroup, UnitsRequested, Status) VALUES
(1, 1, 'A+', 2, 'Pending'),
(2, 1, 'B-', 1, 'Pending'),
(3, 2, 'O+', 3, 'Pending'),
(4, 2, 'AB+', 1, 'Pending'),
(5, 3, 'A-', 2, 'Pending'),
(6, 3, 'O-', 2, 'Pending'),
(7, 4, 'B+', 1, 'Pending'),
(8, 4, 'A+', 3, 'Pending'),
(9, 5, 'AB-', 2, 'Pending'),
(10, 5, 'B+', 4, 'Pending'),
(11, 6, 'A-', 1, 'Pending'),
(12, 6, 'O+', 3, 'Pending'),
(13, 7, 'AB+', 2, 'Pending'),
(14, 7, 'B-', 1, 'Pending'),
(15, 8, 'A+', 2, 'Pending'),
(16, 8, 'O-', 2, 'Pending'),
(17, 9, 'B+', 1, 'Pending'),
(18, 9, 'A+', 3, 'Pending'),
(19, 10, 'AB-', 2, 'Pending'),
(20, 10, 'B+', 1, 'Pending'),
(21, 1, 'O-', 3, 'Pending'),
(22, 2, 'A+', 2, 'Pending'),
(23, 3, 'B-', 1, 'Pending'),
(24, 4, 'O+', 1, 'Pending'),
(25, 5, 'A-', 3, 'Pending'),
(26, 6, 'AB+', 2, 'Pending'),
(27, 7, 'B+', 4, 'Pending'),
(28, 8, 'A+', 1, 'Pending'),
(29, 9, 'AB-', 2, 'Pending'),
(30, 10, 'B+', 3, 'Pending');




