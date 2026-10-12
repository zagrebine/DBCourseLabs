USE AdventureWorksLT2019;

SELECT
    c.CompanyName,
    h.TotalDue AS Revenue,
    RANK() OVER (ORDER BY h.TotalDue DESC) AS RankByRevenue
FROM SalesLT.SalesOrderHeader AS h
INNER JOIN SalesLT.Customer AS c
    ON h.CustomerID = c.CustomerID;