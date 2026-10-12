USE AdventureWorksLT2019;

SELECT
    p.Name,
    SUM(s.LineTotal) AS TotalRevenue
FROM SalesLT.SalesOrderDetail AS s
JOIN SalesLT.Product AS p
    ON s.ProductID = p.ProductID
WHERE p.ListPrice > 1000
GROUP BY p.ProductID, p.Name
ORDER BY TotalRevenue DESC;
