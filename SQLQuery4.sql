create DATABASE TechWorldHRDB;

--SELECT * FROM TemporaryStaff;
--DROP TABLE TemporaryStaff;
CREATE TABLE Departments(
DepartmentID INT PRIMARY KEY,
DepartmentName VARCHAR(50) NOT NULL UNIQUE
);
INSERT INTO Departments VALUES(1,'IT');
INSERT INTO Departments VALUES(2,'HR');
INSERT INTO Departments VALUES(3,'Finance');
SELECT * FROM Departments;

CREATE TABLE Employees(
EmployeeID INT PRIMARY KEY,
FullName VARCHAR(100) NOT NULL,
Email VARCHAR(100) UNIQUE,
Salary DECIMAL(10,2),
DepartmentID INT

);
INSERT INTO Employees VALUES(1,'Ahmad Ali','ahmad@techworld.com',1200.00 ,1,'0791111111');
INSERT INTO Employees VALUES(2,'Sara Hassan','sara@techworld.com',950.00,2,'0792222222');
INSERT INTO Employees VALUES(3,'Zaid Omar','zaid@techworld.com',1500.00,1,'0793333333');
INSERT INTO Employees VALUES(4,'Mona Khaled','mona@techworld.com',800.00,3,'0794444444');




ALTER TABLE Employees ADD PhoneNumber VARCHAR(20) ;
SELECT * FROM Employees;
SELECT * FROM  Employees;

UPDATE Employees SET Salary=1350.00 WHERE EmployeeID=1;
DELETE FROM Employees WHERE EmployeeID=4;

SELECT FullName ,Salary FROM Employees; 
SELECT SUM(Salary) AS TotalSalaries FROM Employees;
SELECT AVG(Salary) AS AverageSalary FROM Employees;
SELECT MAX(Salary) AS HighestSalary , MIN(Salary) AS LowestSalary FROM Employees;
SELECT COUNT(*) AS TotalEmployees FROM Employees;

