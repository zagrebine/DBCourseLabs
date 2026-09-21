USE AdventureWorksLT2019;

SELECT 
    ProductNumber, 
    Name
FROM SalesLT.Product
WHERE (Color LIKE 'Black'
    OR Color LIKE 'Red'
    OR Color LIKE 'White') 
    AND (Size LIKE 'S' 
    OR Size LIKE 'M');