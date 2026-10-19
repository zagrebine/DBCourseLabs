
USE AdventureWorksLT2019;
GO

SELECT
    soh.SalesOrderID,
    soh.CustomerID,
    ci.FirstName,
    ci.LastName,
    soh.TotalDue
FROM SalesLT.SalesOrderHeader AS soh
CROSS APPLY dbo.ufnGetCustomerInformation(soh.CustomerID) AS ci
ORDER BY soh.SalesOrderID;
GO
