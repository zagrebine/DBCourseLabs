USE Lab06;
GO

ALTER TABLE lab06.Customer
DROP CONSTRAINT CK_Customer_Email;
GO

INSERT INTO lab06.Customer (CustomerID, Name, City, Email)
VALUES (8, N'тестовый клиент 2', N'Чебоксары', N'wrong-email');
GO

ALTER TABLE lab06.Customer WITH NOCHECK
ADD CONSTRAINT CK_Customer_Email
CHECK (Email LIKE '%@%');
GO