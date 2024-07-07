-- TRIGGER
-- ========================================
/* A trigger in SQL is a special kind of stored procedure that automatically executes or fires
   when certain events occur in the database. Triggers can be used to enforce business rules, 
   validate data integrity, and maintain audit trails.

   # Types of Triggers
   -------------------
   1. DML Triggers (Data Manipulation Language):
      -) AFTER Triggers: Execute after an INSERT, UPDATE, or DELETE operation on a table.
      -) INSTEAD OF Triggers: Execute in place of an INSERT, UPDATE, or DELETE operation on a table or view.

   2. DDL Triggers (Data Definition Language):
      Fire in response to DDL events like CREATE, ALTER, and DROP statements.

   3. Logon Triggers:
      Fire in response to logon events. They are used to control and manage login activities in SQL Server.
*/
SELECT *
FROM Staff
GO

-- 1. DML Triggers
CREATE OR ALTER TRIGGER InsertStaff 
ON Staff
FOR INSERT 
AS
BEGIN
    DECLARE @staffAge INT
    SELECT @staffAge = StaffAge FROM INSERTED

    IF @staffAge IS NOT NULL AND @staffAge < 20
    BEGIN
        RAISERROR ('The staff age is not qualified', 16, 1)
        ROLLBACK TRANSACTION
    END
    ELSE IF @staffAge IS NOT NULL AND @staffAge >= 20
    BEGIN
        PRINT 'Staff qualified'
    END
    ELSE 
    BEGIN
        RAISERROR ('Staff age cannot be empty', 16, 1)
        ROLLBACK TRANSACTION
    END
END
GO

--
INSERT INTO Staff (StaffId, StaffName, StaffAge, Salary, JoinDate)
VALUES('S023', 'Sarah Martinez', 27, 45000, '2024-07-07')
GO
-- ================================================================

-- 2. DDL Triggers
CREATE TRIGGER safety   
ON DATABASE   
FOR DROP_TABLE, ALTER_TABLE   
AS   
   PRINT 'You must disable Trigger "safety" to drop or alter tables!'   
   ROLLBACK; 
--
DROP TABLE orders
-- ==================================================================
