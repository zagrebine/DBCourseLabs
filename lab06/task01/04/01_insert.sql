USE Lab06;
GO

INSERT INTO lab06.Customer (CustomerID, Name, City, Email)
VALUES
    (1, N'Иван Иванов', N'Москва', N'ivan@example.com'),
    (2, N'Егор Загребин', N'Москва', NULL),
    (3, N'Анастасия Валова', N'Москва', N'valova@example.com');
GO

INSERT INTO lab06.Product (ProductID, Name, Price)
VALUES
    (1, N'Велосипед', 75000.00),
    (2, N'MacBook Pro M4', 150000.00),
    (3, N'Magic Mouse', 10000.00);
GO

INSERT INTO lab06.Orders (CustomerID)
VALUES
    (1),
    (2);
GO

INSERT INTO lab06.OrderLine (OrderID, ProductID, Qty)
VALUES
    (1, 1, 1),
    (1, 2, 2),
    (2, 2, 1),
    (2, 3, 1);
GO