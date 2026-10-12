USE AdventureWorksLT2019;

SELECT
    p.ProductID, 
    UPPER(p.Name) AS ProductName, 
    ROUND(p.Weight, 0) AS ApproxWeight, 
    DATENAME(year, p.SellStartDate) AS SellStartYear, 
    DATENAME(month, p.SellStartDate) AS SellStartMonth
FROM SalesLT.Product as p;