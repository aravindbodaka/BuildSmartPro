

-- INDEXING ( For Query Optimization)

-- 1.) Clients with the Most Overdue Payments

CREATE INDEX idx_clients_clientid ON Clients (ClientID);
CREATE INDEX idx_projects_clientid ON Projects (ClientID);
CREATE INDEX idx_invoices_projectid ON Invoices (ProjectID);
CREATE INDEX idx_invoices_status ON Invoices (Status);



EXPLAIN SELECT Clients.ClientID, Clients.Name AS ClientName, 
                COUNT(Invoices.InvoiceID) AS OverdueInvoices, 
                SUM(Invoices.Amount) AS TotalOverdue
FROM Clients
JOIN Projects ON Clients.ClientID = Projects.ClientID
JOIN Invoices ON Projects.ProjectID = Invoices.ProjectID
WHERE Invoices.Status = 'Overdue'
GROUP BY Clients.ClientID, Clients.Name
ORDER BY TotalOverdue DESC;


-- 2.) Identify Projects Where the Total Invoiced Amount Exceeds the Budget by More Than 20%

CREATE INDEX idx_projects_projectid ON Projects (ProjectID);
CREATE INDEX idx_invoices_projectid ON Invoices (ProjectID);
CREATE INDEX idx_invoices_projectid_amount ON Invoices (ProjectID, Amount);


EXPLAIN SELECT Projects.ProjectID, Projects.ProjectName, Projects.Budget, 
                SUM(Invoices.Amount) AS TotalInvoiced,
                (SUM(Invoices.Amount) / Projects.Budget * 100) AS BudgetUtilizationPercentage
FROM Projects
JOIN Invoices ON Projects.ProjectID = Invoices.ProjectID
GROUP BY Projects.ProjectID, Projects.ProjectName, Projects.Budget
HAVING BudgetUtilizationPercentage > 120;


-- 3.) Find Clients Who Don’t Have Any Active Projects

CREATE INDEX idx_clients_clientid ON Clients (ClientID);
CREATE INDEX idx_projects_clientid ON Projects (ClientID);

EXPLAIN SELECT Clients.ClientID, Clients.Name AS ClientName
FROM Clients
LEFT JOIN Projects ON Clients.ClientID = Projects.ClientID
WHERE Projects.ProjectID IS NULL;


