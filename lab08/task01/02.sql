USE AdventureWorksLT2019;
GO

SELECT
    a.CountryRegion,
    a.StateProvince,
    SUM(s.TotalDue) AS Revenue,
    CASE
        WHEN GROUPING(a.CountryRegion) = 1 THEN 'Total'
        WHEN GROUPING(a.StateProvince) = 1 THEN a.CountryRegion + ' Subtotal'
        ELSE a.StateProvince + ' Subtotal'
    END AS Level
FROM SalesLT.Address AS a
JOIN SalesLT.CustomerAddress AS ca
    ON a.AddressID = ca.AddressID
JOIN SalesLT.Customer AS c
    ON ca.CustomerID = c.CustomerID
JOIN SalesLT.SalesOrderHeader AS s
    ON c.CustomerID = s.CustomerID
GROUP BY ROLLUP (a.CountryRegion, a.StateProvince)
ORDER BY
    a.CountryRegion,
    a.StateProvince;
GO