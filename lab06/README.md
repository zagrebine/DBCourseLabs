# Лабораторная работа № 6

## Описание работы

В данной лабораторной работе выполняется создание и настройка объектов базы данных в Microsoft SQL Server с использованием языка SQL. Работа выполняется поэтапно с помощью отдельных SQL-скриптов.

Для изоляции объектов лабораторной работы от существующих баз данных была создана отдельная база данных `Lab6_DDL`. Все объекты, созданные в рамках заданий, размещаются в этой базе данных.

**## Задание 1. Создание схемы и таблиц**

**### Задание выполнено в директории `DBCourseLabs\lab06\task01`.**

**#### 1. Создание базы данных и схемы — `01.sql`**

```sql
USE master;
GO

CREATE DATABASE Lab06;
GO

USE Lab06;
GO

CREATE SCHEMA lab06;
GO
```

**#### 2. Создание таблиц Customer и Product — `02.sql`**

В схеме `lab06` созданы таблицы `Customer` и `Product` в соответствии с требованиями задания.

Таблица `Customer` содержит информацию о клиентах. Для неё заданы первичный ключ, уникальность электронной почты и значение даты создания по умолчанию.

Таблица `Product` содержит информацию о товарах. Для неё заданы первичный ключ и ограничение, запрещающее отрицательные значения цены.

Все ограничения имеют собственные имена.

```sql
USE Lab06;
GO

CREATE TABLE lab06.Customer
(
    CustomerID INT NOT NULL
        CONSTRAINT PK_Customer PRIMARY KEY,
    Name NVARCHAR(100) NOT NULL,
    City NVARCHAR(50) NOT NULL,
    Email NVARCHAR(100) NULL
        CONSTRAINT UQ_Customer_Email UNIQUE,
    CreatedAt DATETIME2 NOT NULL
        CONSTRAINT DF_Customer_CreatedAt
        DEFAULT SYSDATETIME()
);
GO

CREATE TABLE lab06.Product
(
    ProductID INT NOT NULL
        CONSTRAINT PK_Product PRIMARY KEY,
    Name NVARCHAR(100) NOT NULL,
    Price DECIMAL(10,2) NOT NULL
        CONSTRAINT CK_Product_Price CHECK (Price >= 0)
);
GO
```

**#### 3. Создание таблиц Orders и OrderLine — `03.sql`**

В схеме `lab06` созданы таблицы `Orders` и `OrderLine` в соответствии с требованиями задания.

Таблица `Orders` содержит информацию о заказах. Для идентификатора заказа настроена автоматическая нумерация. Также заданы первичный ключ, внешний ключ на таблицу `Customer` и значение даты заказа по умолчанию.

Таблица `OrderLine` содержит позиции заказов. Для неё заданы внешние ключи на таблицы `Orders` и `Product`, ограничение, запрещающее количество товара меньше или равное нулю, а также составной первичный ключ из столбцов `OrderID` и `ProductID`.

Для внешнего ключа `OrderID` настроено каскадное удаление (`ON DELETE CASCADE`), благодаря которому при удалении заказа автоматически удаляются связанные с ним позиции.

Все ограничения имеют собственные имена.

```sql
USE Lab06;
GO

CREATE TABLE lab06.Orders
(
    OrderID INT IDENTITY(1,1) NOT NULL
        CONSTRAINT PK_Orders PRIMARY KEY,
    OrderDate DATE NOT NULL
        CONSTRAINT DF_Orders_OrderDate
        DEFAULT CAST(GETDATE() AS DATE),
    CustomerID INT NOT NULL
        CONSTRAINT FK_Orders_Customer
        REFERENCES lab06.Customer(CustomerID)
);
GO

CREATE TABLE lab06.OrderLine
(
    OrderID INT NOT NULL
        CONSTRAINT FK_OrderLine_Orders
        REFERENCES lab06.Orders(OrderID)
        ON DELETE CASCADE,
    ProductID INT NOT NULL
        CONSTRAINT FK_OrderLine_Product
        REFERENCES lab06.Product(ProductID),
    Qty INT NOT NULL
        CONSTRAINT CK_OrderLine_Qty CHECK (Qty > 0),
    
    CONSTRAINT PK_OrderLine
        PRIMARY KEY (OrderID, ProductID)
);
GO
```

