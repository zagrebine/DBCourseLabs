USE AdventureWorksLT2019;
GO

DECLARE @TableName VARCHAR(50) = 'Product';
DECLARE @SchemaName VARCHAR(50) = 'SalesLT';
DECLARE @SearchValue VARCHAR(50) = 'Bike';

DECLARE @ColumnName VARCHAR(50);
DECLARE @SQL VARCHAR(MAX) = '';
DECLARE @Condition VARCHAR(MAX) = '';

DECLARE ColumnCursor CURSOR FOR
SELECT COLUMN_NAME
FROM INFORMATION_SCHEMA.COLUMNS
WHERE TABLE_NAME = @TableName
AND TABLE_SCHEMA = @SchemaName
AND DATA_TYPE IN ('char', 'nchar', 'varchar', 'nvarchar', 'text', 'ntext');

OPEN ColumnCursor;

FETCH NEXT FROM ColumnCursor INTO @ColumnName;

WHILE @@FETCH_STATUS = 0
BEGIN
    SET @Condition = @Condition 
        + CASE WHEN @Condition = '' THEN '' ELSE ' OR ' END 
        + @ColumnName 
        + ' LIKE ''%' + @SearchValue + '%''';
    FETCH NEXT FROM ColumnCursor INTO @ColumnName;
END;

CLOSE ColumnCursor;
DEALLOCATE ColumnCursor;

SET @SQL = 'SELECT * FROM ' + @SchemaName + '.' + @TableName + ' WHERE ' + @Condition;

PRINT @SQL;
EXECUTE(@SQL);