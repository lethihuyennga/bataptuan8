CREATE DATABASE QLBH
go
USE QLBH;


CREATE TABLE Suppliers (
    SupplierID INT PRIMARY KEY,
    SupplierName VARCHAR(100) NOT NULL
);


CREATE TABLE Products (
    ProductID INT PRIMARY KEY,
    ProductName VARCHAR(100) NOT NULL,
    SupplierID INT,
    UnitPrice DECIMAL(10, 2) NOT NULL,
    UnitInStock INT NOT NULL,
    FOREIGN KEY (SupplierID) REFERENCES Suppliers(SupplierID)
);


CREATE TABLE Customers (
    CustomerID INT PRIMARY KEY,
    CompanyName VARCHAR(100) NOT NULL,
    Address VARCHAR(200),
    City VARCHAR(50),
    Region VARCHAR(50),
    Country VARCHAR(50)
);


CREATE TABLE Employees (
    EmployeeID INT PRIMARY KEY,
    LastName VARCHAR(50) NOT NULL,
    FirstName VARCHAR(50) NOT NULL,
    BirthDate DATE,
    City VARCHAR(50)
);


CREATE TABLE Orders (
    OrderID INT PRIMARY KEY,
    CustomerID INT,
    EmployeeID INT,
    OrderDate DATE,
    FOREIGN KEY (CustomerID) REFERENCES Customers(CustomerID),
    FOREIGN KEY (EmployeeID) REFERENCES Employees(EmployeeID)
);


CREATE TABLE OrderDetails (
    OrderID INT,
    ProductID INT,
    UnitPrice DECIMAL(10, 2) NOT NULL,
    Quantity INT NOT NULL,
    Discount DECIMAL(5, 2) DEFAULT 0.00,
    PRIMARY KEY (OrderID, ProductID),
    FOREIGN KEY (OrderID) REFERENCES Orders(OrderID),
    FOREIGN KEY (ProductID) REFERENCES Products(ProductID)
);

