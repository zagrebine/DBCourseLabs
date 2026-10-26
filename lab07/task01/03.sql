USE AdventureWorksLT2019;

DROP TABLE IF EXISTS #UniqueSizes;

CREATE TABLE #UniqueSizes (
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

