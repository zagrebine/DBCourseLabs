USE Lab06;
GO

ALTER TABLE lab06.Customer
ADD CONSTRAINT CK_Customer_Email
CHECK (Email LIKE '%@%');
GO