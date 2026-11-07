USE AdventureWorksLT2019;
GO

DECLARE @SalesOrderID INT = 0;
DECLARE @ProductID INT = 760;
DECLARE @OrderQty SMALLINT = 1;
DECLARE @UnitPrice MONEY = 782.99;

IF EXISTS (
    SELECT 1
    FROM SalesLT.SalesOrderHeader
    WHERE SalesOrderID = @SalesOrderID
)
    INSERT INTO SalesLT.SalesOrderDetail
    (
        SalesOrderID,
        OrderQty,
        ProductID,
        UnitPrice
    )
    VALUES
    (
        @SalesOrderID,
        @OrderQty,
        @ProductID,
        @UnitPrice
    );

ELSE
    PRINT 'Заказ не существует';
GO