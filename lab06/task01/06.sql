
USE Lab6_DDL;
GO

CREATE TABLE lab6.OrderLine
(
    OrderID INT NOT NULL,
    ProductID INT NOT NULL,
    Qty INT NOT NULL,

    CONSTRAINT PK_OrderLine
        PRIMARY KEY (OrderID, ProductID),

    CONSTRAINT FK_OrderLine_Orders
        FOREIGN KEY (OrderID)
        REFERENCES lab6.Orders (OrderID)
        ON DELETE CASCADE,

    CONSTRAINT FK_OrderLine_Product
        FOREIGN KEY (ProductID)
        REFERENCES lab6.Product (ProductID),

    CONSTRAINT CK_OrderLine_Qty
        CHECK (Qty > 0)
);
GO
