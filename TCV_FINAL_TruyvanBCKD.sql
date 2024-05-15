
--TRUY VẤN BÁO CÁO KINH DOANH
--Display information of the employee with the highest salary.
SELECT *
FROM Employee
WHERE Salary = (SELECT MAX(Salary) FROM Employee);

--Calculate ticket sales revenue on January 1, 2024
SELECT SUM(s.Quantity * t.Price) AS TicketRevenue
FROM SaleService s
JOIN Ticket t ON s.TicketID = t.TicketID
WHERE s.Date = '2024-01-01';

--In January 2024, which day has the highest ticket sales?
WITH TicketRevenue AS (
SELECT s.Date, SUM(s.Quantity * t.Price) AS TotalTicketRevenue
FROM SaleService s
LEFT JOIN Ticket t ON s.TicketID = t.TicketID
WHERE MONTH(s.Date) = 1 AND YEAR(s.Date) = 2024
GROUP BY s.Date)
SELECT Date, TotalTicketRevenue
FROM TicketRevenue
WHERE TotalTicketRevenue = (SELECT MAX(TotalTicketRevenue) 
FROM TicketRevenue);

--Lowest paid employee in the “Xí nghiệp động vật” department. show employee fullname, manager fullname, and employee salary.
SELECT 
CONCAT(e.LastName, ' ', e.FirstName) AS EmployeeFullName,
CONCAT(m.LastName, ' ', m.FirstName) AS ManagerFullName,
e.Salary AS EmployeeSalary
FROM Employee e
JOIN Employee m ON e.ManagerID = m.EmployeeID
WHERE 
e.Department = N'Xí nghiệp động vật' AND
e.Salary = (
SELECT MIN(Salary)
FROM Employee
WHERE Department = N'Xí nghiệp động vật');

--The order that the business purchases with the highest price. Shows the name of the management employee and the price.
SELECT 
CONCAT(e.LastName, ' ', e.FirstName) AS EmployeeFullName,
i.Price
FROM OrderInvoice i
JOIN Employee e ON i.EmployeeID = e.EmployeeID
WHERE i.Price = (SELECT MAX(CAST(REPLACE(Price, ',', '') AS DECIMAL(10,2)))
FROM OrderInvoice);

--Displays the name and total price of the Partner with the highest number of deliveries to Thao Cam Vien (OrderInvoice table).
SELECT 
p.Name AS PartnerName,
SUM(CAST(REPLACE(i.Price, ',', '') AS DECIMAL(10,2))) AS TotalPrice
FROM OrderInvoice i
JOIN Partner p ON i.PartnerID = p.PartnerID
GROUP BY p.Name
HAVING SUM(CAST(REPLACE(i.Price, ',', '') AS DECIMAL(10,2))) = (
SELECT MAX(TotalPrice)
FROM (SELECT SUM(CAST(REPLACE(Price, ',', '') AS DECIMAL(10,2))) AS TotalPrice
FROM OrderInvoice
GROUP BY PartnerID) AS Subquery);

--Displays prices from high to low, Employee and Partner names. Managed by Employees whose EmployeeID is TVC0024 (OrderInvoice table).
SELECT r.ReceiptID, r.OrderDate,
CAST(REPLACE(r.Price, ',', '') AS DECIMAL(10,2)) AS Price,
CONCAT(e.LastName, ' ', e.FirstName) AS Employee_Name,
p.Name AS PartnerName
FROM Receipt r
JOIN Employee e ON r.EmployeeID = e.EmployeeID
JOIN Partner p ON r.PartnerID = p.PartnerID
WHERE r.EmployeeID = 'TCV0024'
ORDER BY 
Price DESC;

--Calculate the total Price of the Receipt table managed by EmployeeID "TCV0025"
SELECT SUM(Price) AS TotalPrice
FROM Receipt
JOIN Employee ON Employee.EmployeeID = Receipt.EmployeeID
WHERE Employee.EmployeeID = 'TCV0025';

