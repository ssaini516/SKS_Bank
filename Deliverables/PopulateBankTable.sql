INSERT INTO Branch(BranchName, BuildingName, CityName, PostalCode)
VALUES('SKS1',  'Chinook', 'Calgary', 'T2Y5XP'),
      ('SKS2',  'Wendy', 'Torronto', 'Y2Y5XM'),
      ('SKS3',  'CTtower', 'Torronto', 'T2D5CP'),
	  ('SKS4',  'CrossIron', 'Calgary', 'T3Y6XP'),
	  ('SKS5',  'SundrigeMall', 'Edmonton', 'k2Y5zP')


INSERT INTO Employee(EmployeeName, EmployeePost, PostalAddress, EmploymentStartDate, ManagerName)
VALUES('Khush',  'Loan Officer','4006 NE Whitehorn','2013-1-15', 'Rayn'),
      ('Sandeep',  'Banker','406 NE Whitehorn','2013-12-27', 'Andrew'),
      ('Brijesh',  'Banker','4006 SE Chinook','2013-9-25', 'Rayn'),
	  ('Hai',  'Loan Officer','4006 SW Cityhall','2014-4-15', 'Alex'),
	  ('Pablo',  'PR','123 SW Martindale','2015-6-5', 'Andrew'),
	  ('Saad',  'PR','62 NE Saddletown','2015-8-15', 'Alex')

INSERT INTO Customer(EmployeeId, CustomerName, HomeAddress,LoanOfficerName)
VALUES(1,  'Anderson', '4006 NE Whitehorn', 'Rayn'),
      (3,  'Parvir', '406 NE Whitehorn', 'Andrew'),
      (2,  'Cole', '4006 SE Chinook', 'Andrew'),
	  (1,  'JL', '4006 SW Cityhall', 'Alex'),
	  (4,  'Riana', '123 SW Martindale','Alex'),
	  (3,  'Tasha', '62 NE Saddletown', 'Rayn')


INSERT INTO WorkingLocation(EmployeeId, LocationType)
VALUES(1,'Customer Service Centre'),
      (5,  'Administrative Office'),
      (2, 'Administrative Office'),
	  (3,  'Customer Service Centre'),
	  (4,  'Customer Service Centre'),
	  (3,  'Administrative Office')

INSERT INTO AccountType(AccountType, MonthlyFee, InterestRate, ServiceCharge)
VALUES('Checking', $14.52, .01, $25),
      ('Saving',$15.20, .04, $25)


INSERT INTO Account(AccountTypeId, CustomerId, BranchName, Balance)
VALUES(1, 1, 'SKS1', $700),
      (2,  1, 'SKS2', $1000),
      (1, 2, 'SKS2', $400),
	  (2,  2, 'SKS4', $300),
	  (1,  4, 'SKS5' , $600),
	  (2,  3, 'SKS5' , $800);

INSERT INTO TransactionChart(AccountNumber, TransactionAmount, TransactionType, TransactionDate,BranchName,CheckNumber)
VALUES(123456, $200, 'Deposit', '2018-2-13', 'SKS1', 0),
      (123457, $20, 'Withdrawal', '2018-3-13', 'SKS1', 12345678),
      (123456, $205, 'Deposit', '2018-5-13', 'SKS2', 0),
	  (123458, $200, 'Withdrawal', '2018-6-13', 'SKS4', 12345679),
	  (123460, $200, 'Deposit', '2018-7-13', 'SKS5', 0),
	  (123461, $200, 'Withdrawal', '2018-10-13', 'SKS2', 12345747)

INSERT INTO Loan(CustomerId,BranchName, PaymentNumber, MonthlyPayment, MonthlyPaymentDate, LoanAmount)
VALUES(1,'SKS1', 1234, $20, '2018-1-10', $400),
      (1,'SKS1', 1235, $10, '2018-2-10', $600),
	  (2,'SKS1', 1236, $25, '2018-3-10', $400),
	  (3,'SKS4', 1237, $30, '2018-1-15', $800),
	  (2,'SKS2', 1238, $45, '2018-5-10', $1200),
	  (1,'SKS5', 1239, $15, '2018-1-10', $300)