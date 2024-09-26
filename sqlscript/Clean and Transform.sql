-- Insert Valid Records into silver.Customers
INSERT INTO [silver].[Customers] (CustomerID, Name, Email, Phone, Address)
SELECT
    CustomerID,
    Name,
    Email,
    Phone,
    Address
FROM [bronze].[Customers]
WHERE
    Email LIKE '%@%.%' AND
    LEN(Address) >= 10;

-- Insert Invalid Records into error.Customers_Error
INSERT INTO [error].[Customers_Error] (CustomerID, Name, Email, Phone, Address, ErrorMessage, ErrorDateTime)
SELECT
    CustomerID,
    Name,
    Email,
    Phone,
    Address,
    CASE
        WHEN Email NOT LIKE '%@%.%' THEN 'Invalid Email Format'
        WHEN LEN(Address) < 10 THEN 'Address Too Short'
        ELSE 'Unknown Error'
    END AS ErrorMessage,
    GETDATE() AS ErrorDateTime
FROM [bronze].[Customers]
WHERE
    Email NOT LIKE '%@%.%' OR
    LEN(Address) < 10;


-- Insert Valid Records into Silver.Products
INSERT INTO [silver].[Products] (ProductID, ProductName, Category, Price, StockQuantity)
SELECT
    ProductID,
    ProductName,
    Category,
    Price,
    StockQuantity
FROM [bronze].[Products]
WHERE
    Price > 0 AND
    StockQuantity >= 0;

-- Insert Invalid Records into error.Products_Error
INSERT INTO [error].[Products_Error] (ProductID, ProductName, Category, Price, StockQuantity, ErrorMessage, ErrorDateTime)
SELECT
    ProductID,
    ProductName,
    Category,
    Price,
    StockQuantity,
    CASE
        WHEN Price <= 0 THEN 'Invalid Price'
        WHEN StockQuantity < 0 THEN 'Invalid Stock Quantity'
    END AS ErrorMessage,
    GETDATE() AS ErrorDateTime
FROM [bronze].[Products]
WHERE
    Price <= 0 OR
    StockQuantity < 0;

-- Insert Valid Records into silver.Orders
INSERT INTO [silver].[Orders] (OrderID, CustomerID, OrderDate, TotalAmount)
SELECT
    o.OrderID,
    o.CustomerID,
    CASE
        WHEN o.OrderDate <= GETDATE() THEN o.OrderDate
        ELSE GETDATE()  -- Replace future dates with current date
    END AS OrderDate,
    o.TotalAmount
FROM [bronze].[Orders] o
JOIN [silver].[Customers] c ON o.CustomerID = c.CustomerID
WHERE
    o.OrderDate <= GETDATE();

-- Insert Invalid Records into error.Orders_Error
INSERT INTO [error].[Orders_Error] (OrderID, CustomerID, OrderDate, TotalAmount, ErrorMessage, ErrorDateTime)
SELECT
    o.OrderID,
    o.CustomerID,
    o.OrderDate,
    o.TotalAmount,
    CASE
        WHEN o.OrderDate > GETDATE() THEN 'Future Order Date'
        WHEN c.CustomerID IS NULL THEN 'Invalid CustomerID'
    END AS ErrorMessage,
    GETDATE() AS ErrorDateTime
FROM [bronze].[Orders] o
LEFT JOIN [silver].[Customers] c ON o.CustomerID = c.CustomerID
WHERE
    o.OrderDate > GETDATE() OR
    c.CustomerID IS NULL;


-- Insert Valid Records into silver.OrderItems
INSERT INTO [silver].[OrderItems] (OrderItemID, OrderID, ProductID, Quantity, UnitPrice)
SELECT
    oi.OrderItemID,
    oi.OrderID,
    oi.ProductID,
    oi.Quantity,
    p.Price AS UnitPrice
FROM [bronze].[OrderItems] oi
JOIN [silver].[Orders] o ON oi.OrderID = o.OrderID
JOIN [silver].[Products] p ON oi.ProductID = p.ProductID
WHERE
    oi.Quantity > 0;


-- Insert Invalid Records into error.OrderItems_Error
INSERT INTO [error].[OrderItems_Error] (OrderItemID, OrderID, ProductID, Quantity, UnitPrice, ErrorMessage, ErrorDateTime)
SELECT
    oi.OrderItemID,
    oi.OrderID,
    oi.ProductID,
    oi.Quantity,
    oi.UnitPrice,
    CASE
        WHEN oi.Quantity <= 0 THEN 'Invalid Quantity'
        WHEN o.OrderID IS NULL THEN 'Invalid OrderID'
        WHEN p.ProductID IS NULL THEN 'Invalid ProductID'
    END AS ErrorMessage,
    GETDATE() AS ErrorDateTime
FROM [bronze].[OrderItems] oi
LEFT JOIN [silver].[Orders] o ON oi.OrderID = o.OrderID
LEFT JOIN [silver].[Products] p ON oi.ProductID = p.ProductID
WHERE
    oi.Quantity <= 0 OR
    o.OrderID IS NULL OR
    p.ProductID IS NULL;