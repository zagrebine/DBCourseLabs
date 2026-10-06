SELECT city, countryregion
FROM sales.employee

INTERSECT

SELECT city, countryregion
FROM sales.address;

