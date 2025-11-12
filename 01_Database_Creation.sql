# Database Creation and Using.

create database Final_Project;
use Final_Project;

# Creating Tables.

-- Clients Table
CREATE TABLE Clients (
    ClientID VARCHAR(10) PRIMARY KEY,
    Name VARCHAR(100) NOT NULL,
    ContactInfo VARCHAR(15) NOT NULL,
    Address VARCHAR(255) NOT NULL
);

-- Suppliers Table
CREATE TABLE Suppliers (
    SupplierID VARCHAR(10) PRIMARY KEY,
    Name VARCHAR(100) NOT NULL,
    ContactInfo VARCHAR(15) NOT NULL,
    Ratings DECIMAL(2, 1) CHECK (Ratings BETWEEN 1.0 AND 5.0)
);

-- Employees Table
CREATE TABLE Employees (
    EmployeeID VARCHAR(10) PRIMARY KEY,
    Name VARCHAR(100) NOT NULL,
    Role VARCHAR(50) NOT NULL,
    Certification VARCHAR(50)
);

-- Projects Table
CREATE TABLE Projects (
    ProjectID VARCHAR(10) PRIMARY KEY,
    ProjectName VARCHAR(100) NOT NULL,
    Budget DECIMAL(15, 2) NOT NULL,
    Timeline VARCHAR(20) NOT NULL,
    ClientID VARCHAR(10),
    FOREIGN KEY (ClientID) REFERENCES Clients(ClientID)
);

-- Inventory Table
CREATE TABLE Inventory (
    ItemID VARCHAR(10) PRIMARY KEY,
    ItemName VARCHAR(100) NOT NULL,
    Quantity INT NOT NULL CHECK (Quantity >= 0),
    UnitPrice DECIMAL(10, 2) NOT NULL,
    SupplierID VARCHAR(10),
    FOREIGN KEY (SupplierID) REFERENCES Suppliers(SupplierID)
);

-- Invoices Table
CREATE TABLE Invoices (
    InvoiceID VARCHAR(10) PRIMARY KEY,
    ProjectID VARCHAR(10),
    Amount DECIMAL(10, 2) NOT NULL,
    DueDate DATE NOT NULL,
    Status VARCHAR(20) CHECK (Status IN ('Paid', 'Pending', 'Overdue')),
    FOREIGN KEY (ProjectID) REFERENCES Projects(ProjectID)
);

-- Contracts Table
CREATE TABLE Contracts (
    ContractID VARCHAR(10) PRIMARY KEY,
    ProjectID VARCHAR(10),
    ClientID VARCHAR(10),
    Terms VARCHAR(255) NOT NULL,
    SignedDate DATE NOT NULL,
    FOREIGN KEY (ProjectID) REFERENCES Projects(ProjectID),
    FOREIGN KEY (ClientID) REFERENCES Clients(ClientID)
);

-- Project Roles Table
CREATE TABLE ProjectRoles (
    AssignmentID VARCHAR(10) PRIMARY KEY,
    ProjectID VARCHAR(10),
    EmployeeID VARCHAR(10),
    Role VARCHAR(50) NOT NULL,
    StartDate DATE NOT NULL,
    EndDate DATE,
    FOREIGN KEY (ProjectID) REFERENCES Projects(ProjectID),
    FOREIGN KEY (EmployeeID) REFERENCES Employees(EmployeeID)
);

# Data Population

-- Clients Table

