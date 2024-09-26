CREATE VIEW [gold].[vw_SalesSummary] AS
SELECT
    p.Category,
    p.ProductName,
    SUM(oi.Quantity) AS TotalQuantitySold,
    SUM(oi.Quantity * oi.UnitPrice) AS TotalSalesAmount
FROM [silver].[OrderItems] oi
INNER JOIN [silver].[Products] p ON oi.ProductID = p.ProductID
GROUP BY
    p.Category,
    p.ProductName;

-- Identify the total sales and quantity sold for each product.
CREATE VIEW [gold].[vw_TotalSalesPerProduct] AS
SELECT
    p.ProductID,
    p.ProductName,
    p.Category,
    SUM(oi.Quantity) AS TotalQuantitySold,
    SUM(oi.Quantity * oi.UnitPrice) AS TotalSalesAmount
FROM [silver].[OrderItems] oi
INNER JOIN [silver].[Products] p ON oi.ProductID = p.ProductID
GROUP BY
    p.ProductID,
    p.ProductName,
    p.Category;


-- Top spending customers
CREATE VIEW [gold].[vw_TopCustomersBySpend] AS
SELECT TOP 10
    c.CustomerID,
    c.Name AS CustomerName,
    c.Email,
    SUM(oi.Quantity * oi.UnitPrice) AS TotalSpent,
    COUNT(DISTINCT o.OrderID) AS OrderCount
FROM [silver].[Customers] c
INNER JOIN [silver].[Orders] o ON c.CustomerID = o.CustomerID
INNER JOIN [silver].[OrderItems] oi ON o.OrderID = oi.OrderID
GROUP BY
    c.CustomerID,
    c.Name,
    c.Email
ORDER BY
    TotalSpent DESC;

-- Avg order value for each customer
CREATE VIEW [gold].[vw_AverageOrderValueByCustomer] AS
SELECT
    c.CustomerID,
    c.Name AS CustomerName,
    AVG(o.TotalAmount) AS AverageOrderValue,
    COUNT(DISTINCT o.OrderID) AS OrderCount
FROM [silver].[Customers] c
INNER JOIN [silver].[Orders] o ON c.CustomerID = o.CustomerID
GROUP BY
    c.CustomerID,
    c.Name;


-- Create the SalesSummaryByProduct table
CREATE TABLE [gold].[SalesSummaryByProduct] (
    ProductID NVARCHAR(50) NOT NULL,
    ProductName NVARCHAR(100),
    Category NVARCHAR(50),
    Year INT,
    Month INT,
    TotalQuantitySold INT,
    TotalSalesAmount DECIMAL(18,2)
)
WITH (
    DISTRIBUTION = HASH(ProductID),
    CLUSTERED COLUMNSTORE INDEX
);

-- Populate the SalesSummaryByProduct table
INSERT INTO [gold].[SalesSummaryByProduct] (ProductID, ProductName, Category, Year, Month, TotalQuantitySold, TotalSalesAmount)
SELECT
    p.ProductID,
    p.ProductName,
    p.Category,
    YEAR(o.OrderDate) AS Year,
    MONTH(o.OrderDate) AS Month,
    SUM(oi.Quantity) AS TotalQuantitySold,
    SUM(oi.Quantity * oi.UnitPrice) AS TotalSalesAmount
FROM [silver].[OrderItems] oi
INNER JOIN [silver].[Orders] o ON oi.OrderID = o.OrderID
INNER JOIN [silver].[Products] p ON oi.ProductID = p.ProductID
GROUP BY
    p.ProductID,
    p.ProductName,
    p.Category,
    YEAR(o.OrderDate),
    MONTH(o.OrderDate);


-- Create the CategorySalesPerformance table
CREATE TABLE [gold].[CategorySalesPerformance] (
    Category NVARCHAR(50),
    Year INT,
    Month INT,
    TotalQuantitySold INT,
    TotalSalesAmount DECIMAL(18,2)
)
WITH (
    DISTRIBUTION = ROUND_ROBIN,
    CLUSTERED COLUMNSTORE INDEX
);

-- Populate the CategorySalesPerformance table
INSERT INTO [gold].[CategorySalesPerformance] (Category, Year, Month, TotalQuantitySold, TotalSalesAmount)
SELECT
    p.Category,
    YEAR(o.OrderDate) AS Year,
    MONTH(o.OrderDate) AS Month,
    SUM(oi.Quantity) AS TotalQuantitySold,
    SUM(oi.Quantity * oi.UnitPrice) AS TotalSalesAmount
FROM [silver].[OrderItems] oi
INNER JOIN [silver].[Orders] o ON oi.OrderID = o.OrderID
INNER JOIN [silver].[Products] p ON oi.ProductID = p.ProductID
GROUP BY
    p.Category,
    YEAR(o.OrderDate),
    MONTH(o.OrderDate);
