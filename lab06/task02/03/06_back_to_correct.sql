USE Lab06;
GO

UPDATE lab06.Customer
SET Email = N'correct@example.com'
WHERE CustomerID = 8;

ALTER TABLE lab06.Customer
WITH CHECK CHECK CONSTRAINT CK_Customer_Email;
GO