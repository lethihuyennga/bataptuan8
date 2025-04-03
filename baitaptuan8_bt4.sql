﻿USE QLBH
GO
---TUAN 8
---Baitap4
---1
SELECT ProductID, ProductName, UnitPrice
FROM Products
WHERE UnitPrice > (SELECT AVG(UnitPrice) FROM Products);
--- 2
SELECT ProductID, ProductName, UnitPrice
FROM Products
WHERE UnitPrice > (SELECT AVG(UnitPrice) FROM Products WHERE ProductName LIKE 'N%');
----3
SELECT ProductID, ProductName, UnitPrice
FROM Products
WHERE ProductName LIKE 'N%' 
AND UnitPrice > (SELECT MIN(UnitPrice) FROM Products);
---4
SELECT ProductID, ProductName, UnitPrice
FROM Products
WHERE ProductID IN (SELECT DISTINCT ProductID FROM OrderDetails);
---5
SELECT ProductID, ProductName, UnitPrice
FROM Products
WHERE UnitPrice > (SELECT MIN(UnitPrice) FROM Products);
---6
SELECT OrderID, CustomerID, OrderDate 
FROM Orders
WHERE CustomerID IN (SELECT CustomerID FROM Customers WHERE City IN ('London', 'Madrid'));
---7
ALTER TABLE Products ADD Package VARCHAR(50)
ALTER TABLE Customers ADD CustomerName VARCHAR(255)
ALTER TABLE Employees ADD EmployeeName VARCHAR(255)  
---
SELECT ProductID, ProductName, UnitPrice
FROM Products
WHERE ProductName LIKE '%Box%' 
AND UnitPrice < (SELECT AVG(UnitPrice) FROM Products);
---8
SELECT ProductID, ProductName
FROM Products
WHERE ProductID IN (SELECT ProductID 
                    FROM OrderDetails
                    GROUP BY ProductID
                    HAVING SUM(Quantity) = (SELECT MAX(TotalSold) 
                                            FROM (SELECT SUM(Quantity) AS TotalSold 
                                                  FROM OrderDetails 
                                                  GROUP BY ProductID) AS Subquery));
---9
---c1
SELECT CustomerID, CompanyName
FROM Customers
WHERE NOT EXISTS (SELECT 1 FROM Orders WHERE Orders.CustomerID = Customers.CustomerID);
---c2
SELECT Customers.CustomerID, Customers.CompanyName
FROM Customers
LEFT JOIN Orders ON Customers.CustomerID = Orders.CustomerID
WHERE Orders.CustomerID IS NULL;
--c3
SELECT CustomerID, CompanyName
FROM Customers
WHERE CustomerID NOT IN (SELECT CustomerID FROM Orders);
---10
SELECT ProductID, ProductName, UnitPrice
FROM Products
WHERE ProductName LIKE '%box%'
AND UnitPrice = (SELECT MAX(UnitPrice) FROM Products);
---11
SELECT ProductID, ProductName, UnitPrice
FROM Products
WHERE UnitPrice > (SELECT AVG(UnitPrice) FROM Products WHERE ProductID <= 5);
---12
SELECT ProductID, ProductName
FROM Products
WHERE ProductID IN (SELECT ProductID FROM OrderDetails 
                    GROUP BY ProductID 
                    HAVING SUM(Quantity) > (SELECT AVG(TotalQuantity) 
                                            FROM (SELECT SUM(Quantity) AS TotalQuantity 
                                                  FROM OrderDetails 
                                                  GROUP BY ProductID) AS Subquery));
---13
SELECT CustomerID, CompanyName
FROM Customers
WHERE CustomerID IN (SELECT CustomerID FROM Orders 
                     WHERE OrderID NOT IN (SELECT OrderID FROM OrderDetails WHERE ProductID < 3));
