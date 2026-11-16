USE AdventureWorksLT2019;
GO 
DECLARE @SalesOrderID int = 71774;

BEGIN TRY
    BEGIN TRANSACTION;

    DELETE FROM SalesLT.SalesOrderDetail
    WHERE SalesOrderID = @SalesOrderID;

    THROW 50001, 'Test error', 1;

    DELETE FROM SalesLT.SalesOrderHeader
    WHERE SalesOrderID = @SalesOrderID;

    COMMIT TRANSACTION;
END TRY
BEGIN CATCH
    IF XACT_STATE() <> 0
    BEGIN
        ROLLBACK TRANSACTION;
        THROW;
    END
    ELSE
    BEGIN
        PRINT ERROR_MESSAGE();
    END
END CATCH;