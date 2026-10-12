USE AdventureWorksLT2019;

SELECT
    p.ProductID, 
    UPPER(p.Name) AS ProductName, 
    ROUND(p.Weight, 0) AS ApproxWeight, 
    DATENAME(year, p.SellStartDate) AS SellStartYear, 
    DATENAME(month, p.SellStartDate) AS SellStartMonth, 
    LEFT(p.ProductNumber, 2) AS ProductType
FROM SalesLT.Product as p
WHERE ISNUMERIC(p.Size) = 1;