INSERT INTO Clients (ClientID, Name, ContactInfo, Address) VALUES
('C101', 'Urban Builders Inc.', '212-555-0112', '123 Broadway, New York, NY 10001'),
('C102', 'EcoHomes LLC', '312-555-0199', '456 Lakeshore Ave, Chicago, IL 60601'),
('C103', 'Pinnacle Properties', '415-555-0123', '789 Market St, San Francisco, CA 94103'),
('C104', 'Metro Real Estate Group', '702-555-0145', '321 Fremont Ave, Las Vegas, NV 89101'),
('C105', 'Bay Area Ventures', '510-555-0167', '555 First St, Oakland, CA 94607'),
('C106', 'Skyline Development', '213-555-0178', '555 Sunset Blvd, Los Angeles, CA 90028'),
('C107', 'Blue Horizon Estates', '503-555-0193', '678 Elm St, Portland, OR 97201'),
('C108', 'Greenway Partners', '617-555-0143', '789 Oak St, Boston, MA 02116'),
('C109', 'Riverfront Holdings', '614-555-0168', '901 Water St, Columbus, OH 43215'),
('C110', 'Sunset Realty', '480-555-0184', '234 Main St, Phoenix, AZ 85001'),
('C111', 'Oceanview Group', '305-555-0179', '101 Ocean Ave, Miami, FL 33101'),
('C112', 'Crestfield Construction', '214-555-0188', '200 Maple St, Dallas, TX 75201'),
('C113', 'Golden Gate Development', '415-555-0174', '300 Bay St, San Francisco, CA 94133'),
('C114', 'Aspen Builders', '303-555-0192', '400 Aspen Dr, Denver, CO 80203'),
('C115', 'Highland Constructors', '312-555-0176', '500 Lake St, Chicago, IL 60611'),
('C116', 'Valley View Estates', '602-555-0187', '600 Mountain Rd, Phoenix, AZ 85018'),
('C117', 'Parkside Residences', '404-555-0183', '700 Park Ave, Atlanta, GA 30303'),
('C118', 'Sunrise Communities', '210-555-0190', '800 Spring St, San Antonio, TX 78201'),
('C119', 'Lakeside Homes', '919-555-0191', '900 Hill St, Raleigh, NC 27601'),
('C120', 'Midtown Developers', '213-555-0185', '100 Midtown Ave, Los Angeles, CA 90013'),
('C121', 'Northstar Builders', '503-555-0177', '110 North Ave, Portland, OR 97209'),
('C122', 'Westfield Construction', '312-555-0182', '120 West St, Chicago, IL 60602'),
('C123', 'Maplewood Homes', '720-555-0171', '130 Maple Dr, Boulder, CO 80301'),
('C124', 'Brighton Estates', '214-555-0195', '140 Pine St, Austin, TX 78701'),
('C125', 'Harmony Developments', '510-555-5678', '123 Oak St, Berkeley, CA 94720');

-- Suppliers Table

INSERT INTO Suppliers (SupplierID, Name, ContactInfo, Ratings) VALUES
('S101', 'Concrete Solutions Inc.', '212-555-0199', 4.7),
('S102', 'Green Lumber Supply', '617-555-0101', 4.5),
('S103', 'Industrial Steel Co.', '312-555-0188', 4.8),
('S104', 'Builders Brickworks', '713-555-0143', 4.3),
('S105', 'Glass and Glazing Corp.', '415-555-0155', 4.6),
('S106', 'Advanced Building Supply', '323-555-5678', 4.4),
('S107', 'Eco Concrete Supplies', '202-555-0189', 4.2),
('S108', 'Highland Timber', '509-555-0123', 4.6),
('S109', 'Allied Steelworks', '404-555-0145', 4.7),
('S110', 'BrickMaster LLC', '305-555-0181', 4.5),
('S111', 'Custom Glassworks', '608-555-0192', 4.4),
('S112', 'Pacific Lumber Co.', '310-555-0163', 4.3),
('S113', 'Midwest Concrete', '317-555-0174', 4.6),
('S114', 'Metro Metal Supply', '916-555-0128', 4.8),
('S115', 'Lumbertown Supplies', '503-555-0193', 4.3),
('S116', 'Precision Stoneworks', '402-555-0139', 4.5),
('S117', 'Durable Concrete', '415-555-0115', 4.2),
('S118', 'National Rebar', '213-555-0144', 4.6),
('S119', 'Fine Finish Glass', '650-555-0187', 4.7),
('S120', 'Evergreen Lumber', '702-555-0158', 4.5),
('S121', 'Cornerstone Materials', '919-555-0166', 4.4),
('S122', 'Central Concrete Co.', '615-555-0191', 4.3),
('S123', 'Top Quality Brick', '808-555-0179', 4.8),
('S124', 'Glassworks USA', '212-555-0125', 4.6),
('S125', 'Timberland Suppliers', '213-555-0194', 4.4);

