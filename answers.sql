-- Question 1: Transform ProductDetail table into 1NF
-- The Products column contains multiple values (e.g., "Laptop, Mouse"), violating 1NF
-- 1NF requires atomic values in each cell, so we split the Products column into separate rows
-- Step 1: Create a new table in 1NF where each row has a single product per order
CREATE TABLE ProductDetail_1NF (
    OrderID INT,
    CustomerName VARCHAR(50),
    Product VARCHAR(50),
    PRIMARY KEY (OrderID, Product) -- Composite key to uniquely identify each row
);

-- Step 2: Insert data into the new table by splitting the Products column
-- Using the provided data, we manually split the comma-separated values into rows
INSERT INTO ProductDetail_1NF (OrderID, CustomerName, Product)
VALUES
    (101, 'John Doe', 'Laptop'),
    (101, 'John Doe', 'Mouse'),
    (102, 'Jane Smith', 'Tablet'),
    (102, 'Jane Smith', 'Keyboard'),
    (102, 'Jane Smith', 'Mouse'),
    (103, 'Emily Clark', 'Phone');

-- Result: The new table ProductDetail_1NF is now in 1NF with atomic values in each cell

-- Question 2: Transform OrderDetails table into 2NF
-- The OrderDetails table is in 1NF but has a partial dependency: CustomerName depends only on OrderID
-- 2NF requires non-key columns to depend on the entire primary key (OrderID, Product)
-- Step 1: Split into two tables: Orders (OrderID, CustomerName) and OrderItems (OrderID, Product, Quantity)
-- First table: Orders (contains OrderID and CustomerName, removing partial dependency)
CREATE TABLE Orders (
    OrderID INT PRIMARY KEY,
    CustomerName VARCHAR(50)
);

-- Second table: OrderItems (contains OrderID, Product, and Quantity, fully dependent on the composite key)
CREATE TABLE OrderItems (
    OrderID INT,
    Product VARCHAR(50),
    Quantity INT,
    PRIMARY KEY (OrderID, Product),
    FOREIGN KEY (OrderID) REFERENCES Orders(OrderID)
);

-- Step 2: Insert data into the Orders table (unique OrderID and CustomerName pairs)
INSERT INTO Orders (OrderID, CustomerName)
VALUES
    (101, 'John Doe'),
    (102, 'Jane Smith'),
    (103, 'Emily Clark');

-- Step 3: Insert data into the OrderItems table (OrderID, Product, Quantity)
INSERT INTO OrderItems (OrderID, Product, Quantity)
VALUES
    (101, 'Laptop', 2),
    (101, 'Mouse', 1),
    (102, 'Tablet', 3),
    (102, 'Keyboard', 1),
    (102, 'Mouse', 2),
    (103, 'Phone', 1);

-- Result: The data is now in 2NF, with no partial dependencies
-- Orders table holds customer info, and OrderItems table holds product details per order