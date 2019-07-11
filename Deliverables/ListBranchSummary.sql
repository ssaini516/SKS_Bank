SELECT (B.BranchName + ' ' + b.PostalCode) AS BranchDetail, A.NumberOfAccounts, 
		A.TotalAccountBalance, TC.AvgOfTotalTransaction ,L.TotalLoanNumber, L.TotalLoanAmount FROM Branch B
FULL OUTER JOIN 
		(SELECT Account.BranchName, COUNT(AccountNumber) AS NumberOfAccounts, SUM(Balance) AS TotalAccountBalance FROM Account 
		GROUP BY Account.BranchName) 
		AS A ON B.BranchName = A.BranchName
FULL OUTER JOIN 
		(SELECT TransactionChart.BranchName, AVG(TransactionAmount) AS AvgOfTotalTransaction FROM TransactionChart
		GROUP BY TransactionChart.BranchName) 
		AS TC ON A.BranchName = TC.BranchName
FULL OUTER JOIN 
		(SELECT Loan.BranchName, COUNT(LoanId) AS TotalLoanNumber, SUM(LoanAmount) AS TotalLoanAmount FROM Loan
		GROUP BY Loan.BranchName) 
		AS L ON B.BranchName = L.BranchName
