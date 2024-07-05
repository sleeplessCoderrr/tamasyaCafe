--STORED PROCEDURE
--===========================================================================================================
/*A stored procedure is a prepared SQL code that you can save, so the code can be reused over and over again.
So if you have an SQL query that you write over and over again, save it as a stored procedure, and then just 
call it to execute it.You can also pass parameters to a stored procedure, so that the stored procedure can act
based on the parameter value(s) that is passed.
- BENEFITS
1. Reduced server/client network traffic
   The commands in a procedure are executed as a single batch of code. This can significantly reduce network
   traffic between the server and client because only the call to execute the procedure is sent across the network.
2. Stronger security
   Multiple users and client programs can perform operations on underlying database objects through a procedure,
   even if the users and programs don't have direct permissions on those underlying objects
3. Reuse of code
   The code for any repetitious database operation is the perfect candidate for encapsulation in procedures.
   This eliminates needless rewrites of the same code, decreases code inconsistency, and allows the access
   and execution of code by any user or application possessing the necessary permissions.
4. Easier maintenance
   When client applications call procedures and keep database operations in the data tier, only the procedures
   must be updated for any changes in the underlying database.
5. Improved performance
   By default, a procedure compiles the first time it's executed, and creates an execution plan that is reused
   for subsequent executions.
*/
--============================================================================================================

USE TamasyaCafe
SELECT *
FROM customer

GO
CREATE OR ALTER PROCEDURE searchCustomer
(@customerName VARCHAR(MAX) = NULL)
AS
BEGIN
	SELECT CustomerName AS [Name], CustomerPoint AS [Point]
	FROM customer
	WHERE CustomerName = @customerName
END
GO

EXEC searchCustomer [Graisu Citasya]