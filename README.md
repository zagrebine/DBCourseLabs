# Базы данных

## Лабораторные и семинарские работы

**Студент:** Загребин Егор Денисович
**Группа:** БИВТ-25-4-6
**Университет:** НИТУ МИСИС
**Дисциплина:** Базы данных

---

## О репозитории

Репозиторий содержит выполненные лабораторные и семинарские работы по дисциплине «Базы данных».

В рамках работ изучаются основы реляционных баз данных, язык SQL и его диалекты, создание и выполнение SQL-запросов, работа с таблицами и связями между ними, а также получение и обработка данных.

---

## Используемые технологии

* **PostgreSQL 16**
* **Microsoft SQL Server 2019**
* **SQL / Transact-SQL (T-SQL)**
* **Docker / Docker Desktop**
* **Visual Studio Code**
* **AdventureWorksLT**
* **Git / GitHub**

---

## Структура проекта

```text
DBCourseLabs/
│
├── Lab01/
│   └── ...
│
├── Lab02/
│   └── ...
│
├── Lab03/
│   └── ...
│
├── Lab04/
│   └── utils/
│       ├── adventureworks_lt_postgres.sql
│       └── adventureworks_lt_postgres_data.sql
│
└── README.md
```

Каждая лабораторная работа находится в отдельной директории.

---

## Среда выполнения

Работы выполняются в локальном окружении на macOS с использованием Docker Desktop и Visual Studio Code.

```text
MacBook
│
├── Visual Studio Code
│   └── Лабораторные и семинарские работы
│
└── Docker Desktop
    │
    ├── PostgreSQL 16
    │   └── AdventureWorksLT
    │
    └── Microsoft SQL Server 2019
        └── AdventureWorksLT
```

PostgreSQL и Microsoft SQL Server используются как отдельные среды выполнения в зависимости от конкретной лабораторной работы.
