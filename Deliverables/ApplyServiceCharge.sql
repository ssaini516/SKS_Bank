DECLARE  @AccountNumber numeric, @AccountBalance money, @AccountType varchar(255), @BranchName varchar(255), @ServiceCharge money,
 @Count int;
SET @Count = 1234;
DECLARE AccountCursor CURSOR
FOR 
SELECT A.AccountNumber, A.Balance, ACT.AccountType,A.BranchName, ACT.ServiceCharge FROM Customer AS C
INNER JOIN Account AS A ON C.CustomerId = A.CustomerId
INNER JOIN AccountType AS ACT ON A.AccountTypeId = ACT.AccountTypeId
WHERE A.Balance < 500;

OPEN AccountCursor;
FETCH NEXT FROM AccountCursor INTO @AccountNumber, @AccountBalance, @AccountType, @BranchName, @ServiceCharge;

WHILE @@FETCH_STATUS = 0
BEGIN
	IF(@AccountType = 'Checking')
	BEGIN 
		UPDATE Account
		SET Balance = @AccountBalance - @ServiceCharge
		WHERE AccountNumber = @AccountNumber;
		INSERT INTO TransactionChart(AccountNumber, TransactionAmount, TransactionType, TransactionDate, BranchName,CheckNumber)
		VALUES(@AccountNumber,  @ServiceCharge, 'Withdrawal', GETDATE(), @BranchName, @Count)
	END;
	ELSE IF(@AccountType = 'Saving')
	BEGIN 
		UPDATE Account
		SET Balance = @AccountBalance - @ServiceCharge
		WHERE AccountNumber = @AccountNumber;
		INSERT INTO TransactionChart(AccountNumber, TransactionAmount, TransactionType, TransactionDate, BranchName,CheckNumber)
		VALUES(@AccountNumber,  @ServiceCharge, 'Withdrawal', GETDATE(), @BranchName, 0)
	END;
	SET @Count = @Count + 1;
	FETCH NEXT FROM AccountCursor INTO @AccountNumber, @AccountBalance, @AccountType, @BranchName, @ServiceCharge;
END;
CLOSE AccountCursor;
DEALLOCATE AccountCursor;