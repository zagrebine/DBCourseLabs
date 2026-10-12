USE AdventureWorksLT2019;

SELECT
    p.ProductID, 
    UPPER(p.Name), 
    ROUND(p.Weight, 0) AS ApproxWeight
FROM SalesLT.Product as p;