---14
INSERT INTO Orders (OrderID, CustomerID, EmployeeID, OrderDate)
VALUES (11, 4, 4, '1998-08-18'),
		(12, 4, 4, '1998-08-18'),
		(13, 4, 4, '1998-08-18'),
		(14, 4, 4, '1998-08-18'),
		(15, 4, 4, '1998-08-18'),
		(16, 4, 4, '1998-08-18'),
		(17, 4, 4, '1998-08-18'),
		(18, 4, 4, '1998-08-18'),
		(19, 4, 4, '1998-08-18'),
		(20, 4, 4, '1998-08-18'),
		(21, 4, 4, '1998-08-18'),
		(22, 4, 4, '1998-08-18'),
		(23, 4, 4, '1998-08-18'),
		(24, 4, 4, '1998-08-18'),
		(25, 4, 4, '1998-08-18'),
		(26, 4, 4, '1998-08-18'),
		(27, 4, 4, '1998-08-18'),
		(28, 4, 4, '1998-08-18'),
		(29, 4, 4, '1998-08-18'),
		(30, 4, 4, '1998-08-18');
INSERT INTO OrderDetails (OrderID, ProductID, UnitPrice, Quantity, Discount)
VALUES (11, 5, 900.00, 1, 0.00),
		(12, 5, 900.00, 1, 0.00),
		(13, 5, 900.00, 1, 0.00),
		(14, 5, 900.00, 1, 0.00),
		(15, 5, 900.00, 1, 0.00),
		(16, 5, 900.00, 1, 0.00),
		(17, 5, 900.00, 1, 0.00),
		(18, 5, 900.00, 1, 0.00),
		(19, 5, 900.00, 1, 0.00),
		(20, 5, 900.00, 1, 0.00),
		(21, 5, 900.00, 1, 0.00),
		(22, 5, 900.00, 1, 0.00),
		(23, 5, 900.00, 1, 0.00),
		(24, 5, 900.00, 1, 0.00),
		(25, 5, 900.00, 1, 0.00),
		(26, 5, 900.00, 1, 0.00),
		(27, 5, 900.00, 1, 0.00),
		(28, 5, 900.00, 1, 0.00),
		(29, 5, 900.00, 1, 0.00),
		(30, 5, 900.00, 1, 0.00);
SELECT ProductID, ProductName
FROM Products
WHERE ProductID IN (
    SELECT ProductID
    FROM OrderDetails od
    JOIN Orders o ON od.OrderID = o.OrderID
    WHERE YEAR(o.OrderDate) = 1998 AND MONTH(o.OrderDate) BETWEEN 7 AND 9
    GROUP BY ProductID
    HAVING COUNT(DISTINCT od.OrderID) >= 20
);
---15
SELECT ProductID, ProductName
FROM Products
WHERE ProductID NOT IN (
    SELECT DISTINCT ProductID
    FROM OrderDetails od
    JOIN Orders o ON od.OrderID = o.OrderID
    WHERE YEAR(o.OrderDate) = 1996 AND MONTH(o.OrderDate) = 6
);
---16
SELECT EmployeeID, LastName, FirstName
FROM Employees
WHERE EmployeeID NOT IN (
    SELECT DISTINCT EmployeeID
    FROM Orders
    WHERE OrderDate = CAST(GETDATE() AS DATE)
);
---17
SELECT CustomerID, CompanyName
FROM Customers
WHERE CustomerID NOT IN (
    SELECT DISTINCT CustomerID
    FROM Orders
    WHERE YEAR(OrderDate) = 1997
);
---18
SELECT DISTINCT CustomerID, CompanyName
FROM Customers
WHERE CustomerID IN (
    SELECT DISTINCT CustomerID
    FROM Orders
    WHERE OrderID IN (
        SELECT DISTINCT OrderID
        FROM OrderDetails
        WHERE ProductID IN (
            SELECT ProductID
            FROM Products
            WHERE ProductName LIKE 'T%'
        )
    ) AND MONTH(OrderDate) = 7
);
---19
SELECT City
FROM Customers
GROUP BY City
HAVING COUNT(CustomerID) > 3;
---20 cau hoi truy van thu nhat'Liệt kê sản phẩm có giá cao hơn tất cả sản phẩm có tên bắt đầu bằng 'B'
--- truy vấn thứ hai 'Liệt kê sản phẩm có giá cao hơn ít nhất một sản phẩm có tên bắt đầu bằng 'B'?
---truy vấn thứ ba'Liệt kê sản phẩm có đơn giá bằng ít nhất một sản phẩm có tên bắt đầu bằng 'B'?
