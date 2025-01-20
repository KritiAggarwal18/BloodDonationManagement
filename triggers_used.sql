DELIMITER //
CREATE TRIGGER check_age_before_insert
BEFORE INSERT ON Bloodbank.Donor
FOR EACH ROW
BEGIN
    IF (TIMESTAMPDIFF(YEAR, NEW.DOB, CURRENT_DATE()) < 18) THEN
        SIGNAL SQLSTATE '45000' 
        SET MESSAGE_TEXT = 'Donor must be at least 18 years old';
    END IF;
END//
DELIMITER ;


DELIMITER //
CREATE TRIGGER check_hb_before_insert
BEFORE INSERT ON BloodBank.Donation
FOR EACH ROW
BEGIN
    IF (NEW.HB < 12.5) THEN
        SET NEW.Statusofdonation = 'failed';
        SET NEW.DonationDate = NULL;  -- Ensuring DonationDate is NULL
        SET NEW.nexteligibledate = NULL;  -- Ensuring nexteligibledate is NULL
    END IF;
END//
DELIMITER ;


