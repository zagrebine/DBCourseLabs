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

