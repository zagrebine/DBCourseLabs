# Lab04 — PostgreSQL Environment Setup

## 1. Prerequisites

* macOS
* Docker Desktop
* VS Code
* VS Code extensions:

  * PostgreSQL — `ms-ossdata.vscode-pgsql`
  * PostgreSQL Syntax — `felixfbecker.postgresql-syntax`

---

## 2. Start Docker Desktop

Перед работой с PostgreSQL необходимо запустить Docker Desktop.

Проверка:

```bash
docker version
docker ps
```

Если Docker не запущен, команды Docker завершаются ошибкой подключения к Docker API.

---

## 3. PostgreSQL Docker Volume

Создан отдельный Docker volume для хранения данных PostgreSQL:

```bash
docker volume create postgresql_data
```

Данные PostgreSQL хранятся в этом volume, поэтому контейнер можно остановить и запустить снова без потери базы данных.

---

## 4. PostgreSQL Container

Создан контейнер PostgreSQL:

```bash
docker run -d \
  --name postgresql \
  -e POSTGRES_USER=postgres \
  -e POSTGRES_PASSWORD='<POSTGRES_PASSWORD>' \
  -e POSTGRES_DB=advworks_lt \
  -p 5432:5432 \
  -v postgresql_data:/var/lib/postgresql/data \
  postgres:16
```

### Configuration

| Parameter | Value             |
| --------- | ----------------- |
| Image     | `postgres:16`     |
| Container | `postgresql`      |
| Database  | `advworks_lt`     |
| User      | `postgres`        |
| Host      | `localhost`       |
| Port      | `5432`            |
| Volume    | `postgresql_data` |

> Пароль не хранится в README. Использовать пароль, заданный при создании контейнера.

Проверка контейнера:

```bash
docker ps
```

Ожидаемый результат — контейнер `postgresql` находится в состоянии `Up`, а порт `5432` проброшен на host.

---

## 5. Connect to PostgreSQL from Terminal

Подключение к базе:

```bash
docker exec -it postgresql psql -U postgres -d advworks_lt
```

После подключения можно проверить схемы:

```sql
\dn
```

Изначально в базе была только схема:

```text
public
```

---

## 6. Install `pgcrypto`

Для работы предоставленного PostgreSQL-скрипта была установлена extension `pgcrypto`:

```bash
docker exec -i postgresql \
  psql -U postgres -d advworks_lt \
  -c "CREATE EXTENSION IF NOT EXISTS pgcrypto;"
```

Результат:

```text
CREATE EXTENSION
```

---

## 7. Create AdventureWorksLT Schema

В проекте используются следующие файлы:

```text
lab04/
└── utils/
    ├── adventureworks_lt_postgres.sql
    └── adventureworks_lt_postgres_data.sql
```

Сначала был выполнен schema script:

```bash
docker exec -i postgresql \
  psql -U postgres -d advworks_lt \
  < lab04/utils/adventureworks_lt_postgres.sql
```

Скрипт создал схему AdventureWorksLT для PostgreSQL.

После выполнения появились схемы:

```text
production
public
sales
```

### Production tables

```text
production.product
production.productcategory
production.productmodel
```

### Sales tables

```text
sales.address
sales.customer
sales.customeraddress
sales.employee
sales.salesorderdetail
sales.salesorderheader
```

### Views

```text
sales.vcustomeraddresses
sales.vproductanddescription
```

Также скрипт создал необходимые indexes.

---

## 8. Load AdventureWorksLT Data

После создания структуры базы был выполнен data script:

```bash
docker exec -i postgresql \
  psql -U postgres -d advworks_lt \
  < lab04/utils/adventureworks_lt_postgres_data.sql
```

Скрипт выполнился внутри transaction:

```text
BEGIN
...
COMMIT
ANALYZE
```

---

## 9. Data Verification

Были проверены основные таблицы.

### Products

```sql
SELECT COUNT(*) FROM production.product;
```

Result:

```text
30
```

### Customers

```sql
SELECT COUNT(*) FROM sales.customer;
```

Result:

```text
32
```

### Sales orders

```sql
SELECT COUNT(*) FROM sales.salesorderheader;
```

Result:

```text
18
```

### Sales order details

