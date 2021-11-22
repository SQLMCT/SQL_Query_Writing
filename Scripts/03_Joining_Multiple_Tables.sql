USE AdventureWorks2016
GO
--Use Tables that are included with the AdventureWorksLT database
--Joining Muliple Tables
SELECT SOH.SalesOrderID, SOH.CustomerID,
	OrderQty, UnitPrice, P.Name
FROM Sales.SalesOrderHeader AS SOH
	JOIN Sales.SalesOrderDetail AS SOD
		ON SOH.SalesOrderID = SOD.SalesOrderID
	JOIN Production.Product AS P
		ON P.ProductID = SOD.ProductID

--Run 03_Create_Join_Demo_Tables.sql script found at
--https://github.com/SQLMCT/SQLSlides
--under the Query_Writing folder.

--SELECT using an Inner Join
SELECT CustomerID, Last_Name, Qty
FROM Demo.Customers AS C
INNER JOIN Demo.Orders AS O
ON C.CustomerID = O.CustID

--SELECT using a Left Outer Join
SELECT CustomerID, Last_Name, Qty
FROM Demo.Customers AS C
LEFT OUTER JOIN Demo.Orders AS O
ON C.CustomerID = O.CustID
--WHERE O.Qty IS NULL --To only records from Parent table.

--SELECT using a RIGHT Outer Join
SELECT CustomerID, Last_Name, Qty
FROM Demo.Customers AS C
RIGHT OUTER JOIN Demo.Orders AS O
ON C.CustomerID = O.CustID
WHERE Last_Name IS NULL --To only see records from Child table.

--SELECT using a FULL Outer Join
SELECT CustomerID, Last_Name, Qty
FROM Demo.Customers AS C
FULL OUTER JOIN Demo.Orders AS O
ON C.CustomerID = O.CustID