**### 4. Заполнение таблиц и проверка ограничений — директория `04\`.**

**#### 1. Добавление тестовых данных — `01_insert.sql`**

В таблицы `Customer`, `Product`, `Orders` и `OrderLine` добавлены тестовые данные.

Добавлены три клиента, один из которых не имеет указанного адреса электронной почты, три товара, два заказа и четыре позиции заказов (по две позиции в каждом заказе).

```sql
USE Lab06;
GO

INSERT INTO lab06.Customer (CustomerID, Name, City, Email)
VALUES
    (1, N'Иван Иванов', N'Москва', N'ivan@example.com'),
    (2, N'Егор Загребин', N'Москва', NULL),
    (3, N'Анастасия Валова', N'Москва', N'valova@example.com');
GO

INSERT INTO lab06.Product (ProductID, Name, Price)
VALUES
    (1, N'Велосипед', 75000.00),
    (2, N'MacBook Pro M4', 150000.00),
    (3, N'Magic Mouse', 10000.00);
GO

INSERT INTO lab06.Orders (CustomerID)
VALUES
    (1),
    (2);
GO

INSERT INTO lab06.OrderLine (OrderID, ProductID, Qty)
VALUES
    (1, 1, 1),
    (1, 2, 2),
    (2, 2, 1),
    (2, 3, 1);
GO
```

**Результат:** все тестовые данные успешно добавлены.

**#### 2. Проверка ограничения на отрицательную цену — `02_price.sql`**

Выполнена попытка добавить товар с отрицательной ценой для проверки ограничения `CK_Product_Price`.

```sql
USE Lab06;
GO

INSERT INTO lab06.Product (ProductID, Name, Price)
VALUES
    (4, N'Тестовый товар', -100.00);
GO
```

**Результат:** добавление товара отклонено ограничением `CK_Product_Price`.

**Текст ошибки SQL Server:**

The INSERT statement conflicted with the CHECK constraint "CK_Product_Price". The conflict occurred in database "Lab06", table "lab06.Product", column 'Price'.


**#### 3. Проверка внешнего ключа ProductID — `03_product_id.sql`**

Выполнена попытка добавить позицию заказа с несуществующим идентификатором товара (`ProductID = 999`) для проверки внешнего ключа `FK_OrderLine_Product`.

```sql
USE Lab06;
GO

INSERT INTO lab06.OrderLine (OrderID, ProductID, Qty)
VALUES
    (1, 999, 1);
GO
```

**Результат:** добавление позиции заказа отклонено ограничением `FK_OrderLine_Product`.

**Текст ошибки SQL Server:**

The INSERT statement conflicted with the FOREIGN KEY constraint "FK_OrderLine_Product". The conflict occurred in database "Lab06", table "lab06.Product", column 'ProductID'.

**#### 4. Проверка уникальности Email — `04_email.sql`**

Выполнена попытка добавить клиента с уже существующим адресом электронной почты (`ivan@example.com`) для проверки ограничения `UQ_Customer_Email`.

```sql
USE Lab06;
GO

INSERT INTO lab06.Customer (CustomerID, Name, City, Email)
VALUES
    (4, N'Тестовый клиент', N'Москва', N'ivan@example.com');
GO
```

**Результат:** добавление клиента отклонено ограничением `UQ_Customer_Email`.

**Текст ошибки SQL Server:**

Violation of UNIQUE KEY constraint 'UQ_Customer_Email'. Cannot insert duplicate key in object 'lab06.Customer'. The duplicate key value is (ivan@example.com).


**#### 5. Проверка добавления второго клиента без Email — `05_null_email.sql`**

