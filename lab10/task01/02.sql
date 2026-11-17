USE AdventureWorksLT2019;
GO

DECLARE @SalesOrderID int = 99999;

BEGIN TRY
    IF NOT EXISTS (
        SELECT 1
        FROM SalesLT.SalesOrderHeader
        WHERE SalesOrderID = @SalesOrderID
    )
        THROW 50001, 'Заказ не существует', 1;

    DELETE FROM SalesLT.SalesOrderDetail WHERE SalesOrderID = @SalesOrderID;

    DELETE FROM SalesLT.SalesOrderHeader WHERE SalesOrderID = @SalesOrderID;
END TRY
BEGIN CATCH
    PRINT ERROR_MESSAGE();
END CATCH;