-- Employees Table

INSERT INTO Employees (EmployeeID, Name, Role, Certification) VALUES
('E101', 'Michael Johnson', 'Senior Structural Engineer', 'Licensed PE'),
('E102', 'Samantha Lee', 'Project Manager', 'Certified PM'),
('E103', 'Alex Rodriguez', 'Field Supervisor', 'OSHA Level 2'),
('E104', 'Linda Chang', 'Principal Architect', 'Registered Architect'),
('E105', 'David Kim', 'Electrician', 'Journeyman Electrician'),
('E106', 'Jennifer Green', 'Site Engineer', 'Certified Engineer'),
('E107', 'Robert Clark', 'Carpenter', 'Certified Carpenter'),
('E108', 'Nancy Thomas', 'Plumber', 'Master Plumber'),
('E109', 'Kevin Brown', 'Mechanical Engineer', 'PE Mechanical'),
('E110', 'Angela White', 'Civil Engineer', 'Licensed PE'),
('E111', 'Thomas Harris', 'Construction Manager', 'PMP Certified'),
('E112', 'Maria Lewis', 'Surveyor', 'Certified Surveyor'),
('E113', 'Joseph Wilson', 'Architect', 'LEED Accredited'),
('E114', 'Karen Walker', 'Structural Engineer', 'Licensed PE'),
('E115', 'Richard Allen', 'Safety Officer', 'OSHA Certified'),
('E116', 'Laura Scott', 'Interior Designer', 'NCIDQ Certified'),
('E117', 'Daniel Young', 'Estimator', 'Certified Estimator'),
('E118', 'Jessica King', 'Project Coordinator', 'Certified Coordinator'),
('E119', 'James Wright', 'Electrical Engineer', 'Licensed PE'),
('E120', 'Patricia Perez', 'HVAC Technician', 'Certified Technician'),
('E121', 'Brian Hall', 'Drafter', 'Certified Drafter'),
('E122', 'Susan Green', 'Foreman', 'Experienced Foreman'),
('E123', 'Steven Adams', 'Laborer', 'Experienced Laborer'),
('E124', 'Emma Miller', 'Welder', 'Certified Welder'),
('E125', 'Olivia Davis', 'Environmental Engineer', 'Green Certification');

-- Projects Table

INSERT INTO Projects (ProjectID, ProjectName, Budget, Timeline, ClientID) VALUES
('P101', 'City Center Mall Renovation', 780000.00, '12 months', 'C101'),
('P102', 'Greenway Apartments Development', 1250000.00, '24 months', 'C102'),
('P103', 'Riverside Park Office Tower', 2100000.00, '30 months', 'C103'),
('P104', 'Lakeside Community Housing', 460000.00, '15 months', 'C104'),
('P105', 'Sunset Villas Expansion', 965000.00, '20 months', 'C105'),
('P106', 'Oceanview Condos', 1450000.00, '18 months', 'C106'),
('P107', 'Downtown Office Plaza', 2750000.00, '24 months', 'C107'),
('P108', 'Highland Park Retail Center', 1950000.00, '22 months', 'C108'),
('P109', 'Midtown Tech Campus', 3200000.00, '30 months', 'C109'),
('P110', 'Valley View Estates', 1250000.00, '20 months', 'C110'),
('P111', 'Riverbend Apartments', 850000.00, '12 months', 'C111'),
('P112', 'Grandview Shopping Center', 1400000.00, '18 months', 'C112'),
('P113', 'Bay Ridge Business Park', 2700000.00, '25 months', 'C113'),
('P114', 'Southside Townhomes', 900000.00, '14 months', 'C114'),
('P115', 'Parkside Luxury Towers', 3200000.00, '28 months', 'C115'),
('P116', 'Horizon Medical Center', 2800000.00, '24 months', 'C116'),
('P117', 'Summit Plaza Expansion', 1100000.00, '18 months', 'C117'),
('P118', 'North End Office Park', 2450000.00, '26 months', 'C118'),
('P119', 'Westside Family Housing', 750000.00, '14 months', 'C119'),
('P120', 'Eastview Residential Complex', 1900000.00, '20 months', 'C120'),
('P121', 'Central Park Redevelopment', 3000000.00, '36 months', 'C121'),
('P122', 'Maplewood Villas', 1400000.00, '18 months', 'C122'),
('P123', 'Heritage Senior Living', 1300000.00, '16 months', 'C123'),
('P124', 'Brighton Lofts', 1500000.00, '22 months', 'C124'),
('P125', 'Harmony Gardens Condos', 1750000.00, '24 months', 'C125');

