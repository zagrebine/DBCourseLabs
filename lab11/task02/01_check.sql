USE AdventureWorksLT2019;
GO

DECLARE @Result INT;

EXEC @Result = SalesLT.uspFindStringInTable
    @schema = 'SalesLT',
    @table = 'Product',
    @stringToFind = N'Bike';

PRINT 'Количество найденных строк: ' + CAST(@Result AS VARCHAR(10));