-- Create Error Table for Customers
CREATE TABLE [error].[Customers_Error] (
    [CustomerID] NVARCHAR(50),
    [Name] NVARCHAR(100),
    [Email] NVARCHAR(100),
    [Phone] NVARCHAR(50),
    [Address] NVARCHAR(250),
    [ErrorMessage] NVARCHAR(4000),
    [ErrorDateTime] DATETIME
)
WITH (
    DISTRIBUTION = ROUND_ROBIN,
    HEAP
);

-- Create Error Table for Products
CREATE TABLE [error].[Products_Error] (
    [ProductID] NVARCHAR(50),
    [ProductName] NVARCHAR(100),
    [Category] NVARCHAR(50),
    [Price] DECIMAL(18,2),
    [StockQuantity] INT,
    [ErrorMessage] NVARCHAR(4000),
    [ErrorDateTime] DATETIME
)
WITH (
    DISTRIBUTION = ROUND_ROBIN,
    HEAP
);

-- Create Error Table for Orders
CREATE TABLE [error].[Orders_Error] (
    [OrderID] NVARCHAR(50),
    [CustomerID] NVARCHAR(50),
    [OrderDate] DATE,
    [TotalAmount] DECIMAL(18,2),
    [ErrorMessage] NVARCHAR(4000),
    [ErrorDateTime] DATETIME
)
WITH (
    DISTRIBUTION = ROUND_ROBIN,
    HEAP
);

-- Create Error Table for OrderItems
CREATE TABLE [error].[OrderItems_Error] (
    [OrderItemID] NVARCHAR(50),
    [OrderID] NVARCHAR(50),
    [ProductID] NVARCHAR(50),
    [Quantity] INT,
    [UnitPrice] DECIMAL(18,2),
    [ErrorMessage] NVARCHAR(4000),
    [ErrorDateTime] DATETIME
)
WITH (
    DISTRIBUTION = ROUND_ROBIN,
    HEAP
);
