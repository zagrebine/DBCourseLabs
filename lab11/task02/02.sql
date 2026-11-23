USE AdventureWorksLT2019;
GO

IF OBJECT_ID(N'SalesLT.uspFindStringInDatabase', N'P') IS NOT NULL
    DROP PROCEDURE SalesLT.uspFindStringInDatabase;
GO

CREATE PROCEDURE SalesLT.uspFindStringInDatabase
    @stringToFind NVARCHAR(2000)
AS
BEGIN
    DECLARE @SchemaName SYSNAME;
    DECLARE @TableName SYSNAME;
    DECLARE @Count INT;

    DECLARE c1 CURSOR LOCAL FAST_FORWARD
    FOR
        SELECT TABLE_SCHEMA, TABLE_NAME
        FROM INFORMATION_SCHEMA.TABLES
        WHERE TABLE_TYPE = 'BASE TABLE';

    OPEN c1;

    WHILE (1=1)
    BEGIN
        FETCH NEXT FROM c1 INTO @SchemaName, @TableName;

        IF @@FETCH_STATUS <> 0 BREAK;

        EXEC @Count = SalesLT.uspFindStringInTable
            @schema = @SchemaName,
            @table = @TableName,
            @stringToFind = @stringToFind;

        IF @Count = 0
            PRINT N'В таблице ' + @SchemaName + N'.' + @TableName
                + N' не найдено строк совпадений';
        ELSE
            PRINT N'В таблице ' + @SchemaName + N'.' + @TableName
                + N' найдено строк: ' + CAST(@Count AS NVARCHAR(10));
    END;

    CLOSE c1;
    DEALLOCATE c1;
END;
GO
