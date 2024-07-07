-- CURSOR 
-- ========================================
/* In SQL Server Management Studio (SSMS), a cursor is a database object used to retrieve, 
   manipulate, and navigate through a result set row-by-row. While SQL is typically used to
   process sets of rows collectively, there are scenarios where you need to handle rows individually. 
   Cursors provide this functionality.

   # Advantages of Cursors
   -----------------------
     1. Row-by-Row Processing: Ideal for operations where you need to handle rows individually.
     2. Complex Logic: Enables complex row-based operations that might be challenging with set-based SQL.

   # Disadvantages of Cursors
   -----------------------
     1. Performance: Cursors can be slow and resource-intensive, especially with large result sets.
     2. Resource Consumption: They use more server resources (memory and CPU).
     
   # Best Practices
   -----------------------
     1. Limit Usage: Use cursors sparingly, preferring set-based operations whenever possible.
     2. Optimize: Minimize the amount of data processed by the cursor by filtering in the initial SELECT statement.
     3. Close and Deallocate: Always close and deallocate cursors to free resources.
*/
SELECT *
FROM Staff
-- Query to update every staff salary where the staff age > 28 years
DECLARE staffSalaryUpdate CURSOR FOR
	SELECT StaffId, StaffAge, Salary 
	FROM Staff
DECLARE @employeeId CHAR(6), @employeeAge INT, @employeeSalary INT
OPEN staffSalaryUpdate
	FETCH NEXT FROM staffSalaryUpdate INTO @employeeId, @employeeAge, @employeeSalary
		WHILE @@FETCH_STATUS = 0
			BEGIN
				IF @employeeAge > 28
					BEGIN
						UPDATE Staff
						SET Salary = Salary * 1.2
						WHERE CURRENT OF staffSalaryUpdate
					END
			FETCH NEXT FROM staffSalaryUpdate INTO @employeeId, @employeeAge, @employeeSalary
			END
CLOSE staffSalaryUpdate
DEALLOCATE staffSalaryUpdate
GO