Выполнена попытка добавить второго клиента без указанного адреса электронной почты (`Email = NULL`) для проверки ограничения `UQ_Customer_Email`.

```sql
USE Lab06;
GO

INSERT INTO lab06.Customer (CustomerID, Name, City, Email)
VALUES
    (5, N'Новый клиент', N'Самара', NULL);
GO
```

**Текст ошибки SQL Server:**

Violation of UNIQUE KEY constraint 'UQ_Customer_Email'. Cannot insert duplicate key in object 'lab06.Customer'. The duplicate key value is (<NULL>).

**## Задание 2. Изменение структуры (ALTER)**

**### Задание выполнено в директории `DBCourseLabs\lab06\task02`.**

**#### 1. Добавление нового столбца — `01.sql`**

В таблицу `lab06.Customer` был добавлен новый необязательный столбец `Phone` для хранения номера телефона. Для него использован тип `NVARCHAR(20)`, который позволяет хранить строку Unicode длиной до 20 символов. Столбец допускает значения `NULL`, поэтому номер телефона можно не указывать.

```sql
USE Lab06;
GO

ALTER TABLE lab06.Customer
ADD Phone NVARCHAR(20) NULL;
GO
```

**#### 2. Изменение типа столбцов — `02.sql`**

Сначала длина столбца `Phone` была увеличена до 30 символов. Затем длина столбца `Name` была увеличена до 150 символов. При изменении `Name` допустимость значений `NULL` специально не указывалась.

После этого с помощью представления `INFORMATION_SCHEMA.COLUMNS` была выполнена проверка признака `IS_NULLABLE` для столбцов `Phone` и `Name`.

В результате у столбца `Name` значение `IS_NULLABLE` изменилось на `YES`. Это произошло потому, что при изменении столбца без указания `NULL` или `NOT NULL` SQL Server разрешает хранить в нём пустое значение `NULL`.

В конце исходное ограничение столбца `Name` было восстановлено: длина возвращена к 100 символам, а возможность хранения `NULL` снова запрещена.

```sql
USE Lab06;
GO

ALTER TABLE lab06.Customer
ALTER COLUMN Phone NVARCHAR(30) NULL;
GO

ALTER TABLE lab06.Customer
ALTER COLUMN Name NVARCHAR(150);
GO

SELECT
    COLUMN_NAME,
    IS_NULLABLE
FROM INFORMATION_SCHEMA.COLUMNS
WHERE TABLE_SCHEMA = 'lab06'
    AND TABLE_NAME = 'Customer'
    AND COLUMN_NAME IN ('Phone', 'Name');
GO

ALTER TABLE lab06.Customer
ALTER COLUMN Name NVARCHAR(100) NOT NULL;
GO
```

**#### 3. Добавление ограничения на email — директория `03`.**

**##### 3.1. Добавление клиента с неправильным email — `01_wrong_email.sql`**

Сначала в таблицу `lab06.Customer` был добавлен клиент с email, в котором отсутствует символ `@`. Это необходимо для проверки ограничения на уже существующих данных.

```sql
USE Lab06;
GO

INSERT INTO lab06.Customer (CustomerID, Name, City, Email)
VALUES
    (6, N'Тестовый клиент', N'Москва', N'wrong-email');
GO
```

**##### 3.2. Попытка добавить ограничение — `02_constraint.sql`**

Была выполнена попытка добавить ограничение `CK_Customer_Email`, которое требует наличия символа `@` в email.

```sql
USE Lab06;
GO

ALTER TABLE lab06.Customer
ADD CONSTRAINT CK_Customer_Email
CHECK (Email LIKE '%@%');
GO
```

При выполнении команды возникла ошибка, так как в таблице уже находилась запись с email `wrong-email`, которая не соответствует условию ограничения. SQL Server проверяет существующие данные при добавлении ограничения и не позволяет добавить его, если данные нарушают заданное условие.

**##### 3.3. Исправление данных и добавление ограничения — `03_update.sql`**