```sql
SELECT COUNT(*) FROM sales.salesorderdetail;
```

Result:

```text
34
```

---

## 10. VS Code PostgreSQL Connection

Для работы с PostgreSQL в VS Code была установлена extension:

```text
ms-ossdata.vscode-pgsql
```

Создано подключение:

| Parameter       | Value               |
| --------------- | ------------------- |
| Server Name     | `localhost`         |
| Authentication  | Password            |
| User Name       | `postgres`          |
| Database        | `advworks_lt`       |
| Connection Name | `PostgreSQL Docker` |
| Server Group    | `Servers`           |
| Save Password   | Enabled             |

Connection test завершился успешно.

В PostgreSQL explorer отображаются:

```text
production
public
sales
```

---

## 11. PostgreSQL Syntax Highlighting in VS Code

Изначально `.sql` файлы распознавались VS Code как `MSSQL`.

Это приводило к ложным T-SQL syntax errors, например:

```text
Incorrect syntax: 'CREATE SCHEMA' must be the only statement in the batch.
```

Чтобы PostgreSQL-файлы корректно подсвечивались, была установлена extension:

```text
felixfbecker.postgresql-syntax
```

После установки PostgreSQL syntax highlighting работает корректно.

---

## 12. Connect SQL File to PostgreSQL

Для выполнения SQL из VS Code необходимо подключить файл к PostgreSQL connection:

```text
PostgreSQL Docker
```

Подключение использует:

```text
localhost:5432
Database: advworks_lt
User: postgres
```

Например:

```sql
SELECT COUNT(*)
FROM production.product;
```

Результат выполнения из VS Code:

```text
30
```

Это подтверждает, что запрос выполняется непосредственно в PostgreSQL Docker container.

---

## 13. Current Lab04 Environment

В результате для Lab04 создано следующее окружение:

```text
VS Code
   │
   └── PostgreSQL Docker
           │
           ├── Host: localhost
           ├── Port: 5432
           ├── Database: advworks_lt
           └── Container: postgresql
                   │
                   └── postgres:16
                           │
                           └── postgresql_data
```

Database structure:

```text
advworks_lt
│
├── production
│   ├── product
│   ├── productcategory
│   └── productmodel
│
├── sales
│   ├── address
│   ├── customer
│   ├── customeraddress
│   ├── employee
│   ├── salesorderdetail
│   └── salesorderheader
│
└── public
```

---

## 14. Useful Commands

### Check running containers

```bash
docker ps
```

### Start PostgreSQL

```bash
docker start postgresql
```

### Stop PostgreSQL

```bash
docker stop postgresql
```

### Restart PostgreSQL

```bash
docker restart postgresql
```

### View PostgreSQL logs

```bash
docker logs postgresql
```

### Connect to database

```bash
docker exec -it postgresql psql -U postgres -d advworks_lt
```

### Check volume

```bash
docker volume inspect postgresql_data
```

---

## 15. Recreate Lab04 Database Structure

Если нужно заново создать структуру AdventureWorksLT, контейнер и volume пересоздавать **не требуется**.

Достаточно выполнить schema script:

```bash
docker exec -i postgresql \
  psql -U postgres -d advworks_lt \
  < lab04/utils/adventureworks_lt_postgres.sql
```

После этого снова загрузить данные:

```bash
docker exec -i postgresql \
  psql -U postgres -d advworks_lt \
  < lab04/utils/adventureworks_lt_postgres_data.sql
```

> `adventureworks_lt_postgres.sql` пересоздаёт схемы `production` и `sales` и удаляет существующие объекты этих схем. Поэтому после его повторного запуска необходимо снова выполнить `adventureworks_lt_postgres_data.sql`.

---

## 16. Normal Workflow for Lab04

Каждый раз перед работой:

### 1. Start Docker Desktop

### 2. Start PostgreSQL container if necessary

```bash
docker start postgresql
```

### 3. Open the Lab04 SQL files in VS Code

### 4. Select PostgreSQL syntax highlighting

### 5. Connect the SQL file to:

```text
PostgreSQL Docker
```

### 6. Execute SQL queries

Пример:

```sql
SELECT *
FROM production.product
LIMIT 10;
```

PostgreSQL database для Lab04 готова к работе.
