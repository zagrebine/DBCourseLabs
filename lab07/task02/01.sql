USE AdventureWorksLT2019;

SELECT
    d.CompanyContact,
    SUM(d.TotalDue) AS Revenue
FROM (
    SELECT
        c.CompanyName + ' (' + c.FirstName + ' ' + c.LastName + ')' AS CompanyContact,
        s.TotalDue
    FROM SalesLT.Customer AS c
    JOIN SalesLT.SalesOrderHeader AS s
        ON c.CustomerID = s.CustomerID
) AS d
GROUP BY d.CompanyContact
ORDER BY d.CompanyContact;