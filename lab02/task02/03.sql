USE AdventureWorksLT2019;

SELECT 
    ProductNumber, 
    Name, 
    ListPrice
FROM SalesLT.Product
WHERE ProductNumber LIKE 'BK-%';