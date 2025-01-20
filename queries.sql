0-- List of Blood Requests with Recipient and Blood Bank Details where requests are pending and urgency is ‘high’.
SELECT Recipient.Name AS RecipientName, Recipient.BloodGroup, BloodRequest.UnitsRequested, Recipient.RequestDate, 
       BloodBanks.Name AS BloodBankName, BloodBanks.Location
FROM BloodRequest
JOIN Recipient ON BloodRequest.RecipientID = Recipient.RecipientID
JOIN BloodBanks ON BloodRequest.BloodBankID = BloodBanks.BloodBankID
WHERE BloodRequest.Status = 'Pending'
AND Recipient.Urgency='high';

-- List of Donors whose BloodGroup is ‘O+’
select DonorID ,Name, DOB, Gender , BloodGroup , Contact from bloodbank.donor
where BloodGroup = 'O+'
ORDER BY Name;

-- List Donors with Blood Bank Details whose donation status was successful
SELECT Donor.Name AS DonorName, Donor.BloodGroup, BloodBanks.Name AS BloodBankName, BloodBanks.Location, Donation.DonationDate
FROM Donor
JOIN Donation ON Donor.DonorID = Donation.DonorID
JOIN BloodBanks ON Donation.BloodBankID = BloodBanks.BloodBankID
where Donation.StatusofDonation = 'successful'
ORDER BY Donation.DonationDate DESC;


-- List  Donors and Their Total Donations Count
SELECT Donor.Name, Donor.BloodGroup, COUNT(Donation.DonationID) AS TotalDonations
FROM Donor
JOIN Donation ON Donor.DonorID = Donation.DonorID
GROUP BY Donor.DonorID, Donor.Name, Donor.BloodGroup
ORDER BY TotalDonations DESC;


-- Find Blood Banks with Less Than a Specific Stock Level
SELECT BloodBanks.Name, BloodBanks.Location
FROM BloodBanks
WHERE BloodBankID IN (
    SELECT BloodBankID
    FROM BloodStock
    WHERE UnitsAvailable < 5
);

-- Blood Group-Wise Total Units Available Across All Blood Banks
SELECT BloodGroup, SUM(UnitsAvailable) AS TotalUnitsAvailable
FROM BloodStock
GROUP BY BloodGroup
ORDER BY TotalUnitsAvailable DESC;


-- Count of Donations Made by Blood Group
SELECT Donor.BloodGroup, COUNT(Donation.DonationID) AS TotalDonations
FROM Donation
JOIN Donor ON Donation.DonorID = Donor.DonorID
GROUP BY Donor.BloodGroup
ORDER BY TotalDonations DESC;
             
             
-- Register a new donor
INSERT INTO Bloodbank.Donor (Name, DOB, Gender, BloodGroup, Contact, EmergencyContact, Email, Address, City, PreferredDonationType, HealthConditions, Allergies, VaccinationStatus, Remarks) VALUES
('Aaravi Sharma', '1996-05-15', 'Female', 'O+', '9876675710', '9844444211', 'aaravI.sharma@example.com', '123 Sector 11', 'Chandigarh', 'Whole', 'None', 'None', 'Fully Vaccinated', 'Regular donor.');

-- Approve a Blood Request:
UPDATE BloodRequest 
SET Status = 'Approved' 
WHERE RequestID = 3;


-- Top 3 Blood Banks by Blood Availability
SELECT BloodBanks.Name, SUM(BloodStock.UnitsAvailable) AS TotalUnits
FROM BloodStock
JOIN BloodBanks ON BloodStock.BloodBankID = BloodBanks.BloodBankID
GROUP BY BloodBanks.Name
ORDER BY TotalUnits DESC
LIMIT 3;


-- Show Donors Aged 18-30
SELECT * FROM Bloodbank.Donor
WHERE TIMESTAMPDIFF(YEAR, dob, CURDATE()) BETWEEN 18 AND 30;

-- Give dates and bloodbanks information where donor has donated blood
SELECT DonationID, DonationDate, BloodBankID
FROM bloodbank.donation
WHERE DonorID = 1;

-- average age of donors
SELECT BloodGroup, AVG(TIMESTAMPDIFF(YEAR, DOB, CURDATE())) AS AvgAge
FROM Bloodbank.Donor
GROUP BY BloodGroup
ORDER BY AvgAge;

-- recipients waiting for approval
SELECT Recipient.Name, Recipient.RequestDate, BloodRequest.UnitsRequested, BloodRequest.BloodGroup, BloodBanks.Name AS BloodBankName
FROM BloodRequest
JOIN Recipient ON BloodRequest.RecipientID = Recipient.RecipientID
JOIN BloodBanks ON BloodRequest.BloodBankID = BloodBanks.BloodBankID
WHERE BloodRequest.Status = 'Pending';

-- Blood Group-Wise Average Units Requested Per Request
SELECT BloodRequest.BloodGroup, AVG(BloodRequest.UnitsRequested) AS AvgUnitsRequested
FROM BloodRequest
GROUP BY BloodRequest.BloodGroup
ORDER BY AvgUnitsRequested DESC;


-- Blood Requests That Have Been Pending for More Than 7 Days
SELECT Recipient.Name, Recipient.RequestDate, BloodRequest.UnitsRequested, BloodBanks.Name AS BloodBankName
FROM BloodRequest
JOIN Recipient ON BloodRequest.RecipientID = Recipient.RecipientID
JOIN BloodBanks ON BloodRequest.BloodBankID = BloodBanks.BloodBankID
WHERE BloodRequest.Status = 'Pending'
AND DATEDIFF(CURDATE(), Recipient.RequestDate) > 7;

-- Recipient Details for Emergency Blood Requests
SELECT Recipient.Name, BloodRequest.BloodGroup, BloodRequest.UnitsRequested, Recipient.RequestDate, 
       BloodBanks.Name AS BloodBankName, BloodBanks.Location
FROM BloodRequest
JOIN Recipient ON BloodRequest.RecipientID = Recipient.RecipientID
JOIN BloodBanks ON BloodRequest.BloodBankID = BloodBanks.BloodBankID
WHERE BloodRequest.Status = 'Pending'
AND Recipient.Urgency = 'High';

-- Number of Successful Donations Per Blood Bank
SELECT BloodBanks.Name, COUNT(Donation.DonationID) AS TotalDonations
FROM Donation
JOIN BloodBanks ON Donation.BloodBankID = BloodBanks.BloodBankID
WHERE Donation.StatusofDonation = 'successful'
GROUP BY BloodBanks.Name
ORDER BY TotalDonations DESC;

-- 
UPDATE BloodStock
SET UnitsAvailable = UnitsAvailable - 3
WHERE BloodBankID = 2
AND BloodGroup = 'A-'
AND UnitsAvailable >= 3;




