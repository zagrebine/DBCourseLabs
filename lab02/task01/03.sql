USE AdventureWorksLT2019;

SELECT 
    Name, 
    ISNULL(Weight, 0) AS Weight 
FROM SalesLT.Product
ORDER BY Weight DESC
OFFSET 10 ROWS;