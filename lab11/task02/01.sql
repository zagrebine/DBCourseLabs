USE AdventureWorksLT2019;
GO

IF OBJECT_ID(N'SalesLT.uspFindStringInTable', N'P') IS NOT NULL
    DROP PROCEDURE SalesLT.uspFindStringInTable;
GO

CREATE PROCEDURE SalesLT.uspFindStringInTable
    @schema SYSNAME,
    @table SYSNAME,
    @stringToFind NVARCHAR(2000)
AS
BEGIN
    DECLARE @ColumnName SYSNAME;
    DECLARE @Condition NVARCHAR(MAX) = N'';
    DECLARE @SQL NVARCHAR(MAX);
    DECLARE @Count INT;

    DECLARE c1 CURSOR LOCAL FAST_FORWARD
    FOR
        SELECT COLUMN_NAME
        FROM INFORMATION_SCHEMA.COLUMNS
        WHERE TABLE_SCHEMA = @schema
          AND TABLE_NAME = @table
          AND DATA_TYPE IN ('char', 'nchar', 'varchar', 'nvarchar', 'text', 'ntext');

    OPEN c1;

    WHILE (1=1)
    BEGIN
        FETCH NEXT FROM c1 INTO @ColumnName;

        IF @@FETCH_STATUS <> 0 BREAK;

        IF @Condition <> N''
            SET @Condition = @Condition + N' OR ';

        SET @Condition = @Condition +
            N'CAST(' + QUOTENAME(@ColumnName) +
            N' AS NVARCHAR(MAX)) LIKE N''%'' + @stringToFind + N''%''';
    END;

    CLOSE c1;
    DEALLOCATE c1;

    IF @Condition = N'' RETURN 0;

    SET @SQL = N'
        SELECT @Count = COUNT(*)
        FROM ' + QUOTENAME(@schema) + N'.' + QUOTENAME(@table) + N'
        WHERE ' + @Condition + N';

        SELECT *
        FROM ' + QUOTENAME(@schema) + N'.' + QUOTENAME(@table) + N'
        WHERE ' + @Condition;

    EXEC sp_executesql
        @SQL,
        N'@stringToFind NVARCHAR(2000), @Count INT OUTPUT',
        @stringToFind = @stringToFind,
        @Count = @Count OUTPUT;

    RETURN @Count;
END;
GO