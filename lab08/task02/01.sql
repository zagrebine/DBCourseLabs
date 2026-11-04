USE AdventureWorksLT2019;
GO

SELECT
    CompanyName,
    Accessories,
    Bikes,
    Clothing,
    Components
FROM
(
    SELECT
        c.CompanyName,
        cat.ParentProductCategoryName,
        d.LineTotal
    FROM SalesLT.Customer AS c
    JOIN SalesLT.SalesOrderHeader AS s
        ON c.CustomerID = s.CustomerID
    JOIN SalesLT.SalesOrderDetail AS d
        ON s.SalesOrderID = d.SalesOrderID
    JOIN SalesLT.Product AS p
        ON d.ProductID = p.ProductID
    JOIN SalesLT.vGetAllCategories AS cat
        ON p.ProductCategoryID = cat.ProductCategoryID
) AS source
PIVOT
(
    SUM(LineTotal)
    FOR ParentProductCategoryName IN
    (
        Accessories,
        Bikes,
        Clothing,
        Components
    )
) AS result
ORDER BY CompanyName;
GO