--Calculate the total Price of the OrderInvoice table with OrderDate from 2024-03-01 to 2024-03-31
SELECT SUM(Price) AS TotalPrice 
FROM OrderInvoice 
WHERE OrderDate BETWEEN '2024-03-01' AND '2024-03-31';

--Calculate the total Price of Receipt table with OrderDate from 2024-02-01 to 2024-04-30
SELECT SUM(Price) AS TotalPrice 
FROM Receipt 
WHERE OrderDate BETWEEN '2024-02-01' AND '2024-04-30';

--Displays CustomerID, Name, Price of Receipt with Price from low to high in the Receipt table
SELECT c.CustomerID, c.Name, SUM(r.Price) AS TotalPrice
FROM Receipt r
JOIN CustomerOnline c ON r.CustomerID = c.CustomerID
GROUP BY c.CustomerID, c.Name
ORDER BY TotalPrice ASC;

--Display EmployeeID, LastName, FirstName, HireDate, Department, Salary of Employees whose employment date is after January 1, 2020 and display Salary in order from low to high
SELECT EmployeeID, LastName, FirstName, HireDate, Department, Salary
FROM Employee
WHERE HireDate >= '2020-01-01'
ORDER BY Salary ASC;

--Displays the Name, Region, and Price of the Service with the Lowest Price 
SELECT s.Name, s.Area, s.Price
FROM Services AS s
WHERE s.Price = (
    SELECT MIN(Price)
    FROM Services);

--Display Name, Area and Price of Services with Price = 30,000 
SELECT s.Name, s.Price
FROM Services AS s
WHERE s.Price = 30000;

--Calculate how long Animal has been staying until now, time in years. If the time is less than 1 year, it is not displayed
SELECT AnimalID, Name, DayIn,
CONVERT(VARCHAR(10), DATEDIFF(YEAR, DayIn, GETDATE()), 101) AS YearsInThaoCamVien
FROM Animal
WHERE DATEDIFF(YEAR, DayIn, GETDATE()) >= 1;

--Display the department, number of employees of those groups that have more than 4 employees
SELECT Department,
COUNT(EmployeeID) "Number of employee"
FROM Employee
GROUP BY Department
HAVING COUNT(EmployeeID)>4;

--Display the department, number of employees in the department, and the department's average salary. 
SELECT Department,
COUNT(EmployeeID) AS "Number of employee",
ROUND(AVG(Salary), 2) AS "Salary"
FROM Employee
GROUP BY Department;

--Displays SpeciesID, Species Name and corresponding Food Name for that Species
SELECT s.SpeciesID, s.Name, f.Name AS FoodName
FROM Species s
JOIN Food f ON s.FoodID = f.FoodID;

--Display AnimalD, Name, Area, Activity and Activity Entertainment respectively
SELECT a.AnimalID, a.Name, a.Area, a.ActivityID, ae.Name AS ActivityName
FROM Animal a
LEFT JOIN Activity_Entertainment ae ON a.ActivityID = ae.ActivityID;

--Find the department with the highest average salary
SELECT Department, AVG(Salary) AS AverageSalary
FROM Employee e
GROUP BY Department
ORDER BY AverageSalary DESC;

