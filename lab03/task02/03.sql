USE AdventureWorksLT2019;

SELECT 
    c.CustomerID,
    NULL AS ProductID
FROM SalesLT.Customer c
LEFT JOIN SalesLT.SalesOrderHeader soh
    ON c.CustomerID = soh.CustomerID
WHERE soh.CustomerID IS NULL

UNION ALL

SELECT 
    NULL AS CustomerID,
    p.ProductID
FROM SalesLT.Product p
LEFT JOIN SalesLT.SalesOrderDetail sod
    ON p.ProductID = sod.ProductID
WHERE sod.ProductID IS NULL;