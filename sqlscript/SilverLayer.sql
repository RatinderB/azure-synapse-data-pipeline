-- Create Customers Table in Silver Schema
CREATE TABLE [silver].[Customers] (
    [CustomerID] NVARCHAR(50) NOT NULL,
    [Name] NVARCHAR(100),
    [Email] NVARCHAR(100),
    [Phone] NVARCHAR(50),
    [Address] NVARCHAR(250)
)
WITH (
    DISTRIBUTION = REPLICATE,
    CLUSTERED INDEX ([CustomerID])
);


-- Create Products Table in Silver Schema
CREATE TABLE [silver].[Products] (
    [ProductID] NVARCHAR(50) NOT NULL,
    [Category] NVARCHAR(50),
    [ProductName] NVARCHAR(100),
    [Price] DECIMAL(18,2),
    [StockQuantity] INT
)
WITH (
    DISTRIBUTION = REPLICATE,
    CLUSTERED INDEX ([ProductID])
);



-- Create Orders Table in Silver Schema
CREATE TABLE [silver].[Orders] (
    [OrderID] NVARCHAR(50) NOT NULL,
    [CustomerID] NVARCHAR(50),
    [OrderDate] DATE,
    [TotalAmount] DECIMAL(18,2)
)
WITH (
    DISTRIBUTION = HASH([CustomerID]),
    CLUSTERED COLUMNSTORE INDEX
);


-- Create OrderItems Table in Silver Schema
CREATE TABLE [silver].[OrderItems] (
    [OrderItemID] NVARCHAR(50) NOT NULL,
    [OrderID] NVARCHAR(50),
    [ProductID] NVARCHAR(50),
    [Quantity] INT,
    [UnitPrice] DECIMAL(18,2)
)
WITH (
    DISTRIBUTION = HASH([OrderID]), 
    CLUSTERED COLUMNSTORE INDEX
);


