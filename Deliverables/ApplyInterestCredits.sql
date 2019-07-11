DECLARE @AccountNumber numeric , @BranchName varchar(255) , @AccountBalance money , @AccountType varchar(255) , @InterestRate money;
DECLARE InterestRateCursor CURSOR
FOR 
SELECT A.AccountNumber,A.BranchName, A.Balance, ACT.AccountType, ACT.InterestRate FROM ACCOUNT AS A
INNER JOIN AccountType AS ACT ON A.AccountTypeId = ACT.AccountTypeId;

OPEN InterestRateCursor ;
FETCH NEXT FROM InterestRateCursor INTO @AccountNumber, @BranchName, @AccountBalance, @AccountType, @InterestRate;
WHILE @@FETCH_STATUS = 0
BEGIN
    IF(@AccountType = 'Checking')
	BEGIN 
		UPDATE Account
		SET Balance = @AccountBalance + (@AccountBalance * @InterestRate)/ 100
		WHERE AccountNumber = @AccountNumber;
		INSERT INTO TransactionChart(AccountNumber, TransactionAmount, TransactionType, TransactionDate, BranchName,CheckNumber)
        VALUES(@AccountNumber, (@AccountBalance * @InterestRate)/ 100 , 'Deposit', GETDATE(), @BranchName, 0)
	END;
	ELSE IF(@AccountType = 'Saving')
	BEGIN 
		UPDATE Account
		SET Balance = @AccountBalance + (@AccountBalance * @InterestRate)/ 100
		WHERE AccountNumber = @AccountNumber;
		INSERT INTO TransactionChart(AccountNumber, TransactionAmount, TransactionType, TransactionDate, BranchName,CheckNumber)
        VALUES(@AccountNumber,  (@AccountBalance * @InterestRate)/ 100 , 'Deposit', GETDATE(), @BranchName, 0)
	END;
	FETCH NEXT FROM InterestRateCursor INTO @AccountNumber, @BranchName, @AccountBalance, @AccountType, @InterestRate;
END;
CLOSE InterestRateCursor;
DEALLOCATE InterestRateCursor;