USE AdventureWorksLT2019;
GO

DECLARE @OrderDate DATETIME = GETDATE();
DECLARE @DueDate DATETIME = DATEADD(DAY, 7, @OrderDate);
DECLARE @CustomerID INT = 1;
DECLARE @SalesOrderID INT;

INSERT INTO SalesLT.SalesOrderHeader
(
    OrderDate,
    DueDate,
    CustomerID,
    ShipMethod
)
VALUES
(
    @OrderDate,
    @DueDate,
    @CustomerID,
    'CARGO TRANSPORT 5'
);

SET @SalesOrderID = SCOPE_IDENTITY();

PRINT 'SalesOrderID: ' + CAST(@SalesOrderID AS VARCHAR(20));
GO