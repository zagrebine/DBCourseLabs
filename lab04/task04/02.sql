SELECT 
    color
FROM production.product
WHERE listprice > 1000

INTERSECT

SELECT 
    p.color
FROM production.product AS p
JOIN production.productcategory AS pc
    ON p.productcategoryid = pc.productcategoryid
WHERE pc.name = 'Components';
