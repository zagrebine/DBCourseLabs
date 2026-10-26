USE AdventureWorksLT2019;


SELECT
    p.ProductID,
    p.Name AS ProductName,
    pm.Name AS ProductModel,
    pmc.Summary
FROM SalesLT.Product AS p
JOIN SalesLT.vProductModelCatalogDescription AS pmc
    ON p.ProductModelID = pmc.ProductModelID
JOIN SalesLT.ProductModel AS pm
    ON p.ProductModelID = pm.ProductModelID
ORDER BY
    p.ProductID;
