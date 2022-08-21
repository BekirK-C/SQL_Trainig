USE Northwind

--1. Brazil�de bulunan m��terilerin �irket Ad�, Temsilci Ad�, Adres, �ehir, �lke bilgileri
SELECT [CompanyName], [ContactTitle], [Address], [City], [Country] FROM Customers 
WHERE Country='Brazil'

--2. Brazil�de olmayan m��teriler
SELECT * FROM Customers 
WHERE Country!='Brazil'

--3. �lkesi Spain, France ya da Germany olan m��teriler
SELECT * FROM Customers 
WHERE Country='Spain' OR Country='France' OR Country='Germany'

--4. Faks numaras� bilinmeyen m��teriler
SELECT * FROM Customers 
WHERE FAX IS NULL

--5. London�da ya da Paris�de bulunan m��teriler
SELECT * FROM Customers 
WHERE City='London' OR City='Paris'

--6. Hem Mexico D.F�de ikamet eden hem de ContactTitle bilgisi �owner� olan m��teriler
SELECT * FROM Customers 
WHERE City='M�xico D.F.' AND ContactTitle='Owner'

--7. C ile ba�layan �r�nlerin isimleri ve fiyatlar�
SELECT ProductName, UnitPrice FROM Products 
WHERE ProductName LIKE 'C%'

--8. Ad� �A� harfiyle ba�layan �al��anlar�n; Ad, Soyad ve Do�um Tarihleri
SELECT FirstName, LastName, BirthDate FROM Employees 
WHERE FirstName LIKE 'A%'

--9. �sminde �RESTAURANT� ge�en m��terilerin �irket adlar�
SELECT CompanyName FROM Customers 
WHERE CompanyName LIKE '%RESTAURANT%'

--10. 50$ ile 100$ aras�nda bulunan t�m �r�nlerin adlar� ve fiyatlar�
SELECT ProductName, UnitPrice FROM Products 
WHERE UnitPrice BETWEEN '50' AND '100'

--11. 1 temmuz 1996 ile 31 Aral�k 1996 tarihleri aras�ndaki sipari�lerin; Sipari�ID ve Sipari�Tarihi bilgileri
SELECT OrderID, OrderDate FROM Orders 
WHERE OrderDate BETWEEN '1996-07-01' AND '1996-12-31'

--12. M��terileri �lkeye g�re s�ralama
SELECT * FROM Customers 
ORDER BY Country

--13. �r�nleri pahal�dan ucuza do�ru s�ralay�p, sonu� olarak �r�n ad� ve fiyat�n� getirme
SELECT ProductName, UnitPrice FROM Products 
ORDER BY UnitPrice DESC

--14. �r�nleri pahal�dan ucuza do�ru s�ralay�p, stoklar�n� k���kten-b�y��e do�ru g�stersin, sonu� olarak �r�n ad� ve fiyat�n� getirme
SELECT ProductName, UnitPrice,UnitsInStock FROM Products 
ORDER BY UnitPrice DESC, UnitsInStock ASC

--15. 1 Numaral� kategoride ka� adet �r�n vard�r
SELECT C.CategoryName, COUNT(P.CategoryID) AS [Number of Products] FROM Products as P
INNER JOIN Categories AS C ON C.CategoryID=P.CategoryID
GROUP BY C.CategoryName, P.CategoryID
HAVING P.CategoryID=1 

--16. Ka� farkl� �lkeye ihracat yap�l�yor
SELECT COUNT(DISTINCT Country) AS [Number of Country] FROM Customers

--17. Bu �lkeler hangileri
SELECT DISTINCT Country AS [Countries] FROM Customers

--18. En pahal� 5 �r�n
SELECT TOP 5 ProductName, UnitPrice FROM Products 
ORDER BY UnitPrice DESC

--19. "ALFKI" CustomerID�sine sahip m��terinin sipari� say�s�
SELECT CustomerID, COUNT(CustomerID) AS [Number of Orders] FROM Orders
GROUP BY CustomerID
HAVING CustomerID='ALFKI'

--20. �r�nlerin toplam maliyeti
SELECT SUM(Freight) AS [Total Cost] FROM Orders

--21. �irketin �imdiye kadar kadar yapt��� ciro
SELECT SUM(UnitPrice * Quantity - (UnitPrice * Discount) * Quantity) AS [TOTAL TURNOVER] FROM [Order Details]

--22. Ortalama �r�n fiyat�m
SELECT AVG(UnitPrice) AS [Avarage Price] FROM Products

--23. En pahal� �r�n�n ad�
SELECT TOP 1 ProductName, UnitPrice FROM Products 
ORDER BY UnitPrice DESC

--24. En az kazand�ran sipari� (Kargo �cretini al�c� �d�yorsa)
SELECT TOP 1 OrderID, SUM(UnitPrice * Quantity - (UnitPrice * Discount) * Quantity) AS [Return on Sales] FROM [Order Details] 
GROUP BY OrderID 
ORDER BY [Return on Sales]

--25. En az kazand�ran sipari� (Kargo �cretini sat�c� �d�yorsa)
SELECT TOP 1 OD.OrderID,(SUM(UnitPrice * Quantity - (UnitPrice * Discount) * Quantity) - O.Freight) AS [Return on Sales] 
FROM [Order Details] AS OD 
INNER JOIN Orders    AS O ON OD.OrderID=O.OrderID
GROUP BY OD.OrderID,O.Freight 
ORDER BY [Return on Sales]

--26. En �ok sat�lan 15 �r�n
SELECT TOP 15 P.ProductName,OD.ProductID, SUM(OD.Quantity) AS [Number of Sales] FROM [Order Details] AS OD
INNER JOIN Orders   AS O ON OD.OrderID=O.OrderID 
INNER JOIN Products AS P ON P.ProductID=OD.ProductID
GROUP BY OD.ProductID, P.ProductName
ORDER BY [Number of Sales] DESC

--27. En �ok sat�� yap�lan 5 tarih
SELECT top 5 CONVERT(DATE, O.OrderDate) AS [ORDER DATES], SUM(OD.Quantity) AS [Number of Sales] FROM [Order Details] AS OD
INNER JOIN Orders AS O ON OD.OrderID=O.OrderID 
GROUP BY O.OrderDate
ORDER BY [Number of Sales] DESC

--28. En �ok sat�� yapan 3 personelin; ad�, soyad�, yapt��� sat�� say�s�
SELECT TOP 3 E.FirstName,E.LastName,SUM(Quantity) AS [Number of Sales] FROM [Order Details] AS OD
INNER JOIN Orders    AS O ON O.OrderID=OD.OrderID
INNER JOIN Employees AS E ON E.EmployeeID=O.EmployeeID
GROUP BY E.FirstName,E.LastName
ORDER BY [Number of Sales] DESC