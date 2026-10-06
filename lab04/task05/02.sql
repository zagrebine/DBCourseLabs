SELECT
    p.name
FROM production.product AS p
    WHERE p.listprice < 100

EXCEPT

SELECT
    p.name
FROM production.product AS p
    WHERE p.listprice < 100
        AND p.color IS NOT NULL;
