# Лабораторная работа №7. Табличные выражения в SQL Server

## Цель работы

Изучить способы получения и обработки данных в SQL Server с использованием представлений, табличных переменных, временных таблиц, табличных функций, производных таблиц и обобщённых табличных выражений (CTE).

## Используемые технологии

- Microsoft SQL Server
- Docker
- База данных `AdventureWorksLT2019`
- Язык запросов T-SQL

## Задание 1. Получение информации о товарах с использованием представления

**Цель:** получить идентификатор товара, его название, название модели и описание модели.

Для выполнения задания используются таблицы `SalesLT.Product`, `SalesLT.ProductModel` и представление `SalesLT.vProductModelCatalogDescription`.

```sql
USE AdventureWorksLT2019;

SELECT
    p.ProductID,
    p.Name AS ProductName,
    pm.Name AS ProductModel,
    pmcd.Summary
FROM SalesLT.Product AS p
JOIN SalesLT.ProductModel AS pm
    ON p.ProductModelID = pm.ProductModelID
JOIN SalesLT.vProductModelCatalogDescription AS pmcd
    ON p.ProductModelID = pmcd.ProductModelID
ORDER BY p.ProductID;
```

**Результат:** список товаров с названиями моделей и их описаниями.

## Задание 2. Фильтрация товаров с использованием табличной переменной

**Цель:** получить список товаров, используя табличную переменную, содержащую уникальные цвета.

```sql
USE AdventureWorksLT2019;

DECLARE @UniqueColors TABLE
(
    Color NVARCHAR(15)
);

INSERT INTO @UniqueColors (Color)
SELECT DISTINCT Color
FROM SalesLT.Product
WHERE Color IS NOT NULL;

SELECT
    p.ProductID,
    p.Name AS ProductName,
    p.Color
FROM SalesLT.Product AS p
JOIN @UniqueColors AS uc
    ON p.Color = uc.Color
ORDER BY p.Color;
```

**Результат:** список товаров с непустым цветом, отсортированный по цвету.

## Задание 3. Фильтрация товаров с использованием временной таблицы

**Цель:** получить список товаров с использованием временной таблицы, содержащей уникальные размеры.

```sql
USE AdventureWorksLT2019;

DROP TABLE IF EXISTS #UniqueSizes;

CREATE TABLE #UniqueSizes
(
    Size NVARCHAR(5)
);

INSERT INTO #UniqueSizes (Size)
SELECT DISTINCT Size
FROM SalesLT.Product
WHERE Size IS NOT NULL;

SELECT
    p.ProductID,
    p.Name AS ProductName,
    p.Size
FROM SalesLT.Product AS p
JOIN #UniqueSizes AS us
    ON p.Size = us.Size
ORDER BY p.Size DESC;

DROP TABLE #UniqueSizes;
```

**Результат:** список товаров с непустыми размерами, отсортированный по размеру в порядке убывания.

## Задание 4. Получение категорий товаров с использованием табличной функции

**Цель:** получить список товаров с названиями родительских категорий и категорий.

```sql
USE AdventureWorksLT2019;

SELECT
    p.ProductID,
    p.Name AS ProductName,
    c.ParentProductCategoryName AS ParentCategory,
    c.ProductCategoryName AS Category
FROM SalesLT.Product AS p
JOIN dbo.ufnGetAllCategories() AS c
    ON p.ProductCategoryID = c.ProductCategoryID
ORDER BY
    ParentCategory,
    Category,
    ProductName;
```

**Результат:** список товаров с информацией об их категориях, отсортированный по категориям и названию товара.

## Задание 5. Получение выручки по клиентам с использованием производной таблицы

**Цель:** получить название компании, имя и фамилию контактного лица, а также общую сумму заказов каждого клиента.

```sql
USE AdventureWorksLT2019;

SELECT
    d.CompanyContact,
    SUM(d.TotalDue) AS Revenue
FROM (
    SELECT
        c.CompanyName + ' (' + c.FirstName + ' ' + c.LastName + ')' AS CompanyContact,
        soh.TotalDue
    FROM SalesLT.Customer AS c
    JOIN SalesLT.SalesOrderHeader AS soh
        ON c.CustomerID = soh.CustomerID
) AS d
GROUP BY d.CompanyContact
ORDER BY d.CompanyContact;
```

**Результат:** список клиентов с контактными данными и общей суммой их заказов, отсортированный по `CompanyContact`.

## Задание 6. Получение выручки по клиентам с использованием CTE

**Цель:** переписать предыдущий запрос с помощью обобщённого табличного выражения (CTE).

```sql
USE AdventureWorksLT2019;

WITH CustomerOrders AS (
    SELECT
        c.CompanyName + ' (' + c.FirstName + ' ' + c.LastName + ')' AS CompanyContact,
        soh.TotalDue
    FROM SalesLT.Customer AS c
    JOIN SalesLT.SalesOrderHeader AS soh
        ON c.CustomerID = soh.CustomerID
)
SELECT
    CompanyContact,
    SUM(TotalDue) AS Revenue
FROM CustomerOrders
GROUP BY CompanyContact
ORDER BY CompanyContact;
```

**Результат:** список клиентов с контактными данными и общей суммой заказов.

## Вывод

В ходе лабораторной работы были изучены представления, табличные переменные, временные таблицы и табличные функции. Также были рассмотрены производные таблицы и обобщённые табличные выражения (CTE).

На практике были выполнены объединение данных из нескольких источников, фильтрация, сортировка, группировка и вычисление общей выручки клиентов с помощью `SUM()`.
