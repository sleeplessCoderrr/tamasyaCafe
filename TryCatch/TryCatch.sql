-- TRY CATCH
-- ========================================
/* Implements error handling for Transact-SQL that is similar to the exception handling in the 
   Microsoft Visual C# and Microsoft Visual C++ languages. A group of Transact-SQL statements 
   can be enclosed in a TRY block. If an error occurs in the TRY block, control is usually 
   passed to another group of statements that is enclosed in a CATCH block.
   
   #Retrieving Error Information
   ------------------------------
   In the scope of a CATCH block, the following system functions can be used to obtain 
   information about the error that caused the CATCH block to be executed:
   1. ERROR_NUMBER() returns the number of the error.
   2. ERROR_SEVERITY() returns the severity.
   3. ERROR_STATE() returns the error state number.
   4. ERROR_PROCEDURE() returns the name of the stored procedure or trigger where the error occurred.
   5. ERROR_LINE() returns the line number inside the routine that caused the error.
   6. ERROR_MESSAGE() returns the complete text of the error message. The text includes the values 
      supplied for anysubstitutable parameters, such as lengths, object names, or times.*/

CREATE PROCEDURE usp_GetErrorInfo  
AS  
SELECT  
    ERROR_NUMBER() AS ErrorNumber  
    ,ERROR_SEVERITY() AS ErrorSeverity  
    ,ERROR_STATE() AS ErrorState  
    ,ERROR_PROCEDURE() AS ErrorProcedure  
    ,ERROR_LINE() AS ErrorLine  
    ,ERROR_MESSAGE() AS ErrorMessage;  
GO  
-- SIMPLE TRY CATCH
BEGIN TRY  
    SELECT 1/0;  
END TRY  
BEGIN CATCH  
    EXECUTE usp_GetErrorInfo;  
END CATCH;
-- ==========================================================

-- TRY CATCH When Inserting
BEGIN TRY 
	INSERT INTO customer 
	(CustomerId, CustomerName, CustomerPoint)
	VALUES 
		('ABCD7467', 'Unknown', 846)
	PRINT [Successfully added]
END TRY
BEGIN CATCH 
	PRINT 'Eror Occured'
	SELECT ERROR_MESSAGE() AS ErrorMessage
END CATCH
-- ==========================================================