-- Create the TechCompanyDB database
CREATE DATABASE TechCompanyDB;

-- Use the TechCompanyDB database
USE TechCompanyDB;

-- Create the Companies table
CREATE TABLE Companies (
    CompanyID INT IDENTITY(1,1) PRIMARY KEY,
    CompanyName VARCHAR(255) NOT NULL,
    FoundedYear INT NOT NULL,
    Headquarters VARCHAR(255) NOT NULL,
    MarketCap DECIMAL(15,2) NOT NULL,
    Employees INT NOT NULL,
);

-- Create the Products table
CREATE TABLE Products (
    ProductID INT IDENTITY(1,1) PRIMARY KEY,
    ProductName VARCHAR(255) NOT NULL,
    Description TEXT,
    LaunchYear INT NOT NULL
);

-- Create the Executives table
CREATE TABLE Executives (
    ExecutiveID INT IDENTITY (1,1) PRIMARY KEY,
    ExecutiveName VARCHAR(255) NOT NULL,
    Title VARCHAR(255) NOT NULL
);

-- Create the CompanyProducts table
CREATE TABLE CompanyProducts (
    CompanyProductID INT IDENTITY(1,1) PRIMARY KEY,
    CompanyID INT,
    ProductID INT,
    FOREIGN KEY (CompanyID) REFERENCES Companies(CompanyID),
    FOREIGN KEY (ProductID) REFERENCES Products(ProductID)
);

-- Create the Revenues table
CREATE TABLE Revenues (
    RevenueID INT IDENTITY(1,1) PRIMARY KEY,
    CompanyID INT,
    Year INT NOT NULL,
    Amount DECIMAL(15,2) NOT NULL,
    FOREIGN KEY (CompanyID) REFERENCES Companies(CompanyID)
);

-- Insert data into Companies table
INSERT INTO Companies (CompanyName, FoundedYear, Headquarters, MarketCap, Employees)
VALUES 
    ('Apple Inc.', 1976, 'Cupertino, CA', 2500000000000.00, 164000),
    ('Google LLC', 1998, 'Mountain View, CA', 1900000000000.00, 156500),
    ('Amazon.com', 1994, 'Seattle, WA', 1600000000000.00, 1546000),
    ('Microsoft Corp', 1975, 'Redmond, WA', 2200000000000.00, 181000),
    ('Meta Platforms', 2004, 'Menlo Park, CA', 764000000000.00, 98524);

-- Insert data into Products table
INSERT INTO Products (ProductName, Description, LaunchYear)
VALUES 
    ('iPhone', 'Popular smartphone', 2007),
    ('Google Search', 'Widely used search platform', 1997),
    ('Amazon Web Services (AWS)', 'Provides cloud services to businesses', 2006),
    ('Microsoft Windows', 'Prominent operating system', 1985),
    ('Facebook', 'Social media platform', 2004);

-- Insert data into Executives table
INSERT INTO Executives (ExecutiveName, Title)
VALUES 
    ('Tim Cook', 'CEO'),
    ('Sundar Pichai', 'CEO'),
    ('Andy Jassy', 'CEO'),
    ('Satya Nadella', 'CEO'),
    ('Mark Zuckerberg', 'CEO');

-- Insert data into CompanyProducts table
INSERT INTO CompanyProducts (CompanyID, ProductID)
VALUES (1, 1), (2, 2), (3, 3), (4, 4), (5, 5);

-- Insert data into Revenues table
INSERT INTO Revenues (CompanyID, Year, Amount)
VALUES 
    (1, 2022, 380000000000.00),
    (2, 2022, 180000000000.00),
    (3, 2022, 386000000000.00),
    (4, 2022, 168000000000.00),
    (5, 2022, 85000000000.00);

	
-- ALTER TABLE
	-- Add two new columns to the Companies table
ALTER TABLE Companies
ADD NetIncome VARCHAR(255);
ALTER TABLE Companies
ADD Industry VARCHAR(255);

SELECT * 
FROM Companies;


-- UPDATE RECORDS
-- Update the NetIncome and Industry columns in the Companies table
UPDATE Companies
SET NetIncome = '96.995 billion', Industry = 'Technology, Consumer Electronics, Computer Software'
WHERE CompanyID = 1;

UPDATE Companies
SET NetIncome = '66.732 billion', Industry = 'Internet Services, Cloud Computing, Computer Software'
WHERE CompanyID = 2;

UPDATE Companies
SET NetIncome = '30.173 billion', Industry = 'E-commerce, Cloud Computing'
WHERE CompanyID = 3;

UPDATE Companies
SET NetIncome = '72.4 billion', Industry = 'Technology, Computer Software, Consumer Electronics'
WHERE CompanyID = 4;

UPDATE Companies
SET NetIncome = '29.733 billion', Industry = 'Social Media, Virtual Reality, Advertising'
WHERE CompanyID = 5;
END


-- TRUNCATE TABLE
-- Truncate the CompanyProducts table
TRUNCATE TABLE CompanyProducts;

SELECT *
FROM CompanyProducts;

-- DELETE RECORDS
-- Delete the last two records from the Revenues table
SELECT *
FROM Revenues;

DELETE FROM Revenues
WHERE RevenueID = 4;
DELETE FROM Revenues
WHERE RevenueID = 5;