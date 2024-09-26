-- Create External Table in Bronze Schema for Customers
CREATE EXTERNAL TABLE [bronze].[Customers] (
    [CustomerID] NVARCHAR(400),
    [Name] NVARCHAR(400),
    [Email] NVARCHAR(400),
    [Phone] NVARCHAR(400),
    [Address] NVARCHAR(400)
)
WITH (
    LOCATION = '/raw/customers.csv',
    DATA_SOURCE = [ADLSDataSource],
    FILE_FORMAT = [CSVFileFormat]
);

-- Create External Table in Bronze Schema for Products

CREATE EXTERNAL TABLE [bronze].[Products] (
    [ProductID] NVARCHAR(50),
    [Category] NVARCHAR(50),
    [ProductName] NVARCHAR(100),
    [Price] DECIMAL(18,2),
    [StockQuantity] FLOAT
)
WITH (
    LOCATION = 'raw/products.csv',
    DATA_SOURCE = [ADLSDataSource],
    FILE_FORMAT = [CSVFileFormat]
);

-- Create External Table in Bronze Schema for Orders
CREATE EXTERNAL TABLE [bronze].[Orders] (
    [OrderID] NVARCHAR(50),
    [CustomerID] NVARCHAR(50),
    [OrderDate] DATE,
    [TotalAmount] DECIMAL(18,2)
)
WITH (
    LOCATION = 'raw/orders.csv',
    DATA_SOURCE = [ADLSDataSource],
    FILE_FORMAT = [CSVFileFormat]
);

-- Create External Table in Bronze Schema for Order Items
CREATE EXTERNAL TABLE [bronze].[OrderItems] (
    [OrderItemID] NVARCHAR(50),
    [OrderID] NVARCHAR(50),
    [ProductID] NVARCHAR(50),
    [Quantity] FLOAT,
    [UnitPrice] DECIMAL(18,2)
)
WITH (
    LOCATION = 'raw/order_items.csv',
    DATA_SOURCE = [ADLSDataSource],
    FILE_FORMAT = [CSVFileFormat]
);

