DECLARE @AccountNumber numeric, @CustomerName varchar(20) ,@AccountType varchar(20), @AccountBalance money, 
	@MonthlyPayment money, @LoanAmount money, @BranchName varchar(255), @LoanId int, @MonthlyPaymentDate Datetime2;
DECLARE AccountCursor CURSOR
FOR 
SELECT A.AccountNumber,C.CustomerName, ACT.AccountType, A.Balance, L.MonthlyPayment, L.LoanAmount, 
		L.BranchName, L.LoanId, L.MonthlyPaymentDate FROM  Customer AS C
INNER JOIN Loan AS L ON C.CustomerId = L.CustomerId
INNER JOIN Account AS A ON C.CustomerId = A.CustomerId
INNER JOIN AccountType AS ACT ON A.AccountTypeId = ACT.AccountTypeId
WHERE L.MonthlyPaymentDate = '2018-02-10'
OPEN AccountCursor;
FETCH NEXT FROM AccountCursor INTO @AccountNumber, @CustomerName,@AccountType, @AccountBalance , @MonthlyPayment, @LoanAmount , @BranchName, @LoanId, @MonthlyPaymentDate;

WHILE @@FETCH_STATUS = 0
BEGIN
	IF(@AccountType = 'Checking')
	BEGIN 
		UPDATE Account
		SET Balance = @AccountBalance - @MonthlyPayment
		WHERE AccountNumber = @AccountNumber;
		UPDATE Loan
		SET LoanAmount = @LoanAmount - @MonthlyPayment
		WHERE LoanId = @LoanId;
		UPDATE Loan
		SET MonthlyPaymentDate = DATEADD(month, 1, @MonthlyPaymentDate)
		WHERE LoanId = @LoanId;
		INSERT INTO TransactionChart(AccountNumber, TransactionAmount, TransactionType, TransactionDate, BranchName,CheckNumber)
		VALUES(@AccountNumber,  @MonthlyPayment, 'Withdrawal', GETDATE(), @BranchName, 0)
		break;
	END;
	ELSE IF(@AccountType = 'Saving')
	BEGIN 
		UPDATE Account
		SET Balance = @AccountBalance - @MonthlyPayment
		WHERE AccountNumber = @AccountNumber;
		INSERT INTO TransactionChart(AccountNumber, TransactionAmount, TransactionType, TransactionDate, BranchName,CheckNumber)
		VALUES(@AccountNumber,  @MonthlyPayment, 'Withdrawal', GETDATE(), @BranchName, 0)
		break;
	END;
	FETCH NEXT FROM AccountCursor INTO @AccountNumber, @CustomerName,@AccountType, @AccountBalance , @MonthlyPayment, @LoanAmount, @BranchName, @LoanId, @MonthlyPaymentDate;
END;
CLOSE AccountCursor;
DEALLOCATE AccountCursor;
