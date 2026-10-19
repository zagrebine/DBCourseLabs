USE Lab6_DDL;
GO

CREATE TABLE lab6.Product
(
    ProductID INT NOT NULL,
    Name NVARCHAR(100) NOT NULL,
    Price DECIMAL(10,2) NOT NULL,

    CONSTRAINT PK_Product
        PRIMARY KEY (ProductID),

    CONSTRAINT CK_Product_Price
        CHECK (Price >= 0)
);
GO