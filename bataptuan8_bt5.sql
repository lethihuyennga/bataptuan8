USE QLBH
GO

---BÀI 5
---câu 1

SELECT COLUMN_NAME 
FROM INFORMATION_SCHEMA.COLUMNS 
WHERE TABLE_NAME = 'Employees';

UPDATE Employees 
SET HomePhone = '0123456789' 
WHERE EmployeeID = 1;

SELECT 
    CustomerID AS CodeID, 
    CompanyName AS Name, 
    Address, 
    NULL AS Phone  
FROM Customers

UNION ALL

SELECT 
    EmployeeID AS CodeID, 
    LastName + ' ' + FirstName AS Name, 
    City AS Address, 
    HomePhone AS Phone  
FROM Employees;

-- Câu 2
SELECT 
    c.CustomerID, 
    c.CompanyName, 
    c.Address, 
    SUM(od.Quantity * od.UnitPrice) AS ToTal
INTO HDKH_71997
FROM Orders o
JOIN Customers c ON o.CustomerID = c.CustomerID
JOIN OrderDetails od ON o.OrderID = od.OrderID
WHERE YEAR(o.OrderDate) = 1997 AND MONTH(o.OrderDate) = 7
GROUP BY c.CustomerID, c.CompanyName, c.Address;


SELECT * FROM HDKH_71997;


--- Câu 3
SELECT 
    e.EmployeeID, 
    e.LastName + ' ' + e.FirstName AS Name, 
    e.City AS Address, 
    SUM(od.Quantity * od.UnitPrice) AS ToTal
INTO LuongNV
FROM Employees e
JOIN Orders o ON e.EmployeeID = o.EmployeeID
JOIN OrderDetails od ON o.OrderID = od.OrderID
WHERE YEAR(o.OrderDate) = 1996 AND MONTH(o.OrderDate) = 12
GROUP BY e.EmployeeID, e.LastName, e.FirstName, e.City;

SELECT * FROM LuongNV;

---Câu 4
CREATE TABLE Shippers (
    ShipperID INT PRIMARY KEY,
    CompanyName VARCHAR(100)
);

-- Thêm dữ liệu ví dụ
INSERT INTO Shippers (ShipperID, CompanyName) 
VALUES 
(1, 'Gojek'),
(2, 'Lazada');


ALTER TABLE Orders
ADD ShipVia INT;

-- Giả sử ShipVia tham chiếu đến bảng Shippers
ALTER TABLE Orders
ADD FOREIGN KEY (ShipVia) REFERENCES Shippers(ShipperID);

UPDATE Orders
SET ShipVia = 1
WHERE OrderID = 1;

UPDATE Orders
SET ShipVia = 2
WHERE OrderID = 2;


SELECT 
    c.CustomerID, 
    c.CompanyName, 
    SUM(od.Quantity * od.UnitPrice) AS TotalAmount
FROM Orders o
JOIN Customers c ON o.CustomerID = c.CustomerID
JOIN OrderDetails od ON o.OrderID = od.OrderID
JOIN Shippers s ON o.ShipVia = s.ShipperID  -- Sử dụng ShipVia để tham chiếu đến công ty vận chuyển
WHERE s.CompanyName = 'Speedy Express'  -- Hoặc bạn có thể thay đổi thành tên công ty khác
    AND (c.Country = 'Germany' OR c.Country = 'USA')
    AND YEAR(o.OrderDate) = 1998
    AND MONTH(o.OrderDate) BETWEEN 1 AND 3  -- Quý 1: Tháng 1, 2, 3
GROUP BY c.CustomerID, c.CompanyName;

---Câu 5
CREATE TABLE dbo.HoaDonBanHang
(
    orderid INT NOT NULL,
    orderdate DATE NOT NULL,
    empid INT NOT NULL,
    custid VARCHAR(5) NOT NULL,
    qty INT NOT NULL,
    CONSTRAINT PK_Orders PRIMARY KEY(orderid)
);

INSERT INTO dbo.HoaDonBanHang (orderid, orderdate, empid, custid, qty) VALUES
(30001, '2007-08-02', 3, 'A', 10),
(10001, '2007-12-24', 2, 'A', 12),
(10005, '2007-12-24', 1, 'B', 20),
(40001, '2008-01-09', 2, 'A', 40),
(10006, '2008-01-18', 1, 'C', 14),
(20001, '2008-02-12', 2, 'B', 12),
(40005, '2009-02-12', 3, 'A', 10),
(20002, '2009-02-16', 1, 'C', 20),
(30003, '2009-04-18', 2, 'B', 15),
(30004, '2007-04-18', 3, 'C', 22),
(30007, '2009-09-07', 3, 'D', 30);

--- tính tổng Qty cho mỗi nhân viên
SELECT empid, SUM(qty) AS TotalQty
FROM dbo.HoaDonBanHang
GROUP BY empid;
---- tạo bảng Pivot
SELECT empid, A, B, C, D
FROM 
(
    SELECT empid, custid, qty
    FROM dbo.HoaDonBanHang
) 
AS D
PIVOT (
    SUM(qty) FOR custid IN (A, B, C, D)
	) 
AS P;

---- lấy dữ liệu từ bảng dbo.HoaDonBanHang trả về số hóa đơn đã lập của nhân viên employee trong mỗi năm.
SELECT empid, YEAR(orderdate) AS OrderYear, COUNT(orderid) AS OrderCount
FROM dbo.HoaDonBanHang
GROUP BY empid, YEAR(orderdate);

---- tạo bảng hiển thị số đơn đtawj hàng

SELECT 
    'Orders Count' AS Metric,
    ISNULL([164], 0) AS [164], 
    ISNULL([198], 0) AS [198], 
    ISNULL([223], 0) AS [223], 
    ISNULL([231], 0) AS [231], 
    ISNULL([233], 0) AS [233]
FROM (
    SELECT empid, orderid  -- Chọn cột empid và orderid từ bảng HoaDonBanHang
    FROM dbo.HoaDonBanHang
    WHERE empid IN (164, 198, 223, 231, 233)  -- Chỉ chọn những nhân viên có empid là 164, 198, 223, 231, 233
) AS SourceTable
PIVOT (
    COUNT(orderid)  -- Đếm số lượng đơn hàng cho mỗi nhân viên
    FOR empid IN ([164], [198], [223], [231], [233])  -- Pivot theo empid
) AS PivotTable;