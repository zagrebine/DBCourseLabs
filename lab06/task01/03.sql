USE Lab06;
GO

CREATE TABLE lab06.Orders
(
    OrderID INT IDENTITY(1,1) NOT NULL
        CONSTRAINT PK_Orders PRIMARY KEY,
    OrderDate DATE NOT NULL
        CONSTRAINT DF_Orders_OrderDate
        DEFAULT CAST(GETDATE() AS DATE),
    CustomerID INT NOT NULL
        CONSTRAINT FK_Orders_Customer
        REFERENCES lab06.Customer(CustomerID)
);
GO

CREATE TABLE lab06.OrderLine
(
    OrderID INT NOT NULL
        CONSTRAINT FK_OrderLine_Orders
        REFERENCES lab06.Orders(OrderID)
        ON DELETE CASCADE,
    ProductID INT NOT NULL
        CONSTRAINT FK_OrderLine_Product
        REFERENCES lab06.Product(ProductID),
    Qty INT NOT NULL
        CONSTRAINT CK_OrderLine_Qty CHECK (Qty > 0),
    
    CONSTRAINT PK_OrderLine
        PRIMARY KEY (OrderID, ProductID)
);
GO