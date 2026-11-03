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