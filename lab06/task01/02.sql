USE Lab06;
GO

CREATE TABLE lab06.Customer
(
    CustomerID INT NOT NULL
        CONSTRAINT PK_Customer PRIMARY KEY,
    Name NVARCHAR(100) NOT NULL,
    City NVARCHAR(50) NOT NULL,
    Email NVARCHAR(100) NULL
        CONSTRAINT UQ_Customer_Email UNIQUE,
    CreatedAt DATETIME2 NOT NULL
        CONSTRAINT DF_Customer_CreatedAt
        DEFAULT SYSDATETIME()
);
GO

CREATE TABLE lab06.Product
(
    ProductID INT NOT NULL
        CONSTRAINT PK_Product PRIMARY KEY,
    Name NVARCHAR(100) NOT NULL,
    Price DECIMAL(10,2) NOT NULL
        CONSTRAINT CK_Product_Price CHECK (Price >= 0)
);
GO