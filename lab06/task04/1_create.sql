USE Lab6_DDL;
GO

CREATE TABLE lab6.AuditLog
(
    LogID INT NOT NULL,
    Message NVARCHAR(100) NOT NULL,

    CONSTRAINT PK_AuditLog
        PRIMARY KEY (LogID)
);
GO

INSERT INTO lab6.AuditLog (LogID, Message)
VALUES
    (1, N'Создан клиент'),
    (2, N'Добавлен товар'),
    (3, N'Создан заказ');
GO

SELECT * FROM lab6.AuditLog;
GO