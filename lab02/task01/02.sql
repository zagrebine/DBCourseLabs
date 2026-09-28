USE AdventureWorksLT2019;

SELECT TOP 10 PERCENT
    Name, 
    Weight 
FROM SalesLT.Product
ORDER BY Weight DESC;