BEGIN TRY
 DROP TABLE Customer;
END TRY
BEGIN CATCH
 PRINT 'Could not be drop because Customer table has referenced(FOREIGN KEY) in other tables';
END CATCH