SELECT c.companyname
FROM sales.customer AS c
JOIN sales.customeraddress AS ca
    ON c.customerid = ca.customerid
WHERE ca.addresstype = 'Main Office'

INTERSECT

SELECT c.companyname
FROM sales.customer AS c
JOIN sales.customeraddress AS ca
    ON c.customerid = ca.customerid
WHERE ca.addresstype = 'Shipping';
