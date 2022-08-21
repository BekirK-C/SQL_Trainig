USE Northwind

--1. Brazil’de bulunan müþterilerin Þirket Adý, Temsilci Adý, Adres, Þehir, Ülke bilgileri
SELECT [CompanyName], [ContactTitle], [Address], [City], [Country] FROM Customers 
WHERE Country='Brazil'

--2. Brazil’de olmayan müþteriler
SELECT * FROM Customers 
WHERE Country!='Brazil'

--3. Ülkesi Spain, France ya da Germany olan müþteriler
SELECT * FROM Customers 
WHERE Country='Spain' OR Country='France' OR Country='Germany'

--4. Faks numarasý bilinmeyen müþteriler
SELECT * FROM Customers 
WHERE FAX IS NULL

--5. London’da ya da Paris’de bulunan müþteriler
SELECT * FROM Customers 
WHERE City='London' OR City='Paris'

--6. Hem Mexico D.F’de ikamet eden hem de ContactTitle bilgisi ‘owner’ olan müþteriler
SELECT * FROM Customers 
WHERE City='México D.F.' AND ContactTitle='Owner'

--7. C ile baþlayan ürünlerin isimleri ve fiyatlarý
SELECT ProductName, UnitPrice FROM Products 
WHERE ProductName LIKE 'C%'

--8. Adý ‘A’ harfiyle baþlayan çalýþanlarýn; Ad, Soyad ve Doðum Tarihleri
SELECT FirstName, LastName, BirthDate FROM Employees 
WHERE FirstName LIKE 'A%'

--9. Ýsminde ‘RESTAURANT’ geçen müþterilerin þirket adlarý
SELECT CompanyName FROM Customers 
WHERE CompanyName LIKE '%RESTAURANT%'

--10. 50$ ile 100$ arasýnda bulunan tüm ürünlerin adlarý ve fiyatlarý
SELECT ProductName, UnitPrice FROM Products 
WHERE UnitPrice BETWEEN '50' AND '100'

--11. 1 temmuz 1996 ile 31 Aralýk 1996 tarihleri arasýndaki sipariþlerin; SipariþID ve SipariþTarihi bilgileri
SELECT OrderID, OrderDate FROM Orders 
WHERE OrderDate BETWEEN '1996-07-01' AND '1996-12-31'

--12. Müþterileri ülkeye göre sýralama
SELECT * FROM Customers 
ORDER BY Country

--13. Ürünleri pahalýdan ucuza doðru sýralayýp, sonuç olarak ürün adý ve fiyatýný getirme
SELECT ProductName, UnitPrice FROM Products 
ORDER BY UnitPrice DESC

--14. Ürünleri pahalýdan ucuza doðru sýralayýp, stoklarýný küçükten-büyüðe doðru göstersin, sonuç olarak ürün adý ve fiyatýný getirme
SELECT ProductName, UnitPrice,UnitsInStock FROM Products 
ORDER BY UnitPrice DESC, UnitsInStock ASC

--15. 1 Numaralý kategoride kaç adet ürün vardýr
SELECT C.CategoryName, COUNT(P.CategoryID) AS [Number of Products] FROM Products as P
INNER JOIN Categories AS C ON C.CategoryID=P.CategoryID
GROUP BY C.CategoryName, P.CategoryID
HAVING P.CategoryID=1 

--16. Kaç farklý ülkeye ihracat yapýlýyor
SELECT COUNT(DISTINCT Country) AS [Number of Country] FROM Customers

--17. Bu ülkeler hangileri
SELECT DISTINCT Country AS [Countries] FROM Customers

--18. En pahalý 5 ürün
SELECT TOP 5 ProductName, UnitPrice FROM Products 
ORDER BY UnitPrice DESC

--19. "ALFKI" CustomerID’sine sahip müþterinin sipariþ sayýsý
SELECT CustomerID, COUNT(CustomerID) AS [Number of Orders] FROM Orders
GROUP BY CustomerID
HAVING CustomerID='ALFKI'

--20. Ürünlerin toplam maliyeti
SELECT SUM(Freight) AS [Total Cost] FROM Orders

--21. Þirketin þimdiye kadar kadar yaptýðý ciro
SELECT SUM(UnitPrice * Quantity - (UnitPrice * Discount) * Quantity) AS [TOTAL TURNOVER] FROM [Order Details]

--22. Ortalama ürün fiyatým
SELECT AVG(UnitPrice) AS [Avarage Price] FROM Products

--23. En pahalý ürünün adý
SELECT TOP 1 ProductName, UnitPrice FROM Products 
ORDER BY UnitPrice DESC

--24. En az kazandýran sipariþ (Kargo ücretini alýcý ödüyorsa)
SELECT TOP 1 OrderID, SUM(UnitPrice * Quantity - (UnitPrice * Discount) * Quantity) AS [Return on Sales] FROM [Order Details] 
GROUP BY OrderID 
ORDER BY [Return on Sales]

--25. En az kazandýran sipariþ (Kargo ücretini satýcý ödüyorsa)
SELECT TOP 1 OD.OrderID,(SUM(UnitPrice * Quantity - (UnitPrice * Discount) * Quantity) - O.Freight) AS [Return on Sales] 
FROM [Order Details] AS OD 
INNER JOIN Orders    AS O ON OD.OrderID=O.OrderID
GROUP BY OD.OrderID,O.Freight 
ORDER BY [Return on Sales]

--26. En çok satýlan 15 ürün
SELECT TOP 15 P.ProductName,OD.ProductID, SUM(OD.Quantity) AS [Number of Sales] FROM [Order Details] AS OD
INNER JOIN Orders   AS O ON OD.OrderID=O.OrderID 
INNER JOIN Products AS P ON P.ProductID=OD.ProductID
GROUP BY OD.ProductID, P.ProductName
ORDER BY [Number of Sales] DESC

--27. En çok satýþ yapýlan 5 tarih
SELECT top 5 CONVERT(DATE, O.OrderDate) AS [ORDER DATES], SUM(OD.Quantity) AS [Number of Sales] FROM [Order Details] AS OD
INNER JOIN Orders AS O ON OD.OrderID=O.OrderID 
GROUP BY O.OrderDate
ORDER BY [Number of Sales] DESC

--28. En çok satýþ yapan 3 personelin; adý, soyadý, yaptýðý satýþ sayýsý
SELECT TOP 3 E.FirstName,E.LastName,SUM(Quantity) AS [Number of Sales] FROM [Order Details] AS OD
INNER JOIN Orders    AS O ON O.OrderID=OD.OrderID
INNER JOIN Employees AS E ON E.EmployeeID=O.EmployeeID
GROUP BY E.FirstName,E.LastName
ORDER BY [Number of Sales] DESC