USE Lab6_DDL;
GO

CREATE TABLE lab6.Customer
(
    CustomerID INT NOT NULL,
    Name NVARCHAR(100) NOT NULL,
    City NVARCHAR(50) NOT NULL,
    Email NVARCHAR(100) NULL,
    CreatedAt DATETIME2 NOT NULL
        CONSTRAINT DF_Customer_CreatedAt
        DEFAULT SYSDATETIME(),

    CONSTRAINT PK_Customer
        PRIMARY KEY (CustomerID),

    CONSTRAINT UQ_Customer_Email
        UNIQUE (Email)
);
GO