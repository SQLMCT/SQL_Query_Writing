USE AdventureWorks2016
GO

--Use the * to SELECT all the columns from a table
SELECT * FROM Person.Person

--It is best practice to choose specific columns
--For performance only retrieve what you need.
SELECT FirstName, LastName
FROM Person.Person

--You can also sort your results with an OrderBy statement
SELECT FirstName, LastName
FROM Person.Person
ORDER BY LastName DESC, FirstName ASC

--Filtering Records for a single row (Numbers)
SELECT FirstName, LastName
FROM Person.Person
WHERE BusinessEntityID = 4

--Filtering for multiple rows (Numbers)
SELECT FirstName, LastName
FROM Person.Person
WHERE BusinessEntityID = 4 or BusinessEntityID = 6

--Filtering for multiple rows using the IN predicate (Numbers)
SELECT FirstName, LastName
FROM Person.Person
WHERE BusinessEntityID IN (4, 6)

--Filtering Records for a single row (Text)
SELECT FirstName, LastName
FROM Person.Person
WHERE LastName = 'Gates'

--Filtering using the LIKE statement and %
SELECT FirstName, LastName
FROM Person.Person
WHERE LastName LIKE 'G%'

--Filtering using the LIKE statement and _
SELECT FirstName, LastName
FROM Person.Person
WHERE LastName LIKE '_a%'

--Filtering Records for NULL values
SELECT FirstName, LastName, MiddleName
FROM Person.Person
WHERE MiddleName IS NULL

--Filtering Records for NULL values
SELECT FirstName, LastName, MiddleName
FROM Person.Person
WHERE MiddleName IS NOT NULL







