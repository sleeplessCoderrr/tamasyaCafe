-- USER DEFINED FUNCTION (UDF)
-- ========================================
/* Same like in another langueage a function can handle an operation inside the function body.
   A function is like a procedure but we required to return something from the function.
   There 2 common return type that is scalar (single value) or return a table. Since we can and
   need to return a value it's easier for us to make something like operation or data proccessing
   inside the function.
 */

-- #Scalar Return
-- ==========================================================
CREATE OR ALTER FUNCTION dbo.calcAvgPointByCoffe
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
-- ==========================================================


-- #Table Return
-- ==========================================================
CREATE OR ALTER FUNCTION showByCoffeType
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
SELECT * FROM showByCoffeType ('Kopi Susu Keluarga');
GO
-- ==========================================================


-- #Calling Function Inside of Another Function
-- ==========================================================
CREATE OR ALTER FUNCTION dbo.GetTamasyaTransactionData()
RETURNS TABLE
AS
RETURN (
    SELECT cs.CustomerId, cs.CustomerName, cs.CustomerPoint, od.OrderDate, 
           cf.BeverageName, cf.BeveragePrice, st.StaffName, st.StaffAge
    FROM customer cs
    JOIN orders od ON cs.CustomerId = od.CustomerId
    JOIN coffe cf ON cf.BeverageId = od.BeverageId
    JOIN Staff st ON st.StaffId = od.StaffId
);
GO
-----------------
CREATE OR ALTER FUNCTION dbo.calcAvgPointByCoffe
(@beverageName VARCHAR(MAX))
RETURNS INT
WITH EXECUTE AS CALLER
AS 
BEGIN
    DECLARE @averagePoint INT;

    SELECT @averagePoint = AVG(CustomerPoint)
    FROM dbo.GetTamasyaTransactionData()
    WHERE BeverageName = @beverageName;

    RETURN @averagePoint;
END;
GO
--
SELECT dbo.calcAvgPointByCoffe('Americano') AS AveragePoints;
GO
-- ==========================================================


-- #Multi-statement table-valued function (MSTV)
/* is a user-defined function that returns a table of rows and columns. Unlike a scalar function,
   which returns a singlevalue, a TVF can return multiple rows and columns. Multi-statement  function
   is very much similar to inline functions only difference is that in multi-statement function we
   need to define the structure of the table  and also having the Begin and End block. 
 */
-- ==========================================================
CREATE OR ALTER FUNCTION dbo.GetCustomerTransactions()
RETURNS @CustomerTransactions TABLE
(
    CustomerId CHAR(6) PRIMARY KEY,
    CustomerName VARCHAR(MAX),
    CustomerPoint INT,
    OrderDate DATETIME,
    BeverageName VARCHAR(MAX),
    BeveragePrice DECIMAL(18, 2)
)
AS
BEGIN
    -- Insert the results of the query into the table variable
    INSERT INTO @CustomerTransactions
    SELECT 
        cs.CustomerId, 
        cs.CustomerName, 
        cs.CustomerPoint, 
        od.OrderDate, 
        cf.BeverageName, 
        cf.BeveragePrice
    FROM 
        customer cs
        JOIN orders od ON cs.CustomerId = od.CustomerId
        JOIN coffe cf ON cf.BeverageId = od.BeverageId;

    RETURN;
END;
GO
--
SELECT *
FROM dbo.GetCustomerTransactions();
-- ==========================================================
