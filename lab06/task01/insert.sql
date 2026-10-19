
USE Lab6_DDL;
GO

INSERT INTO lab6.Customer (CustomerID, Name, City, Email)
VALUES
    (1, N'Иван Петров', N'Москва', N'ivan@example.com'),
    (2, N'Анна Смирнова', N'Казань', N'anna@example.com'),
    (3, N'Пётр Иванов', N'Самара', NULL);
GO

INSERT INTO lab6.Product (ProductID, Name, Price)
VALUES
    (1, N'Ноутбук', 75000.00),
    (2, N'Мышь', 1500.00),
    (3, N'Клавиатура', 3500.00);
GO

DECLARE @Order1 INT, @Order2 INT;

INSERT INTO lab6.Orders (CustomerID)
VALUES (1);

SET @Order1 = CONVERT(INT, SCOPE_IDENTITY());

INSERT INTO lab6.Orders (CustomerID)
VALUES (2);

SET @Order2 = CONVERT(INT, SCOPE_IDENTITY());

INSERT INTO lab6.OrderLine (OrderID, ProductID, Qty)
VALUES
    (@Order1, 1, 1),
    (@Order1, 2, 2),
    (@Order2, 2, 1),
    (@Order2, 3, 1);
GO
