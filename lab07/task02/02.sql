USE AdventureWorksLT2019;

WITH CustomerOrders AS (
    SELECT
        c.CompanyName + ' (' + c.FirstName + ' ' + c.LastName + ')' AS CompanyContact,
        soh.TotalDue
    FROM SalesLT.Customer AS c
    JOIN SalesLT.SalesOrderHeader AS soh
        ON c.CustomerID = soh.CustomerID
)
SELECT
    CompanyContact,
    SUM(TotalDue) AS Revenue
FROM CustomerOrders
GROUP BY CompanyContact
ORDER BY CompanyContact;
