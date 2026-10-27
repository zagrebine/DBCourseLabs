USE AdventureWorksLT2019;

SELECT
    p.ProductID,
    p.Name AS ProductName,
    c.ParentProductCategoryName AS ParentCategory,
    c.ProductCategoryName AS Category
FROM SalesLT.Product AS p
LEFT JOIN dbo.ufnGetAllCategories() AS c
    ON p.ProductCategoryID = c.ProductCategoryID
ORDER BY
    ParentCategory,
    Category,
    ProductName;
