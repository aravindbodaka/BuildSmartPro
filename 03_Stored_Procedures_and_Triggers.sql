-- STORED PROCEDURES

-- 1.) This procedure calculates and updates the total invoiced amount for a specific project.
DELIMITER //
create procedure UpdateProjectInvoicedAmount(in projectID varchar(10))
begin
    update Projects
    set Budget = (select sum(Amount) from Invoices where ProjectID = projectID)
    where ProjectID = projectID;
end //
DELIMITER ;

/*SELECT ProjectID, Budget FROM Projects WHERE ProjectID = 'P101';
SELECT ProjectID, SUM(Amount) AS TotalInvoiced FROM Invoices WHERE ProjectID = 'P101';

UPDATE Invoices
SET Amount = Amount+500
WHERE InvoiceID = 'INV101' AND ProjectID = 'P101';

CALL UpdateProjectInvoicedAmount('P101');

*/

-- 2.) This procedure marks invoices as overdue if their due date has passed and they are not yet paid.
DELIMITER //
create procedure MarkOverdueInvoices()
begin
    update Invoices
    set Status = 'Overdue'
    where DueDate < curdate() and Status != 'Paid';
end //
DELIMITER ;
/*

INSERT INTO Invoices (InvoiceID, ProjectID, Amount, DueDate, Status)
VALUES ('INV999', 'P101', 1500, '2025-01-01', 'Pending');

UPDATE Invoices
SET DueDate = '2023-01-01'
WHERE InvoiceID = 'INV999';

CALL MarkOverdueInvoices();

SELECT InvoiceID, DueDate, Status FROM Invoices WHERE InvoiceID = 'INV999';

select * from invoices;

*/


-- TRIGGERS

-- 1.) This trigger automatically marks an invoice as overdue when the due date is updated to a past date.
DELIMITER //
CREATE TRIGGER SetOverdueStatus
BEFORE UPDATE ON Invoices
FOR EACH ROW
BEGIN
    IF NEW.DueDate < CURDATE() AND NEW.Status != 'Paid' THEN
        SET NEW.Status = 'Overdue';
    END IF;
END //
DELIMITER ;

/*
INSERT INTO Invoices (InvoiceID, ProjectID, Amount, DueDate, Status)
VALUES ('INV905', 'P102', 1200, '2025-12-31', 'Pending');


UPDATE Invoices
SET DueDate = '2023-01-01'
WHERE InvoiceID = 'INV905';

SELECT InvoiceID, DueDate, Status FROM Invoices WHERE InvoiceID = 'INV905';

*/


-- 2.) Automatically Set Default Invoice Status.

DELIMITER //
CREATE TRIGGER SetDefaultInvoiceStatus
BEFORE INSERT ON Invoices
FOR EACH ROW
BEGIN
    IF NEW.Status IS NULL OR NEW.Status = '' THEN
        SET NEW.Status = 'Pending';
    END IF;
END //
DELIMITER ;


/* INSERT INTO Invoices (InvoiceID, ProjectID, Amount, DueDate)
VALUES ('INV401', 'P101', 1500, '2024-12-31');


SELECT InvoiceID, ProjectID, Amount, DueDate, Status
FROM Invoices
WHERE InvoiceID = 'INV401';
*/

show tables;






