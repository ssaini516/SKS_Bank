
/*important*/
/* run the create procedure first and then commented out.*/
/*Now you can run the script*/

--CREATE PROCEDURE UpdateAccountTable 
--@AccountNumber numeric ,@AccountBalance money, @ServiceCharge money, @BranchName varchar(255)					
--AS 
--UPDATE Account
--	SET Balance = @AccountBalance - @ServiceCharge
--	WHERE AccountNumber = @AccountNumber;
--	INSERT INTO TransactionChart(AccountNumber, TransactionAmount, TransactionType, TransactionDate, BranchName,CheckNumber)
--    VALUES(@AccountNumber,  @ServiceCharge, 'Withdrawal', GETDATE(), @BranchName, 0)

DECLARE @AccountNumber numeric ,@AccountBalance money, @ServiceCharge money, @BranchName varchar(255);
DECLARE AccountCursor CURSOR
FOR 
SELECT	A.AccountNumber, A.Balance, ACT.ServiceCharge, A.BranchName FROM Account AS A
INNER JOIN AccountType AS ACT ON A.AccountTypeId = ACT.AccountTypeId
WHERE ACT.AccountType = 'Checking';

OPEN AccountCursor;
FETCH NEXT FROM AccountCursor INTO @AccountNumber, @AccountBalance, @ServiceCharge, @BranchName;

WHILE @@FETCH_STATUS = 0
BEGIN
	EXEC UpdateAccountTable @AccountNumber ,@AccountBalance , @ServiceCharge , @BranchName
	FETCH NEXT FROM AccountCursor INTO @AccountNumber, @AccountBalance, @ServiceCharge, @BranchName;
END;
CLOSE AccountCursor;
DEALLOCATE AccountCursor;


