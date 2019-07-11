SELECT C.CustomerName, A.AccountNumber, A.Balance, ACT.AccountType,A.BranchName, ACT.ServiceCharge FROM Customer AS C
INNER JOIN Account AS A ON C.CustomerId = A.CustomerId
INNER JOIN AccountType AS ACT ON A.AccountTypeId = ACT.AccountTypeId
WHERE A.Balance < 500;