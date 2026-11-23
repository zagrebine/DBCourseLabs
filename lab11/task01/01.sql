USE AdventureWorksLT2019;
GO

DECLARE @TableName VARCHAR(50) = 'Product';
DECLARE @SchemaName VARCHAR(50) = 'SalesLT';

SELECT
    COLUMN_NAME AS ColumnName,
    DATA_TYPE AS Type
FROM INFORMATION_SCHEMA.COLUMNS
WHERE TABLE_NAME = @TableName
AND TABLE_SCHEMA = @SchemaName
AND DATA_TYPE IN ('char', 'nchar', 'varchar', 'nvarchar', 'text', 'ntext');