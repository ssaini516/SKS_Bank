SELECT A.AccountNumber, ACT.AccountType, C.CustomerName, A.Balance, B.BranchName , MAX(TC.TransactionDate) AS LastDateOfTransaction FROM  Account AS A
INNER JOIN AccountType AS ACT ON A.AccountTypeId = ACT.AccountTypeId
INNER JOIN Customer AS C ON A.CustomerId = C.CustomerId
INNER JOIN Branch AS B ON A.BranchName = B.BranchName
FULL OUTER JOIN TransactionChart AS TC ON A.AccountNumber = TC.AccountNumber
GROUP BY A.AccountNumber, ACT.AccountType, C.CustomerName, A.Balance, B.BranchName