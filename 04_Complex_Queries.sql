-- Complex Queries


-- 1.)	Clients with the Most Overdue Payments

SELECT Clients.ClientID, Clients.Name AS ClientName, 
       COUNT(Invoices.InvoiceID) AS OverdueInvoices, 
       SUM(Invoices.Amount) AS TotalOverdue
FROM Clients
JOIN Projects ON Clients.ClientID = Projects.ClientID
JOIN Invoices ON Projects.ProjectID = Invoices.ProjectID
WHERE Invoices.Status = 'Overdue'
GROUP BY Clients.ClientID, Clients.Name
ORDER BY TotalOverdue DESC;

-- 2.)	Identify projects where the total invoiced amount exceeds the budget by more than 20%.

SELECT Projects.ProjectID, Projects.ProjectName, Projects.Budget, 
       SUM(Invoices.Amount) AS TotalInvoiced,
       (SUM(Invoices.Amount) / Projects.Budget * 100) AS BudgetUtilizationPercentage
FROM Projects
JOIN Invoices ON Projects.ProjectID = Invoices.ProjectID
GROUP BY Projects.ProjectID, Projects.ProjectName, Projects.Budget
HAVING BudgetUtilizationPercentage > 120;

-- 3.)	Find clients who don’t have any active projects.

SELECT Clients.ClientID, Clients.Name AS ClientName
FROM Clients
LEFT JOIN Projects ON Clients.ClientID = Projects.ClientID
WHERE Projects.ProjectID IS NULL;

-- 4.)	List the number of projects each employee has worked on.

SELECT Employees.EmployeeID, Employees.Name AS EmployeeName, COUNT(ProjectRoles.ProjectID) AS TotalProjects
FROM Employees
JOIN ProjectRoles ON Employees.EmployeeID = ProjectRoles.EmployeeID
GROUP BY Employees.EmployeeID, Employees.Name;

-- 5.)	Calculate the revenue per month for a specific project 

SELECT DATE_FORMAT(Invoices.DueDate, '%Y-%m') AS RevenueMonth, 
       SUM(Invoices.Amount) AS TotalRevenue
FROM Invoices
WHERE ProjectID = 'P101'
GROUP BY RevenueMonth;

-- 6.)	Find the top 3 clients with the highest total spending.

SELECT Clients.ClientID, Clients.Name AS ClientName, SUM(Invoices.Amount) AS TotalSpent
FROM Clients
JOIN Projects ON Clients.ClientID = Projects.ClientID
JOIN Invoices ON Projects.ProjectID = Invoices.ProjectID
GROUP BY Clients.ClientID, Clients.Name
ORDER BY TotalSpent DESC
LIMIT 3;

-- 7.)	Identify projects that currently have no employees assigned.

SELECT Projects.ProjectID, Projects.ProjectName
FROM Projects
LEFT JOIN ProjectRoles ON Projects.ProjectID = ProjectRoles.ProjectID
WHERE ProjectRoles.AssignmentID IS NULL;

-- 8.)	Find projects that have the highest number of distinct roles assigned.

SELECT Projects.ProjectID, Projects.ProjectName, 
       COUNT(DISTINCT ProjectRoles.Role) AS RoleDiversity
FROM Projects JOIN ProjectRoles ON Projects.ProjectID = ProjectRoles.ProjectID
GROUP BY Projects.ProjectID, Projects.ProjectName
ORDER BY RoleDiversity DESC
LIMIT 5;

-- 9.)	Find projects that haven’t had any invoices issued in the past year.

SELECT Projects.ProjectID, Projects.ProjectName
FROM Projects
LEFT JOIN Invoices ON Projects.ProjectID = Invoices.ProjectID
WHERE Invoices.DueDate < '2023-12-31' OR Invoices.DueDate IS NULL;

-- 10.)	Retrieve Employees Who Worked on Multiple Projects as a 'Project Manager'.

SELECT Employees.EmployeeID, Employees.Name, COUNT(ProjectRoles.ProjectID) AS ProjectCount
FROM Employees
JOIN ProjectRoles ON Employees.EmployeeID = ProjectRoles.EmployeeID
WHERE ProjectRoles.Role = 'Project Manager'
GROUP BY Employees.EmployeeID, Employees.Name
HAVING ProjectCount > 1;



