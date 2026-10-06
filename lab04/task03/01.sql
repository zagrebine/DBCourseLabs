SELECT city, countryregion
FROM sales.employee

UNION

SELECT city, countryregion
FROM sales.address;

