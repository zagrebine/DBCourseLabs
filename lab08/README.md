# Лабораторная работа № 8

---

## Задача 1. Получение итогов продаж по регионам

### 1.1. Получение итогов для страны/региона и штата/провинции

Использование `ROLLUP` для получения промежуточных и общих итогов продаж.

```sql
USE AdventureWorksLT2019;
GO

SELECT
    a.CountryRegion,
    a.StateProvince,
    SUM(s.TotalDue) AS Revenue
FROM SalesLT.Address AS a
JOIN SalesLT.CustomerAddress AS ca
    ON a.AddressID = ca.AddressID
JOIN SalesLT.Customer AS c
    ON ca.CustomerID = c.CustomerID
JOIN SalesLT.SalesOrderHeader AS s
    ON c.CustomerID = s.CustomerID
GROUP BY ROLLUP (a.CountryRegion, a.StateProvince)
ORDER BY
    a.CountryRegion,
    a.StateProvince;
GO
```

### 1.2. Указание уровней группировки в результатах

Добавление столбца `Level` с обозначением общего итога и промежуточных итогов.

```sql
USE AdventureWorksLT2019;
GO

SELECT
    a.CountryRegion,
    a.StateProvince,
    SUM(s.TotalDue) AS Revenue,
    CASE
        WHEN GROUPING(a.CountryRegion) = 1 THEN 'Total'
        WHEN GROUPING(a.StateProvince) = 1 THEN a.CountryRegion + ' Subtotal'
        ELSE a.StateProvince + ' Subtotal'
    END AS Level
FROM SalesLT.Address AS a
JOIN SalesLT.CustomerAddress AS ca
    ON a.AddressID = ca.AddressID
JOIN SalesLT.Customer AS c
    ON ca.CustomerID = c.CustomerID
JOIN SalesLT.SalesOrderHeader AS s
    ON c.CustomerID = s.CustomerID
GROUP BY ROLLUP (a.CountryRegion, a.StateProvince)
ORDER BY
    a.CountryRegion,
    a.StateProvince;
GO
```

### 1.3. Добавление уровня группировки для городов

Добавление столбца `City` и промежуточных итогов по городам.

```sql
USE AdventureWorksLT2019;
GO

SELECT
    a.CountryRegion,
    a.StateProvince,
    a.City,
    SUM(s.TotalDue) AS Revenue,
    CASE
        WHEN GROUPING(a.CountryRegion) = 1 THEN 'Total'
        WHEN GROUPING(a.StateProvince) = 1 THEN a.CountryRegion + ' Subtotal'
        WHEN GROUPING(a.City) = 1 THEN a.StateProvince + ' Subtotal'
        ELSE a.City + ' Subtotal'
    END AS Level
FROM SalesLT.Address AS a
JOIN SalesLT.CustomerAddress AS ca
    ON a.AddressID = ca.AddressID
JOIN SalesLT.Customer AS c
    ON ca.CustomerID = c.CustomerID
JOIN SalesLT.SalesOrderHeader AS s
    ON c.CustomerID = s.CustomerID
GROUP BY ROLLUP (a.CountryRegion, a.StateProvince, a.City)
ORDER BY
    a.CountryRegion,
    a.StateProvince,
    a.City;
GO
```

---

## Задача 2. Получение доходов от продаж по категориям

### 2.1. Получение дохода от продаж для каждой родительской категории

Использование оператора `PIVOT` для преобразования категорий товаров в отдельные столбцы и получения дохода по каждой компании.

```sql
USE AdventureWorksLT2019;
GO

SELECT
    CompanyName,
    Accessories,
    Bikes,
    Clothing,
    Components
FROM
(
    SELECT
        c.CompanyName,
        cat.ParentProductCategoryName,
        d.LineTotal
    FROM SalesLT.Customer AS c
    JOIN SalesLT.SalesOrderHeader AS s
        ON c.CustomerID = s.CustomerID
    JOIN SalesLT.SalesOrderDetail AS d
        ON s.SalesOrderID = d.SalesOrderID
    JOIN SalesLT.Product AS p
        ON d.ProductID = p.ProductID
    JOIN SalesLT.vGetAllCategories AS cat
        ON p.ProductCategoryID = cat.ProductCategoryID
) AS source
PIVOT
(
    SUM(LineTotal)
    FOR ParentProductCategoryName IN
    (
        Accessories,
        Bikes,
        Clothing,
        Components
    )
) AS result
ORDER BY CompanyName;
GO
```