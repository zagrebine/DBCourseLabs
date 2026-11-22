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

    BEGIN TRANSACTION
    DELETE FROM SalesLT.SalesOrderDetail WHERE SalesOrderID = @SalesOrderID;

    THROW 50002, 'ОШИБКА 2', 2;

    DELETE FROM SalesLT.SalesOrderHeader WHERE SalesOrderID = @SalesOrderID;
    COMMIT TRANSACTION
END TRY
BEGIN CATCH
    IF XACT_STATE > 0 PRINT("hjhjhj");
    
    PRINT ERROR_MESSAGE();
END CATCH;