Чтобы ограничение можно было добавить, сначала был исправлен email клиента с `CustomerID = 6`. После этого ограничение `CK_Customer_Email` было успешно добавлено.

```sql
USE Lab06;
GO

UPDATE lab06.Customer
SET Email = N'test@example.com'
WHERE CustomerID = 6;
GO

ALTER TABLE lab06.Customer
ADD CONSTRAINT CK_Customer_Email
CHECK (Email LIKE '%@%');
GO
```

**##### 3.4. Проверка значения NULL — `04_null_email.sql`**

Для проверки было выполнено добавление клиента, у которого значение email равно `NULL`.

```sql
USE Lab06;
GO

INSERT INTO lab06.Customer (CustomerID, Name, City, Email)
VALUES
    (7, N'Клиент без почты', N'Самара', NULL);
GO
```

Запись добавилась успешно. Это происходит потому, что ограничение `CHECK` не запрещает значение `NULL`. 

**##### 3.5. Проверка добавления ограничения с WITH NOCHECK — `05_nocheck.sql`**

Сначала существующее ограничение было удалено. Затем в таблицу был добавлен клиент с неправильным email. После этого ограничение было добавлено с использованием `WITH NOCHECK`.

```sql
USE Lab06;
GO

ALTER TABLE lab06.Customer
DROP CONSTRAINT CK_Customer_Email;
GO

INSERT INTO lab06.Customer (CustomerID, Name, City, Email)
VALUES (8, N'тестовый клиент 2', N'Чебоксары', N'wrong-email');
GO

ALTER TABLE lab06.Customer WITH NOCHECK
ADD CONSTRAINT CK_Customer_Email
CHECK (Email LIKE '%@%');
GO
```

Ограничение добавилось успешно, несмотря на наличие неправильного email. Это произошло потому, что `WITH NOCHECK` отключает проверку уже существующих записей при добавлении ограничения. При этом новые и изменяемые записи продолжают проверяться.


**##### 3.6. Исправление данных и включение полной проверки — `06_back_to_correct.sql`**

```sql
USE Lab06;
GO

UPDATE lab06.Customer
SET Email = N'correct@example.com'
WHERE CustomerID = 8;

ALTER TABLE lab06.Customer
WITH CHECK CHECK CONSTRAINT CK_Customer_Email;
GO
```

**## Задание 4. Удаление и очистка (DROP, TRUNCATE)**

**### Задание выполнено в директории `DBCourseLabs\lab06\task04`.**

**#### 1. Создание таблицы и добавление данных — `01_create.sql`**

Была создана таблица `lab06.AuditLog` с двумя столбцами: `LogID` и `Message`. 
После создания таблицы в неё были добавлены три записи.

```sql
USE Lab06;
GO

CREATE TABLE lab06.AuditLog
(
    LogID INT NOT NULL
        CONSTRAINT PK_AuditLog PRIMARY KEY,
    Message NVARCHAR(100)
);
GO

INSERT INTO lab06.AuditLog (LogID, Message)
VALUES
    (1, N'Сообщение 1'),
    (2, N'Сообщение 2'),
    (3, N'Сообщение 3');
GO
```

**#### 2. Удаление записей с помощью DELETE — `02_delete.sql`**

Для удаления всех записей из таблицы `lab06.AuditLog` была использована команда `DELETE`.

```sql
USE Lab06;
GO

DELETE FROM lab06.AuditLog;
GO
```

В результате все три записи были удалены, но сама таблица осталась в базе данных. 

**#### 3. Проверка TRUNCATE TABLE — `03_truncate.sql`**

Была выполнена попытка очистить таблицу `lab06.Orders` с помощью команды `TRUNCATE TABLE`.

```sql
USE Lab06;
GO

TRUNCATE TABLE lab06.Orders;
GO
```

При выполнении команды возникла ошибка. Это произошло потому, что на таблицу `lab06.Orders` ссылается таблица `lab06.OrderLine` через внешний ключ `FK_OrderLine_Orders`.

**## Задание 5. Получение информации о ценах на товары**

