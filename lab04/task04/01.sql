SELECT 
    p.name 
FROM production.product AS p
    WHERE p.listprice > 50

UNION

SELECT 
    p.name
FROM production.product AS p
WHERE p.color IS NULL;
    