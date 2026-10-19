USE Lab6_DDL;
GO

EXEC sp_rename
    'lab6.Customer.Phone',
    'Mobile',
    'COLUMN';
GO