**### Задание выполнено в директории `DBCourseLabs\lab06\task05`.**

**#### 1. Товары с прейскурантной ценой выше средней — `01.sql`**

Получение товаров, у которых прейскурантная цена выше средней цены продажи всех товаров.

```sql
USE AdventureWorksLT2019;
GO

SELECT
    ProductID,
    Name,
    ListPrice
FROM SalesLT.Product
WHERE ListPrice >
(
    SELECT AVG(UnitPrice)
    FROM SalesLT.SalesOrderDetail
)
ORDER BY ProductID;
GO
```

**#### 2. Товары с ценой от 100 долларов, проданные дешевле 100 долларов — `02.sql`**

Получение товаров с прейскурантной ценой от 100 долларов, которые хотя бы один раз продавались дешевле 100 долларов.

```sql
USE AdventureWorksLT2019;
GO

SELECT
    ProductID,
    Name,
    ListPrice
FROM SalesLT.Product
WHERE ListPrice >= 100
  AND ProductID IN
  (
      SELECT ProductID
      FROM SalesLT.SalesOrderDetail
      WHERE UnitPrice < 100
  )
ORDER BY ProductID;
GO
```

**#### 3. Себестоимость, прейскурантная цена и средняя цена продажи — `03.sql`**

Получение себестоимости, прейскурантной цены и средней цены продажи для каждого товара.

```sql
USE AdventureWorksLT2019;
GO

SELECT
    p.ProductID,
    p.Name,
    p.StandardCost,
    p.ListPrice,
    (
        SELECT AVG(d.UnitPrice)
        FROM SalesLT.SalesOrderDetail AS d
        WHERE d.ProductID = p.ProductID
    ) AS AvgSellingPrice
FROM SalesLT.Product AS p
ORDER BY p.ProductID;
GO
```

**#### 4. Товары со средней ценой продажи ниже себестоимости — `04.sql`**

Получение товаров, у которых себестоимость выше средней цены продажи.

```sql
USE AdventureWorksLT2019;
GO

SELECT
    p.ProductID,
    p.Name,
    p.StandardCost,
    p.ListPrice,
    (
        SELECT AVG(d.UnitPrice)
        FROM SalesLT.SalesOrderDetail AS d
        WHERE d.ProductID = p.ProductID
    ) AS AvgSellingPrice
FROM SalesLT.Product AS p
WHERE p.StandardCost >
(
    SELECT AVG(d.UnitPrice)
    FROM SalesLT.SalesOrderDetail AS d
    WHERE d.ProductID = p.ProductID
)
ORDER BY p.ProductID;
GO
```

**## Задание 6. Получение информации о клиенте**

**### Задание выполнено в директории `DBCourseLabs\lab06\task06`.**

**#### 1. Получение информации о клиентах для всех заказов — `01.sql`**

Получение информации о клиентах для каждого заказа с использованием функции `dbo.ufnGetCustomerInformation`.

```sql
USE AdventureWorksLT2019;
GO

SELECT
    soh.SalesOrderID,
    soh.CustomerID,
    ci.FirstName,
    ci.LastName,
    soh.TotalDue
FROM SalesLT.SalesOrderHeader AS soh
CROSS APPLY dbo.ufnGetCustomerInformation(soh.CustomerID) AS ci
ORDER BY soh.SalesOrderID;
GO
```

**#### 2. Получение информации об адресе клиента — `02.sql`**

Получение данных о клиентах и их адресах с использованием функции `dbo.ufnGetCustomerInformation`.

```sql
USE AdventureWorksLT2019;
GO

SELECT
    ca.CustomerID,
    ci.FirstName,
    ci.LastName,
    a.AddressLine1,
    a.City
FROM SalesLT.CustomerAddress AS ca
JOIN SalesLT.Address AS a
    ON ca.AddressID = a.AddressID
CROSS APPLY dbo.ufnGetCustomerInformation(ca.CustomerID) AS ci
ORDER BY ca.CustomerID;
GO
```