-- Inventory Table

INSERT INTO Inventory (ItemID, ItemName, Quantity, UnitPrice, SupplierID) VALUES
('I101', 'Ready-Mix Concrete', 1200, 85.00, 'S101'),
('I102', 'Structural Lumber', 700, 68.00, 'S102'),
('I103', 'Reinforcing Steel', 500, 130.00, 'S103'),
('I104', 'Clay Bricks', 10000, 0.80, 'S104'),
('I105', 'Tempered Glass', 300, 160.00, 'S105'),
('I106', 'High-Strength Cement', 500, 90.00, 'S106'),
('I107', 'Pine Lumber', 1000, 75.00, 'S107'),
('I108', 'Steel Beams', 250, 200.00, 'S108'),
('I109', 'Roof Tiles', 1200, 2.50, 'S109'),
('I110', 'Insulation Panels', 400, 45.00, 'S110'),
('I111', 'Copper Pipes', 800, 30.00, 'S111'),
('I112', 'Glass Windows', 200, 150.00, 'S112'),
('I113', 'Drywall Sheets', 500, 10.00, 'S113'),
('I114', 'Ceramic Tiles', 1000, 5.50, 'S114'),
('I115', 'Concrete Blocks', 1500, 1.20, 'S115'),
('I116', 'Rebar Steel', 600, 135.00, 'S116'),
('I117', 'Flooring Panels', 300, 25.00, 'S117'),
('I118', 'PVC Pipes', 1200, 2.20, 'S118'),
('I119', 'Hardwood Flooring', 400, 55.00, 'S119'),
('I120', 'Asphalt Shingles', 900, 3.00, 'S120'),
('I121', 'Plumbing Fittings', 500, 15.00, 'S121'),
('I122', 'Granite Countertops', 100, 250.00, 'S122'),
('I123', 'Sand and Gravel', 3000, 0.30, 'S123'),
('I124', 'Metal Roofing', 500, 80.00, 'S124'),
('I125', 'Aluminum Siding', 350, 70.00, 'S125');

-- Invoices Table

INSERT INTO Invoices (InvoiceID, ProjectID, Amount, DueDate, Status) VALUES
('INV101', 'P101', 10000.00, '2024-02-01', 'Paid'),
('INV102', 'P102', 50000.00, '2024-03-15', 'Pending'),
('INV103', 'P103', 85000.00, '2024-04-01', 'Overdue'),
('INV104', 'P104', 13500.00, '2024-05-01', 'Paid'),
('INV105', 'P105', 16000.00, '2024-05-15', 'Pending'),
('INV106', 'P106', 22000.00, '2024-06-01', 'Paid'),
('INV107', 'P107', 50000.00, '2024-06-15', 'Pending'),
('INV108', 'P108', 30000.00, '2024-07-01', 'Paid'),
('INV109', 'P109', 45000.00, '2024-07-15', 'Overdue'),
('INV110', 'P110', 28000.00, '2024-08-01', 'Paid'),
('INV111', 'P111', 37000.00, '2024-08-15', 'Pending'),
('INV112', 'P112', 29000.00, '2024-09-01', 'Paid'),
('INV113', 'P113', 41000.00, '2024-09-15', 'Pending'),
('INV114', 'P114', 45000.00, '2024-10-01', 'Paid'),
('INV115', 'P115', 32000.00, '2024-10-15', 'Overdue'),
('INV116', 'P116', 51000.00, '2024-11-01', 'Paid'),
('INV117', 'P117', 40000.00, '2024-11-15', 'Pending'),
('INV118', 'P118', 27000.00, '2024-12-01', 'Paid'),
('INV119', 'P119', 15000.00, '2024-12-15', 'Paid'),
('INV120', 'P120', 43000.00, '2025-01-01', 'Pending'),
('INV121', 'P121', 49000.00, '2025-01-15', 'Paid'),
('INV122', 'P122', 22000.00, '2025-02-01', 'Pending'),
('INV123', 'P123', 14000.00, '2025-02-15', 'Overdue'),
('INV124', 'P124', 33000.00, '2025-03-01', 'Paid'),
('INV125', 'P125', 29000.00, '2025-03-15', 'Pending'),
('INV126', 'P101', 27000.00, '2025-04-01', 'Paid'),
('INV127', 'P102', 24000.00, '2025-04-15', 'Overdue'),
('INV128', 'P103', 30000.00, '2025-05-01', 'Paid'),
('INV129', 'P104', 17000.00, '2025-05-15', 'Pending'),
('INV130', 'P105', 35000.00, '2025-06-01', 'Paid');

