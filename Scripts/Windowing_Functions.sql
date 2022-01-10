USE AdventureWorks2016
GO
/*******************************************************
Demonstration Clean-up
DROP VIEW Sales.Product_Sales_By_Year
DROP TABLE Production.ProductsSold
********************************************************/

/*******************************************************
--Demonstration Setup for Windowing Functions
********************************************************/

CREATE OR ALTER VIEW Sales.Product_Sales_By_Year
AS
SELECT P.Name AS ProductName,
	   SUM(SOD.OrderQty) AS Quantity, 
	   YEAR(OrderDate) AS OrderYear
FROM Production.Product AS P
	JOIN Sales.SalesOrderDetail AS SOD
		ON P.ProductID = SOD.ProductID
	JOIN Sales.SalesOrderHeader AS SOH
		ON SOH.SalesOrderID = SOD.SalesOrderID
GROUP BY P.Name, YEAR(OrderDate);
GO

--Look at the sample data
SELECT ProductName, Quantity, OrderYear
FROM Sales.Product_Sales_By_Year


--Create a Windowing over the Sales Data using the OVER clause.
--The Window will be created OVER the entire result set.

SELECT ProductName, Quantity, OrderYear,
	SUM(Quantity) OVER() AS TotalQuantity
FROM Sales.Product_Sales_By_Year

--First order the results by ProductName.
--Then change the order to OrderYear
SELECT ProductName, Quantity, OrderYear,
	SUM(Quantity) OVER(ORDER BY OrderYear) AS TotalQuantity
FROM Sales.Product_Sales_By_Year
WHERE ProductName LIKE '%Mountain Frame%'

--Partition By ProductName (Partition By has to be before Order By)
--After the Partition By, filter records for Mountain Frames
SELECT ProductName, Quantity, OrderYear,
	SUM(Quantity) OVER(
	PARTITION BY ProductName
	ORDER BY OrderYear
	) AS RunningTotal
FROM Sales.Product_Sales_By_Year
WHERE ProductName LIKE '%Mountain Frame%'

--Demonstrate Rows Between Unbounded Preceding and Current Row
--This is the default of not specified
SELECT ProductName, Quantity, OrderYear,
	SUM(Quantity) OVER(
	PARTITION BY ProductName
	ORDER BY OrderYear 
	ROWS BETWEEN UNBOUNDED PRECEDING and CURRENT ROW) AS RunningTotal
FROM Sales.Product_Sales_By_Year
WHERE ProductName LIKE '%Mountain Frame%'

--Demonstrate Rows Between Current Row and Unbounded Following
SELECT ProductName, Quantity, OrderYear,
	SUM(Quantity) OVER(
	PARTITION BY ProductName
	ORDER BY OrderYear
	ROWS BETWEEN CURRENT ROW and UNBOUNDED FOLLOWING) AS RunningTotal
FROM Sales.Product_Sales_By_Year
WHERE ProductName LIKE '%Mountain Frame%'

--Demonstrate Rows Between 1 Row Preceding and Current Row
SELECT ProductName, Quantity, OrderYear,
	SUM(Quantity) OVER(
	PARTITION BY ProductName
	ORDER BY OrderYear 
	ROWS BETWEEN 1 PRECEDING and CURRENT ROW) AS AddPrevYear
FROM Sales.Product_Sales_By_Year
WHERE ProductName LIKE '%Mountain Frame%'

--Demonstrate LAG Function
SELECT ProductName, Quantity, OrderYear,
	LAG(Quantity, 1) OVER(
	PARTITION BY ProductName
	ORDER BY OrderYear) AS PreviousYear
FROM Sales.Product_Sales_By_Year
WHERE ProductName LIKE '%Mountain Frame%'

--Demonstrate LEAD Function
SELECT ProductName, Quantity, OrderYear,
	LEAD(Quantity, 1) OVER(
	PARTITION BY ProductName
	ORDER BY OrderYear) AS NextYear
FROM Sales.Product_Sales_By_Year
WHERE ProductName LIKE '%Mountain Frame%'


/*******************************************************
Demonstrate RANK, DENSE_RANK, Row_Number, and NTILE Functions
********************************************************/
CREATE TABLE Production.ProductsSold
(ID tinyint IDENTITY, Name VARCHAR(10), Sold smallint);
GO

INSERT INTO Production.ProductsSold
VALUES ('John', 2200), ('Diedre', 2100),
	   ('Greg', 2000), ('Elizabeth', 1800),
	   ('Breanna', 1800), ('Jeff', 1500),
	   ('Ken', 1500), ('Cassie', 1300)
GO

SELECT Name, Sold, 
RANK() OVER(Order By Sold DESC) as 'Rank', 
DENSE_RANK() OVER(Order By Sold DESC) as 'Dense',
ROW_NUMBER() OVER(Order By Sold DESC) as 'RowNum',
NTILE(2) OVER(Order By Sold DESC) as 'NTile(2)'
FROM Production.ProductsSold




