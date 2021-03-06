USE [<enter database name>]
GO
SELECT T.name AS table_name,
SCHEMA_NAME(schema_id) AS schema_name,
C.name AS column_name
FROM sys.[tables] AS T  
JOIN sys.columns C ON T.OBJECT_ID = C.OBJECT_ID
WHERE C.name LIKE '%<enter column name>%'     --Adjust this line to search on column or table
ORDER BY schema_name, table_name;