-- Contracts Table

INSERT INTO Contracts (ContractID, ProjectID, ClientID, Terms, SignedDate) VALUES
('CTR101', 'P101', 'C101', 'Lump Sum Contract - Full Payment on Completion', '2024-01-10'),
('CTR102', 'P102', 'C102', 'Cost Plus Contract - Monthly Billing for Expenses', '2024-02-12'),
('CTR103', 'P103', 'C103', 'Fixed Price Contract - 30% Advance', '2024-03-05'),
('CTR104', 'P104', 'C104', 'Guaranteed Maximum Price Contract', '2024-04-01'),
('CTR105', 'P105', 'C105', 'Unit Price Contract - Per Square Foot', '2024-05-01'),
('CTR106', 'P106', 'C106', 'Lump Sum Contract - Full Payment on Completion', '2024-06-01'),
('CTR107', 'P107', 'C107', 'Cost Plus Contract - Monthly Billing for Expenses', '2024-07-10'),
('CTR108', 'P108', 'C108', 'Fixed Price Contract - 25% Advance', '2024-08-15'),
('CTR109', 'P109', 'C109', 'Guaranteed Maximum Price Contract', '2024-09-01'),
('CTR110', 'P110', 'C110', 'Unit Price Contract - Per Square Foot', '2024-10-01'),
('CTR111', 'P111', 'C111', 'Lump Sum Contract - Full Payment on Completion', '2024-11-01'),
('CTR112', 'P112', 'C112', 'Cost Plus Contract - Monthly Billing for Expenses', '2024-12-01'),
('CTR113', 'P113', 'C113', 'Fixed Price Contract - 20% Advance', '2025-01-01'),
('CTR114', 'P114', 'C114', 'Guaranteed Maximum Price Contract', '2025-02-01'),
('CTR115', 'P115', 'C115', 'Unit Price Contract - Per Square Foot', '2025-03-01'),
('CTR116', 'P116', 'C116', 'Lump Sum Contract - Full Payment on Completion', '2025-04-01'),
('CTR117', 'P117', 'C117', 'Cost Plus Contract - Monthly Billing for Expenses', '2025-05-01'),
('CTR118', 'P118', 'C118', 'Fixed Price Contract - 30% Advance', '2025-06-01'),
('CTR119', 'P119', 'C119', 'Guaranteed Maximum Price Contract', '2025-07-01'),
('CTR120', 'P120', 'C120', 'Unit Price Contract - Per Square Foot', '2025-08-01'),
('CTR121', 'P121', 'C121', 'Lump Sum Contract - Full Payment on Completion', '2025-09-01'),
('CTR122', 'P122', 'C122', 'Cost Plus Contract - Monthly Billing for Expenses', '2025-10-01'),
('CTR123', 'P123', 'C123', 'Fixed Price Contract - 25% Advance', '2025-11-01'),
('CTR124', 'P124', 'C124', 'Guaranteed Maximum Price Contract', '2025-12-01'),
('CTR125', 'P125', 'C125', 'Unit Price Contract - Per Square Foot', '2026-01-01'),
('CTR126', 'P101', 'C101', 'Fixed Price Contract - 15% Advance', '2026-02-01'),
('CTR127', 'P102', 'C102', 'Guaranteed Maximum Price Contract', '2026-03-01'),
('CTR128', 'P103', 'C103', 'Unit Price Contract - Per Square Meter', '2026-04-01'),
('CTR129', 'P104', 'C104', 'Lump Sum Contract - Full Payment on Completion', '2026-05-01'),
('CTR130', 'P105', 'C105', 'Cost Plus Contract - Billing with Receipts', '2026-06-01');

