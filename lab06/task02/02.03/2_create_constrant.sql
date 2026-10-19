USE Lab6_DDL;
GO

ALTER TABLE lab6.Customer
ADD CONSTRAINT CK_Customer_Email 
CHECK (Email LIKE '%@%');
GO