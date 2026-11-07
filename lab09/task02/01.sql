USE AdventureWorksLT2019;
GO

DECLARE @AveragePrice MONEY;
DECLARE @MaxPrice MONEY;

SELECT
    @AveragePrice = AVG(p.ListPrice),
    @MaxPrice = MAX(p.ListPrice)
FROM SalesLT.Product AS p
WHERE p.ProductCategoryID IN (
    SELECT ProductCategoryID
    FROM SalesLT.vGetAllCategories
    WHERE ParentProductCategoryName = 'Bikes'
);

WHILE @AveragePrice < 2000
BEGIN
    UPDATE SalesLT.Product
    SET ListPrice = ListPrice * 1.10
    WHERE ProductCategoryID IN (
        SELECT ProductCategoryID
        FROM SalesLT.vGetAllCategories
        WHERE ParentProductCategoryName = 'Bikes'
    );

    SELECT
        @AveragePrice = AVG(p.ListPrice),
        @MaxPrice = MAX(p.ListPrice)
    FROM SalesLT.Product AS p
    WHERE p.ProductCategoryID IN (
        SELECT ProductCategoryID
        FROM SalesLT.vGetAllCategories
        WHERE ParentProductCategoryName = 'Bikes'
    );

    IF @MaxPrice >= 5000
        BREAK;
END;

PRINT 'Новая средняя цена на велосипед: ' + CAST(@AveragePrice AS VARCHAR(20));
PRINT 'Новая максимальная цена велосипеда: ' + CAST(@MaxPrice AS VARCHAR(20));
GO