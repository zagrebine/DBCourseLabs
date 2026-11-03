USE Lab06;
GO

UPDATE lab06.Customer
SET Email = N'test@example.com'
WHERE CustomerID = 6;
GO

ALTER TABLE lab06.Customer
ADD CONSTRAINT CK_Customer_Email
CHECK (Email LIKE '%@%');
GO