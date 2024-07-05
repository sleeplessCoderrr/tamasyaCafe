-- FUNCTION
-- ========================================
/* Same like in another langueage a function can handle an operation inside the function body.
   A function is like a procedure but we required to return something from the function.
   There 2 common return type that is scalar (single value) or return a table. Since we can and
   need to return a value it's easier for us to make something like operation or data proccessing
   inside the function. */

CREATE OR ALTER PROCEDURE [TamasyaTransaction] 
AS BEGIN
	SELECT cs.CustomerId, cs.CustomerName, cs.CustomerPoint, od.OrderDate, 
	cf.BeverageName, cf.BeveragePrice, st.StaffName, st.StaffAge
	FROM customer cs
	JOIN orders od ON cs.CustomerId = od.CustomerId
	JOIN coffe cf ON cf.BeverageId = od.BeverageId
	JOIN Staff st ON st.StaffId = od.StaffId
END;
GO
-- #Scalar Return
------------------------------------------------
CREATE FUNCTION dbo.calcAvgPointByCoffe
(@beverageName VARCHAR(MAX))
RETURNS INT
WITH EXECUTE AS CALLER
AS 
BEGIN
	DECLARE @averagePoint INT
	SET @averagePoint = (
	SELECT AVG(cs.CustomerPoint)
	FROM customer cs
	JOIN orders od ON od.CustomerId = cs.CustomerId
	JOIN coffe cf ON cf.BeverageId = od.BeverageId
	WHERE cf.BeverageName = @beverageName);

	RETURN (@averagePoint);
END;
GO
-- Run the function
SELECT dbo.calcAvgPointByCoffe('Americano') AS AveragePoints;
GO
-------------------

-- #Table Return
------------------------------------------------
CREATE FUNCTION showByCoffeType
(@coffeName VARCHAR(MAX))
RETURNS TABLE
AS RETURN (
	SELECT cs.CustomerName AS [Name], cs.CustomerPoint AS [Point]
	FROM customer cs
	JOIN orders od ON od.CustomerId = cs.CustomerId
	JOIN coffe cf ON cf.BeverageId = od.BeverageId
	WHERE cf.BeverageName = @coffeName
);
GO
-- Run the function
SELECT * FROM showByCoffeType ('Americano');
-------------------

-- #Calling Procedure Inside Function
------------------------------------------------ 