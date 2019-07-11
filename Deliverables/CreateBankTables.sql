
IF (EXISTS (SELECT * FROM INFORMATION_SCHEMA.TABLES WHERE TABLE_SCHEMA = 'dbo' AND TABLE_NAME = 'Branch')) DROP TABLE Branch
Create Table Branch (
BranchName varchar(255) NOT NULL UNIQUE,
BuildingName varchar(255) NOT NULL,
CityName varchar(255) NOT NULL,
PostalCode varchar(8) NOT NULL,
)
GO
IF (EXISTS (SELECT * FROM INFORMATION_SCHEMA.TABLES WHERE TABLE_SCHEMA = 'dbo' AND TABLE_NAME = 'Employee')) DROP TABLE Employee
Create Table Employee (
EmployeeId int NOT NULL  IDENTITY(1,1) PRIMARY KEY,
EmployeeName varchar(255) NOT NULL,
EmployeePost varchar(255) NOT NULL,
PostalAddress varchar(255) NOT NULL,
EmploymentStartDate datetime2 NOT NULL,
ManagerName varchar(255) NOT NULL,
)
GO

IF (EXISTS (SELECT * FROM INFORMATION_SCHEMA.TABLES WHERE TABLE_SCHEMA = 'dbo' AND TABLE_NAME = 'Customer')) DROP TABLE Customer
Create Table Customer (
CustomerId int NOT NULL IDENTITY(1,1) PRIMARY KEY,
EmployeeId int FOREIGN KEY REFERENCES Employee(EmployeeId),
CustomerName varchar(255) NOT NULL,
HomeAddress varchar(255) NOT NULL,
LoanOfficerName varchar(255) NOT NULL,
)
GO

IF (EXISTS (SELECT * FROM INFORMATION_SCHEMA.TABLES WHERE TABLE_SCHEMA = 'dbo' AND TABLE_NAME = 'WorkingLocation')) DROP TABLE WorkingLocation
Create Table WorkingLocation (
LocationId int NOT NULL IDENTITY(1,1) PRIMARY KEY,
EmployeeId int FOREIGN KEY REFERENCES Employee(EmployeeId),
LocationType varchar(255) NOT NULL,
)
GO

IF (EXISTS (SELECT * FROM INFORMATION_SCHEMA.TABLES WHERE TABLE_SCHEMA = 'dbo' AND TABLE_NAME = 'AccountType')) DROP TABLE AccountType
Create Table AccountType (
AccountTypeId int NOT NULL  IDENTITY(1,1) PRIMARY KEY,
AccountType varchar(255) NOT NULL,
MonthlyFee money NOT NULL,
InterestRate decimal(5,2) NOT NULL,
ServiceCharge money NOT NULL DEFAULT 0,
)
GO


IF (EXISTS (SELECT * FROM INFORMATION_SCHEMA.TABLES WHERE TABLE_SCHEMA = 'dbo' AND TABLE_NAME = 'Account')) DROP TABLE Account
Create Table Account (
AccountNumber numeric(6) NOT NULL IDENTITY(123456,1) PRIMARY KEY,
AccountTypeId int FOREIGN KEY REFERENCES AccountType(AccountTypeId),
CustomerId int FOREIGN KEY REFERENCES Customer(CustomerId),
BranchName varchar(255) FOREIGN KEY REFERENCES Branch(BranchName),
Balance money Default 0,
)
GO

IF (EXISTS (SELECT * FROM INFORMATION_SCHEMA.TABLES WHERE TABLE_SCHEMA = 'dbo' AND TABLE_NAME = 'TransactionChart')) DROP TABLE TransactionChart
Create Table TransactionChart(
TransactionId int NOT NULL IDENTITY(1,1) PRIMARY KEY,
AccountNumber numeric(6) FOREIGN KEY REFERENCES Account(AccountNumber),
TransactionAmount MONEY NOT NULL,
TransactionType varchar(255) Not NULL,
TransactionDate datetime2 NOT NULL,
BranchName varchar(255) FOREIGN KEY REFERENCES Branch(BranchName),
CheckNumber numeric(8) NOT NULL,
)
GO

IF (EXISTS (SELECT * FROM INFORMATION_SCHEMA.TABLES WHERE TABLE_SCHEMA = 'dbo' AND TABLE_NAME = 'Loan')) DROP TABLE Loan
Create Table Loan(
LoanId int NOT NULL IDENTITY(1,1) PRIMARY KEY,
CustomerId int FOREIGN KEY REFERENCES Customer(CustomerId),
BranchName varchar(255) FOREIGN KEY REFERENCES Branch(BranchName),
PaymentNumber numeric(4) NOT NULL,
MonthlyPayment money NOT NULL,
MonthlyPaymentDate datetime2 NOT NULL,
LoanAmount money NOT NULL,
)
GO