-----SUPPLIERS
INSERT INTO Suppliers (SupplierID, SupplierName)
VALUES (1, 'Công ty CHICUONG')
INSERT INTO Suppliers (SupplierID, SupplierName)
VALUES (2, 'Công ty NHUNGOC')
INSERT INTO Suppliers (SupplierID, SupplierName)
VALUES (3, 'Công ty HONGANH')
INSERT INTO Suppliers (SupplierID, SupplierName)
VALUES (6, 'Công ty HUYENNGA')
INSERT INTO Suppliers (SupplierID, SupplierName)
VALUES (4, 'Công ty NTP')
INSERT INTO Suppliers (SupplierID, SupplierName)
VALUES (5, 'Công ty ADUONG')
---PRODUCTS
INSERT INTO Products (ProductID, ProductName, SupplierID, UnitPrice, UnitInStock)
VALUES (6, 'gà công nghiệp', 3, 3200.00, 5)
INSERT INTO Products (ProductID, ProductName, SupplierID, UnitPrice, UnitInStock)
VALUES (1, 'vé máy bay', 1, 1200.00, 4)
INSERT INTO Products (ProductID, ProductName, SupplierID, UnitPrice, UnitInStock)
VALUES (2, 'bánh cuốn', 2, 90.00, 15)
INSERT INTO Products (ProductID, ProductName, SupplierID, UnitPrice, UnitInStock)
VALUES (3, 'mai', 3, 50.00, 3)
INSERT INTO Products (ProductID, ProductName, SupplierID, UnitPrice, UnitInStock)
VALUES (4, 'vé số', 4, 250.00, 8)
INSERT INTO Products (ProductID, ProductName, SupplierID, UnitPrice, UnitInStock)
VALUES (5, 'Loa', 5, 150.00, 2)
---CUSTOMERS
INSERT INTO Customers (CustomerID, CompanyName, Address, City, Region, Country)
VALUES (6, 'Công ty Ai Vy', '12 Đường Lê Lợi', 'Madrid', 'Madrid', 'Spain')
INSERT INTO Customers (CustomerID, CompanyName, Address, City, Region, Country)
VALUES (7, 'Công ty Chí Cường', '12 Đường Lê Lợi', 'Madrid', 'Madrid', 'Spain')
INSERT INTO Customers (CustomerID, CompanyName, Address, City, Region, Country)
VALUES (1, 'Công ty Huyền Nga', '123 Đường Lê Lợi', 'Madrid', 'Madrid', 'Spain')
INSERT INTO Customers (CustomerID, CompanyName, Address, City, Region, Country)
VALUES (2, 'Công ty Kiệt', '456 Đường Nguyễn Huệ', 'Munich', 'Bavaria', 'Germany')
INSERT INTO Customers (CustomerID, CompanyName, Address, City, Region, Country)
VALUES (3, 'Công ty Minh Triết', '789 Đường Trần Phú', 'Hà Nội', 'Miền Bắc', 'Việt Nam')
INSERT INTO Customers (CustomerID, CompanyName, Address, City, Region, Country)
VALUES (4, 'Công ty Như Ngọc', '101 Đường Võ Thị Sáu', 'Melbourne', 'Victoria', 'Australia')
INSERT INTO Customers (CustomerID, CompanyName, Address, City, Region, Country)
VALUES (5, 'Công ty Hồng Anh', '202 Đường Phạm Ngũ Lão', 'Manchester', 'North West', 'UK')
---
INSERT INTO Employees (EmployeeID, LastName, FirstName, BirthDate, City)
VALUES (5, 'Lê', 'Huyền Nga', '2005-03-29', 'Bình Định')
INSERT INTO Employees (EmployeeID, LastName, FirstName, BirthDate, City)
VALUES (6, 'Fuller', 'Huyền Nga', '2005-03-29', 'Bình Định')
INSERT INTO Employees (EmployeeID, LastName, FirstName, BirthDate, City)
VALUES (4, 'Fuller', 'Anh Kiệt', '2005-07-09', 'Đà Lạt')
INSERT INTO Employees (EmployeeID, LastName, FirstName, BirthDate, City)
VALUES (3, 'Peter', 'Anh Anh', '2005-09-05', 'Đà Nẵng')

---
INSERT INTO Orders (OrderID, CustomerID, EmployeeID, OrderDate)
VALUES (1, 6, 5, '1997-07-10')
INSERT INTO Orders (OrderID, CustomerID, EmployeeID, OrderDate)
VALUES (2, 7, 5, '1997-01-10')
INSERT INTO Orders (OrderID, CustomerID, EmployeeID, OrderDate)
VALUES (3, 6, 6, '1997-04-12')
INSERT INTO Orders (OrderID, CustomerID, EmployeeID, OrderDate)
VALUES (4, 6, 6, '1996-07-10')
INSERT INTO Orders (OrderID, CustomerID, EmployeeID, OrderDate)
VALUES (5, 5, 5, '1996-12-07')
INSERT INTO Orders (OrderID, CustomerID, EmployeeID, OrderDate)
VALUES (6, 7, 3, '1996-07-16')
---
INSERT INTO OrderDetails (OrderID, ProductID, UnitPrice, Quantity, Discount)
VALUES (1, 6, 3200.00, 2, 30.00)
INSERT INTO OrderDetails (OrderID, ProductID, UnitPrice, Quantity, Discount)
VALUES (2, 6, 3200.00, 1, 15.00)
INSERT INTO OrderDetails (OrderID, ProductID, UnitPrice, Quantity, Discount)
VALUES (3, 1, 1200.00, 1, 10.00)
INSERT INTO OrderDetails (OrderID, ProductID, UnitPrice, Quantity, Discount)
VALUES (4, 1, 1200.00, 1, 0.00)
INSERT INTO OrderDetails (OrderID, ProductID, UnitPrice, Quantity, Discount)
VALUES (5, 2, 1200.00, 1, 0.00)
INSERT INTO OrderDetails (OrderID, ProductID, UnitPrice, Quantity, Discount)
VALUES (6, 3, 1000.00, 1, 0.00)
USE QLBH
GO
ALTER 