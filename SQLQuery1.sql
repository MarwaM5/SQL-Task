SELECT * FROM Employees;
SELECT * FROM Departments;
CREATE TABLE AccessCards (
    CardID INT PRIMARY KEY,
    CardNumber VARCHAR(50) NOT NULL UNIQUE,
    EmployeeID INT UNIQUE FOREIGN KEY REFERENCES Employees(EmployeeID)
);
SELECT * FROM AccessCards;

CREATE TABLE Projects(
ProjectID INT PRIMARY KEY,
ProjectName VARCHAR(100) NOT NULL
);
SELECT * FROM Projects;

CREATE TABLE EmployeeProjects(
EMPID INT FOREIGN KEY REFERENCES Employees(EmployeeID),
PROID INT FOREIGN KEY REFERENCES Projects(ProjectID),
primary key (EMPID,PROID)

);
ALTER TABLE EmployeeProjects ADD AssignedDate DATE;
SELECT * FROM EmployeeProjects;

INSERT INTO AccessCards VALUES
(101, 'CARD-101', 1),
(102, 'CARD-102', 2),
(103, 'CARD-103', 3);

INSERT INTO Projects VALUES
(1, 'AI & Security Training'),
(2, 'Cloud Migration');

INSERT INTO EmployeeProjects VALUES
(1, 1, '2026-10-30'),
(1, 2, '2026-10-30'),
(2, 1, '2026-10-30'),
(3, 2, '2026-10-30');

SELECT Employees.FullName , Employees.Salary , Departments.DepartmentName
FROM Employees INNER JOIN Departments on Employees.DepartmentID = Departments.DepartmentID;

SELECT Departments.DepartmentID,Departments.DepartmentName,Employees.FullName
FROM Departments
LEFT JOIN Employees
ON Departments.DepartmentID = Employees.DepartmentID;

SELECT Employees.FullName,AccessCards.CardNumber
FROM Employees
INNER JOIN AccessCards
ON Employees.EmployeeID = AccessCards.EmployeeID;

SELECT Employees.FullName,Projects.ProjectName,EmployeeProjects.AssignedDate
FROM Employees
INNER JOIN EmployeeProjects
    ON Employees.EmployeeID = EmployeeProjects.EMPID
INNER JOIN Projects
    ON Projects.ProjectID = EmployeeProjects.PROID ;


SELECT DepartmentID, COUNT(*) AS EmployeeCount, SUM(Salary) AS TotalSalary
FROM Employees
GROUP BY DepartmentID;

SELECT DepartmentID, AVG(Salary) AS AvgSalary
FROM Employees
GROUP BY DepartmentID
HAVING AVG(Salary) > 1000.00;

SELECT FullName,Salary
FROM Employees
WHERE Salary > (
    SELECT AVG(Salary)
    FROM Employees
);

CREATE VIEW vw_EmployeeDetails AS
SELECT
    Employees.EmployeeID,
    Employees.FullName,
    Employees.Email,
    Departments.DepartmentName
FROM Employees
INNER JOIN Departments
    ON Employees.DepartmentID = Departments.DepartmentID;


SELECT * FROM vw_EmployeeDetails;

CREATE PROCEDURE sp_GetEmployeesByDepartment
    @DeptID INT
AS
BEGIN
    SELECT *
    FROM Employees
    WHERE DepartmentID = @DeptID;
END;

EXEC sp_GetEmployeesByDepartment @DeptID = 1;


CREATE TABLE EmployeeAudit (
    AuditID INT IDENTITY(1,1) PRIMARY KEY,
    EmployeeID INT,
    Action VARCHAR(50),
    ActionDate DATETIME
);

--SELECT * FROM EmployeeAudit;
CREATE TRIGGER trg_AfterDeleteEmployee
ON Employees
AFTER DELETE AS
BEGIN
    INSERT INTO EmployeeAudit (EmployeeID, Action, ActionDate)
    SELECT
        EmployeeID,
        'DELETE',
        GETDATE()
    FROM deleted;
END;

INSERT INTO Employees
    (EmployeeID, FullName, Email, Salary, DepartmentID, PhoneNumber)
VALUES
    (4, 'Test Employee', 'test@techworld.com', 1000, 1, '07900000000');

DELETE FROM Employees
WHERE EmployeeID = 4;

SELECT * FROM EmployeeAudit;
