USE AdventureWorksLT2019;


SELECT
    p.Name,
    SUM(s.LineTotal) AS TotalRevenue
FROM SalesLT.SalesOrderDetail AS s
JOIN SalesLT.Product AS p
    ON s.ProductID = p.ProductID
GROUP BY p.Name
HAVING SUM(s.LineTotal) > 20000
ORDER BY TotalRevenue DESC;
