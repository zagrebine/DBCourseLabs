# Семинар 3 — Запросы к нескольким таблицам с соединениями

## База данных

**AdventureWorksLT**

## Тема

**Запросы к нескольким таблицам с использованием соединений (`JOIN`)**

## Цель работы

Цель лабораторной работы — научиться использовать соединения таблиц в SQL-запросах для получения связанных данных из нескольких таблиц базы данных **AdventureWorksLT**.

В работе используются:

* `INNER JOIN`
* `LEFT JOIN`
* `WHERE`
* `UNION`
* псевдонимы таблиц (`AS`)
* выборка столбцов из нескольких таблиц

---

# Задача 1. Создание отчетов по счетам

## 1. Получение заказов клиентов

### Условие

Необходимо получить:

* название компании `CompanyName` из `SalesLT.Customer`;
* идентификатор заказа `SalesOrderID`;
* итоговую стоимость заказа `TotalDue` из `SalesLT.SalesOrderHeader`.

### Решение

```sql
SELECT
    c.CompanyName,
    soh.SalesOrderID,
    soh.TotalDue
FROM SalesLT.Customer AS c
INNER JOIN SalesLT.SalesOrderHeader AS soh
    ON c.CustomerID = soh.CustomerID;
```

### Пояснение

Таблица `SalesLT.Customer` содержит информацию о клиентах, а таблица `SalesLT.SalesOrderHeader` — информацию о заказах.

Связь между таблицами осуществляется через поле:

```text
Customer.CustomerID = SalesOrderHeader.CustomerID
```

Используется `INNER JOIN`, поэтому в результат попадут только те клиенты, у которых есть заказы.

---

# Задача 1.2. Получение заказов клиентов с адресами

### Условие

Необходимо дополнить предыдущий запрос адресом главного офиса клиента.

Нужно вывести:

* `CompanyName`
* `SalesOrderID`
* `TotalDue`
* `AddressLine1`
* `AddressLine2`
* `City`
* `StateProvince`
* `PostalCode`
* `CountryRegion`

Для связи клиента с адресом используются две таблицы:

* `SalesLT.CustomerAddress`
* `SalesLT.Address`

При этом необходимо получить только адреса типа **Main Office**.

### Решение

```sql
SELECT
    c.CompanyName,
    soh.SalesOrderID,
    soh.TotalDue,
    a.AddressLine1,
    a.AddressLine2,
    a.City,
    a.StateProvince,
    a.PostalCode,
    a.CountryRegion
FROM SalesLT.Customer AS c
INNER JOIN SalesLT.SalesOrderHeader AS soh
    ON c.CustomerID = soh.CustomerID
INNER JOIN SalesLT.CustomerAddress AS ca
    ON c.CustomerID = ca.CustomerID
INNER JOIN SalesLT.Address AS a
    ON ca.AddressID = a.AddressID
WHERE ca.AddressType = 'Main Office';
```

### Пояснение

В AdventureWorksLT клиент и адрес связаны не напрямую.

Схема связи:

```text
Customer
   |
   | CustomerID
   ↓
CustomerAddress
   |
   | AddressID
   ↓
Address
```

Поэтому используются два соединения:

```sql
INNER JOIN SalesLT.CustomerAddress AS ca
    ON c.CustomerID = ca.CustomerID
```

и:

```sql
INNER JOIN SalesLT.Address AS a
    ON ca.AddressID = a.AddressID
```

Условие:

```sql
WHERE ca.AddressType = 'Main Office'
```

оставляет только адрес главного офиса.

---

# Задача 2. Получение данных по продажам

## 2.1. Получение списка всех клиентов и их заказов

### Условие

Необходимо вывести:

* название компании `CompanyName`;
* имя клиента `FirstName`;
* фамилию клиента `LastName`;
* идентификатор заказа `SalesOrderID`;
* общую сумму заказа `TotalDue`.

При этом клиенты, которые никогда не размещали заказов, также должны присутствовать в результате.

Для таких клиентов:

* `SalesOrderID` должен быть `NULL`;
* `TotalDue` должен быть `NULL`.

### Решение

```sql
SELECT
    c.CompanyName,
    c.FirstName,
    c.LastName,
    soh.SalesOrderID,
    soh.TotalDue
FROM SalesLT.Customer AS c
LEFT JOIN SalesLT.SalesOrderHeader AS soh
    ON c.CustomerID = soh.CustomerID
ORDER BY c.CompanyName;
```

### Пояснение

Здесь используется:

```sql
LEFT JOIN
```

В отличие от `INNER JOIN`, `LEFT JOIN` возвращает **всех клиентов** из левой таблицы `Customer`.

Если у клиента нет заказа, соответствующие поля из `SalesOrderHeader` будут иметь значение `NULL`.

Например:

```text
CompanyName        FirstName   LastName   SalesOrderID   TotalDue
-----------------  ---------  ---------  -------------  --------
Bike Store         John       Smith      71774          972.78
No Orders Company  Anna       Brown      NULL           NULL
```

