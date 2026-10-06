SELECT 
    'Категории' AS Источник,
    pc.name AS Название
FROM production.productcategory AS pc

UNION ALL

SELECT
    'Модели' AS Источник,
    pm.name AS Название
FROM production.productmodel AS pm;