-- Project Roles Table

INSERT INTO ProjectRoles (AssignmentID, ProjectID, EmployeeID, Role, StartDate, EndDate) VALUES
('R101', 'P101', 'E101', 'Structural Engineer', '2024-01-15', '2024-07-15'),
('R102', 'P102', 'E102', 'Project Manager', '2024-02-01', '2024-10-01'),
('R103', 'P103', 'E103', 'Field Supervisor', '2024-03-01', '2024-09-01'),
('R104', 'P104', 'E104', 'Architect', '2024-04-10', '2024-12-10'),
('R105', 'P105', 'E105', 'Electrician', '2024-05-01', '2024-11-01'),
('R106', 'P106', 'E106', 'Site Engineer', '2024-06-01', '2024-12-15'),
('R107', 'P107', 'E107', 'Carpenter', '2024-07-01', '2024-12-31'),
('R108', 'P108', 'E108', 'Plumber', '2024-08-01', '2025-02-01'),
('R109', 'P109', 'E109', 'Mechanical Engineer', '2024-09-01', '2025-03-01'),
('R110', 'P110', 'E110', 'Civil Engineer', '2024-10-01', '2025-04-01'),
('R111', 'P111', 'E111', 'Construction Manager', '2024-11-01', '2025-05-01'),
('R112', 'P112', 'E112', 'Surveyor', '2024-12-01', '2025-06-01'),
('R113', 'P113', 'E113', 'Architect', '2025-01-01', '2025-07-01'),
('R114', 'P114', 'E114', 'Structural Engineer', '2025-02-01', '2025-08-01'),
('R115', 'P115', 'E115', 'Safety Officer', '2025-03-01', '2025-09-01'),
('R116', 'P116', 'E116', 'Interior Designer', '2025-04-01', '2025-10-01'),
('R117', 'P117', 'E117', 'Estimator', '2025-05-01', '2025-11-01'),
('R118', 'P118', 'E118', 'Project Coordinator', '2025-06-01', '2025-12-01'),
('R119', 'P119', 'E119', 'Electrical Engineer', '2025-07-01', '2026-01-01'),
('R120', 'P120', 'E120', 'HVAC Technician', '2025-08-01', '2026-02-01'),
('R121', 'P121', 'E121', 'Drafter', '2025-09-01', '2026-03-01'),
('R122', 'P122', 'E122', 'Foreman', '2025-10-01', '2026-04-01'),
('R123', 'P123', 'E123', 'Laborer', '2025-11-01', '2026-05-01'),
('R124', 'P124', 'E124', 'Welder', '2025-12-01', '2026-06-01'),
('R125', 'P125', 'E125', 'Environmental Engineer', '2026-01-01', '2026-07-01'),
('R126', 'P101', 'E101', 'Structural Engineer', '2026-02-01', '2026-08-01'),
('R127', 'P102', 'E102', 'Project Manager', '2026-03-01', '2026-09-01'),
('R128', 'P103', 'E103', 'Field Supervisor', '2026-04-01', '2026-10-01'),
('R129', 'P104', 'E104', 'Architect', '2026-05-01', '2026-11-01'),
('R130', 'P105', 'E105', 'Electrician', '2026-06-01', '2026-12-01');




