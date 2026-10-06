SELECT 
    e.city, 
    e.countryregion
FROM sales.employee AS e

EXCEPT

SELECT 
    a.city, 
    a.countryregion
FROM sales.customer AS c
JOIN sales.customeraddress AS ca 
    ON c.customerid = ca.customerid
JOIN sales.address AS a 
    ON ca.addressid = a.addressid;
