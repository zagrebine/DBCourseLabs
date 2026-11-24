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
    DECLARE @SQL NVARCHAR(MAX) = N'';

    DECLARE c1 CURSOR FOR
    SELECT COLUMN_NAME
    FROM INFORMATION_SCHEMA.COLUMNS
    WHERE TABLE_NAME = @table
    AND TABLE_SCHEMA = @schema
    AND DATA_TYPE IN ('char', 'nchar', 'varchar', 'nvarchar', 'text', 'ntext');

    OPEN c1;

    FETCH NEXT FROM c1 INTO @ColumnName;

    WHILE @@FETCH_STATUS = 0
    BEGIN
        SET @Condition = @Condition +
            CASE WHEN @Condition = N'' THEN N'' ELSE N' OR ' END +
            N'CAST(' + QUOTENAME(@ColumnName) +
            N' AS NVARCHAR(MAX)) LIKE N''%'' + @stringToFind + N''%''';

        FETCH NEXT FROM c1 INTO @ColumnName;
    END;

    CLOSE c1;
    DEALLOCATE c1;

    IF @Condition = N'' RETURN 0;

    SET @SQL = N'
        SELECT *
        FROM ' + QUOTENAME(@schema) + N'.' + QUOTENAME(@table) + N'
        WHERE ' + @Condition + N';

        SELECT @Count = COUNT(*)
        FROM ' + QUOTENAME(@schema) + N'.' + QUOTENAME(@table) + N'
        WHERE ' + @Condition;

    DECLARE @Count INT;

    EXEC sp_executesql
        @SQL,
        N'@stringToFind NVARCHAR(2000), @Count INT OUTPUT',
        @stringToFind = @stringToFind,
        @Count = @Count OUTPUT;

    RETURN @Count;
END;
GO