Таким образом, клиенты без заказов не теряются.

---

# Задача 2.2. Получение списка клиентов без адреса

### Условие

Необходимо получить список клиентов, у которых отсутствует информация об адресе.

Нужно вывести:

* `CustomerID`
* `CompanyName`
* `FirstName`
* `LastName`
* `Phone`

### Решение

```sql
SELECT
    c.CustomerID,
    c.CompanyName,
    c.FirstName,
    c.LastName,
    c.Phone
FROM SalesLT.Customer AS c
LEFT JOIN SalesLT.CustomerAddress AS ca
    ON c.CustomerID = ca.CustomerID
WHERE ca.CustomerID IS NULL;
```

### Пояснение

Используем `LEFT JOIN`, чтобы сохранить всех клиентов.

Если у клиента нет записи в `CustomerAddress`, поля таблицы `CustomerAddress` будут равны `NULL`.

Поэтому используется:

```sql
WHERE ca.CustomerID IS NULL
```

Это позволяет получить только клиентов, у которых нет адреса.

---

# Задача 2.3. Получение списка клиентов и товаров без заказов

### Условие

Необходимо получить:

* `CustomerID` клиентов, которые никогда не размещали заказ;
* `ProductID` товаров, которые никогда не были заказаны.

Результат должен иметь два столбца:

```text
CustomerID | ProductID
```

Для клиента без заказов:

```text
CustomerID | ProductID
-----------+----------
123        | NULL
```

Для товара без заказов:

```text
CustomerID | ProductID
-----------+----------
NULL       | 999
```

### Решение

```sql
SELECT
    c.CustomerID,
    NULL AS ProductID
FROM SalesLT.Customer AS c
LEFT JOIN SalesLT.SalesOrderHeader AS soh
    ON c.CustomerID = soh.CustomerID
WHERE soh.CustomerID IS NULL

UNION

SELECT
    NULL AS CustomerID,
    p.ProductID
FROM SalesLT.Product AS p
LEFT JOIN SalesLT.SalesOrderDetail AS sod
    ON p.ProductID = sod.ProductID
WHERE sod.ProductID IS NULL;
```

### Пояснение

## Часть 1 — клиенты без заказов

```sql
SELECT
    c.CustomerID,
    NULL AS ProductID
FROM SalesLT.Customer AS c
LEFT JOIN SalesLT.SalesOrderHeader AS soh
    ON c.CustomerID = soh.CustomerID
WHERE soh.CustomerID IS NULL
```

`LEFT JOIN` сохраняет всех клиентов.

Если заказов у клиента нет, то:

```sql
soh.CustomerID IS NULL
```

и такой клиент попадает в результат.

`NULL AS ProductID` нужен потому, что результат должен содержать два столбца:

```text
CustomerID | ProductID
```

Но для клиента у нас нет соответствующего `ProductID`, поэтому его значение — `NULL`.

---

## Часть 2 — товары без заказов

```sql
SELECT
    NULL AS CustomerID,
    p.ProductID
FROM SalesLT.Product AS p
LEFT JOIN SalesLT.SalesOrderDetail AS sod
    ON p.ProductID = sod.ProductID
WHERE sod.ProductID IS NULL;
```

Таблица `SalesLT.Product` содержит все товары.

Таблица `SalesLT.SalesOrderDetail` содержит товары, которые входят в заказы.

Если для товара нет записи в `SalesOrderDetail`, значит этот товар никогда не заказывался.

Поэтому используется:

```sql
WHERE sod.ProductID IS NULL
```

`NULL AS CustomerID` нужен, чтобы результат имел одинаковую структуру:

```text
CustomerID | ProductID
```

---

# Почему используется UNION

В запросе объединяются два независимых результата:

1. клиенты без заказов;
2. товары без заказов.

Первый запрос возвращает:

```text
CustomerID | ProductID
-----------+----------
10         | NULL
20         | NULL
```

Второй:

```text
CustomerID | ProductID
-----------+----------
NULL       | 100
NULL       | 200
```

После `UNION`:

```text
CustomerID | ProductID
-----------+----------
10         | NULL
20         | NULL
NULL       | 100
NULL       | 200
```

`UNION` также удаляет полностью одинаковые строки, если они вдруг встречаются.

В данной задаче можно использовать и `UNION ALL`, однако `UNION` полностью соответствует условию объединения двух выборок.

---

# Используемые таблицы

| Таблица                    | Назначение               |
| -------------------------- | ------------------------ |
| `SalesLT.Customer`         | Клиенты                  |
| `SalesLT.SalesOrderHeader` | Заголовки заказов        |
| `SalesLT.SalesOrderDetail` | Состав заказов           |
| `SalesLT.Product`          | Товары                   |
| `SalesLT.CustomerAddress`  | Связь клиентов и адресов |
| `SalesLT.Address`          | Адреса                   |

