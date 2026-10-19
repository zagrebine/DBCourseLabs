USE AdventureWorksLT2019;
GO

SELECT
    ProductID,
    Name,
    ListPrice
FROM SalesLT.Product
WHERE ListPrice >= 100
  AND ProductID IN
  (
      SELECT ProductID
      FROM SalesLT.SalesOrderDetail
      WHERE UnitPrice < 100
  )
ORDER BY ProductID;
GO