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

    DECLARE c2 CURSOR FOR
    SELECT TABLE_SCHEMA, TABLE_NAME
    FROM INFORMATION_SCHEMA.TABLES
    WHERE TABLE_TYPE = 'BASE TABLE';

    OPEN c2;

    FETCH NEXT FROM c2 INTO @SchemaName, @TableName;

    WHILE @@FETCH_STATUS = 0
    BEGIN
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

        FETCH NEXT FROM c2 INTO @SchemaName, @TableName;
    END;

    CLOSE c2;
    DEALLOCATE c2;
END;
GO