--Displays EmployeeID, EmployeeName, Hire Date and what day of the week? 
SELECT 
EmployeeID, HireDate,
CONCAT(LastName, ' ', FirstName) AS Employee_Name,
CASE 
WHEN DATEPART(WEEKDAY, HireDate) = 1 THEN N'Chủ Nhật'
WHEN DATEPART(WEEKDAY, HireDate) = 2 THEN N'Thứ Hai'
WHEN DATEPART(WEEKDAY, HireDate) = 3 THEN N'Thứ Ba'
WHEN DATEPART(WEEKDAY, HireDate) = 4 THEN N'Thứ Tư'
WHEN DATEPART(WEEKDAY, HireDate) = 5 THEN N'Thứ Năm'
WHEN DATEPART(WEEKDAY, HireDate) = 6 THEN N'Thứ Sáu'
WHEN DATEPART(WEEKDAY, HireDate) = 7 THEN N'Thứ Bảy'
END AS Day_of_the_week
FROM Employee
ORDER BY 
CASE 
WHEN DATEPART(WEEKDAY, HireDate) = 1 THEN 7 
WHEN DATEPART(WEEKDAY, HireDate) = 2 THEN 1 
WHEN DATEPART(WEEKDAY, HireDate) = 3 THEN 2 
WHEN DATEPART(WEEKDAY, HireDate) = 4 THEN 3  
WHEN DATEPART(WEEKDAY, HireDate) = 5 THEN 4 
WHEN DATEPART(WEEKDAY, HireDate) = 6 THEN 5 
WHEN DATEPART(WEEKDAY, HireDate) = 7 THEN 6 
END;

--Write a query that displays EmployeeID, Employee_Name, and Manager. Create a new column "Management Status". If the employee does not have a manager, the displayed content is "Không có người quản lý", if the employee has a manager, it displays "Có người quản lý".
SELECT e.EmployeeID,
CONCAT(e.LastName, ' ', e.FirstName) AS Employee_Name,
ISNULL(CONCAT(m.LastName, ' ', m.FirstName), N'Không có người quản lý') AS Manager,
CASE 
WHEN m.EmployeeID IS NULL THEN N'Không có người quản lý'
ELSE N'Có người quản lý'
END 
AS Manager_Status
FROM Employee e
LEFT JOIN Employee m ON e.ManagerID = m.EmployeeID;

--As a long-time employee of Thao Cam Vien, employees who work from 5 to 10 years will receive a 10% salary increase. Update the salary increase. (Display EmployeeID, employee name, current salary, new salary).
UPDATE Employee
SET Salary = ROUND(Salary * 1.10, 0)
WHERE DATEDIFF(YEAR, HireDate, GETDATE()) BETWEEN 5 AND 10;
SELECT EmployeeID, 
CONCAT(LastName, ' ', FirstName) AS Employee_Name,
Salary / 1.10 AS Current_Salary, Salary AS New_Salary
FROM Employee
WHERE DATEDIFF(YEAR, HireDate, GETDATE()) BETWEEN 5 AND 10;

--Create FUNCTION and Calculate hire date by year
CREATE FUNCTION GETYEARWORK(@HireDate DATE)
RETURNS INT
AS 
BEGIN
	DECLARE @HireYear INT;
	SET @HireYear = DATEDIFF(YEAR, @HireDate, GETDATE());
	RETURN @HireYear;
END;

SELECT EmployeeID, LastName, FirstName, HireDate,
DBO.GETYEARWORK(HireDate) AS HireYear
From Employee

--Create PROCEDURE and Query for employees whose salary is within a specific value range
CREATE PROCEDURE GetEmployeesBySalaryRange
    @MinSalary DECIMAL(18, 2),
    @MaxSalary DECIMAL(18, 2)
AS
BEGIN
    SELECT 
        EmployeeID, 
        LastName, 
        FirstName, 
        DateOfBirth, 
        Sex, 
        HireDate, 
        Phone, 
        Email, 
        Street, 
        District, 
        City, 
        Department, 
        Salary, 
        ManagerID
    FROM 
        Employee
    WHERE 
        Salary BETWEEN @MinSalary AND @MaxSalary;
END;

EXEC GetEmployeesBySalaryRange @MinSalary = 5000000, @MaxSalary = 10000000;

--Create Trigger and Update the price of the ticket with ID 'LTIC'' to 65000
CREATE TRIGGER tg_Update_Ticket ON Ticket
INSTEAD OF DELETE 
AS
BEGIN
UPDATE Ticket
SET Price = 65000
WHERE TicketID = (SELECT TicketID FROM DELETED)
END;

DELETE FROM Ticket WHERE TicketID = 'LTIC'
SELECT * FROM Ticket





