SELECT
    c.companyname,
    a.addressline1,
    a.city,
    'Billing' AS addresstype
FROM sales.customer AS c
JOIN sales.customeraddress AS ca
    ON c.customerid = ca.customerid
JOIN sales.address AS a
    ON ca.addressid = a.addressid
WHERE ca.addresstype = 'Main Office'

UNION

SELECT
    c.companyname,
    a.addressline1,
    a.city,
    'Shipping' AS addresstype
FROM sales.customer AS c
JOIN sales.customeraddress AS ca
    ON c.customerid = ca.customerid
JOIN sales.address AS a
    ON ca.addressid = a.addressid
WHERE ca.addresstype = 'Shipping'

ORDER BY companyname, addresstype
LIMIT 10;