---

# Основные связи между таблицами

## Клиент → заказ

```text
Customer.CustomerID
        ↓
SalesOrderHeader.CustomerID
```

SQL:

```sql
ON c.CustomerID = soh.CustomerID
```

## Заказ → товар

```text
SalesOrderHeader.SalesOrderID
        ↓
SalesOrderDetail.SalesOrderID
```

Товар определяется через:

```text
SalesOrderDetail.ProductID
        ↓
Product.ProductID
```

SQL:

```sql
ON p.ProductID = sod.ProductID
```

## Клиент → адрес

```text
Customer.CustomerID
        ↓
CustomerAddress.CustomerID
```

## CustomerAddress → Address

```text
CustomerAddress.AddressID
        ↓
Address.AddressID
```

---

# Основные конструкции SQL, использованные в работе

## INNER JOIN

```sql
SELECT ...
FROM Table1
INNER JOIN Table2
    ON Table1.ID = Table2.ID;
```

Возвращает только строки, для которых существует соответствие в обеих таблицах.

---

## LEFT JOIN

```sql
SELECT ...
FROM Table1
LEFT JOIN Table2
    ON Table1.ID = Table2.ID;
```

Возвращает все строки из `Table1`.

Если соответствующей строки в `Table2` нет, значения столбцов `Table2` будут `NULL`.

Это особенно полезно для поиска:

* клиентов без заказов;
* клиентов без адресов;
* товаров без заказов.

---

## WHERE ... IS NULL

Для проверки отсутствия связанной записи используется:

```sql
WHERE Table2.ID IS NULL
```

Важно: для проверки `NULL` нельзя использовать:

```sql
WHERE Table2.ID = NULL
```

Правильный вариант:

```sql
WHERE Table2.ID IS NULL
```

---

## UNION

Объединяет результаты двух `SELECT`:

```sql
SELECT ...
UNION
SELECT ...
```

Оба запроса должны возвращать одинаковое количество столбцов.

---

# Полный набор запросов

## Задача 1.1

```sql
SELECT
    c.CompanyName,
    soh.SalesOrderID,
    soh.TotalDue
FROM SalesLT.Customer AS c
INNER JOIN SalesLT.SalesOrderHeader AS soh
    ON c.CustomerID = soh.CustomerID;
```

## Задача 1.2

```sql
SELECT
    c.CompanyName,
    soh.SalesOrderID,
    soh.TotalDue,
    a.AddressLine1,
    a.AddressLine2,
    a.City,
    a.StateProvince,
    a.PostalCode,
    a.CountryRegion
FROM SalesLT.Customer AS c
INNER JOIN SalesLT.SalesOrderHeader AS soh
    ON c.CustomerID = soh.CustomerID
INNER JOIN SalesLT.CustomerAddress AS ca
    ON c.CustomerID = ca.CustomerID
INNER JOIN SalesLT.Address AS a
    ON ca.AddressID = a.AddressID
WHERE ca.AddressType = 'Main Office';
```

## Задача 2.1

```sql
SELECT
    c.CompanyName,
    c.FirstName,
    c.LastName,
    soh.SalesOrderID,
    soh.TotalDue
FROM SalesLT.Customer AS c
LEFT JOIN SalesLT.SalesOrderHeader AS soh
    ON c.CustomerID = soh.CustomerID
ORDER BY c.CompanyName;
```

## Задача 2.2

```sql
SELECT
    c.CustomerID,
    c.CompanyName,
    c.FirstName,
    c.LastName,
    c.Phone
FROM SalesLT.Customer AS c
LEFT JOIN SalesLT.CustomerAddress AS ca
    ON c.CustomerID = ca.CustomerID
WHERE ca.CustomerID IS NULL;
```

## Задача 2.3

```sql
SELECT
    c.CustomerID,
    NULL AS ProductID
FROM SalesLT.Customer AS c
LEFT JOIN SalesLT.SalesOrderHeader AS soh
    ON c.CustomerID = soh.CustomerID
WHERE soh.CustomerID IS NULL

UNION

SELECT
    NULL AS CustomerID,
    p.ProductID
FROM SalesLT.Product AS p
LEFT JOIN SalesLT.SalesOrderDetail AS sod
    ON p.ProductID = sod.ProductID
WHERE sod.ProductID IS NULL;
```

---

# Вывод

В ходе лабораторной работы были изучены способы получения данных из нескольких таблиц базы данных **AdventureWorksLT**.

Выполнены запросы для:

1. получения заказов клиентов;
2. получения заказов клиентов вместе с адресами;
3. получения всех клиентов, включая клиентов без заказов;
4. поиска клиентов без адресов;
5. поиска клиентов без заказов;
6. поиска товаров, которые никогда не заказывались.

Основными инструментами работы стали `INNER JOIN`, `LEFT JOIN`, `WHERE IS NULL` и `UNION`.
