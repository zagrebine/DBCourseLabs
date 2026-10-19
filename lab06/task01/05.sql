
USE Lab6_DDL;
GO

CREATE TABLE lab6.Orders
(
    OrderID INT IDENTITY(1,1) NOT NULL,
    OrderDate DATE NOT NULL
        CONSTRAINT DF_Orders_OrderDate
        DEFAULT CAST(GETDATE() AS DATE),
    CustomerID INT NOT NULL,

    CONSTRAINT PK_Orders
        PRIMARY KEY (OrderID),

    CONSTRAINT FK_Orders_Customer
        FOREIGN KEY (CustomerID)
        REFERENCES lab6.Customer (CustomerID)
);
GO
