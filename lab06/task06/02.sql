
USE AdventureWorksLT2019;
GO

SELECT
    ca.CustomerID,
    ci.FirstName,
    ci.LastName,
    a.AddressLine1,
    a.City
FROM SalesLT.CustomerAddress AS ca
JOIN SalesLT.Address AS a
    ON ca.AddressID = a.AddressID
CROSS APPLY dbo.ufnGetCustomerInformation(ca.CustomerID) AS ci
ORDER BY ca.CustomerID;
GO
