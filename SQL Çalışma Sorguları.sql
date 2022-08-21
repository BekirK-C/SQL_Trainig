USE Northwind

--1. Brazil’de bulunan musterilerin Sirket Adi, Temsilci Adi, Adres, Sehir, ulke bilgileri
SELECT [CompanyName], [ContactTitle], [Address], [City], [Country] FROM Customers 
WHERE Country='Brazil'

--2. Brazil’de olmayan musteriler
SELECT * FROM Customers 
WHERE Country!='Brazil'

--3. Ulkesi Spain, France ya da Germany olan musteriler
SELECT * FROM Customers 
WHERE Country='Spain' OR Country='France' OR Country='Germany'

--4. Faks numarasi bilinmeyen musteriler
SELECT * FROM Customers 
WHERE FAX IS NULL

--5. London’da ya da Paris’de bulunan musteriler
SELECT * FROM Customers 
WHERE City='London' OR City='Paris'

--6. Hem Mexico D.F’de ikamet eden hem de ContactTitle bilgisi ‘owner’ olan musteriler
SELECT * FROM Customers 
WHERE City='México D.F.' AND ContactTitle='Owner'

--7. C ile baslayan urunlerin isimleri ve fiyatlari
SELECT ProductName, UnitPrice FROM Products 
WHERE ProductName LIKE 'C%'

--8. Adi ‘A’ harfiyle baslayan çalisanlarin; Ad, Soyad ve Dogum Tarihleri
SELECT FirstName, LastName, BirthDate FROM Employees 
WHERE FirstName LIKE 'A%'

--9. Ýsminde ‘RESTAURANT’ geçen musterilerin sirket adlari
SELECT CompanyName FROM Customers 
WHERE CompanyName LIKE '%RESTAURANT%'

--10. 50$ ile 100$ arasinda bulunan tum urunlerin adlari ve fiyatlari
SELECT ProductName, UnitPrice FROM Products 
WHERE UnitPrice BETWEEN '50' AND '100'

--11. 1 temmuz 1996 ile 31 Aralik 1996 tarihleri arasindaki siparislerin; SiparisID ve SiparisTarihi bilgileri
SELECT OrderID, OrderDate FROM Orders 
WHERE OrderDate BETWEEN '1996-07-01' AND '1996-12-31'

--12. Musterileri ulkeye gore siralama
SELECT * FROM Customers 
ORDER BY Country

--13. Urunleri pahalidan ucuza dogru siralayip, sonuç olarak urun adi ve fiyatini getirme
SELECT ProductName, UnitPrice FROM Products 
ORDER BY UnitPrice DESC

--14. Urunleri pahalidan ucuza dogru siralayip, stoklarini kuçukten-buyuge dogru gostersin, sonuç olarak urun adi ve fiyatini getirme
SELECT ProductName, UnitPrice,UnitsInStock FROM Products 
ORDER BY UnitPrice DESC, UnitsInStock ASC

--15. 1 Numarali kategoride kaç adet urun vardir
SELECT C.CategoryName, COUNT(P.CategoryID) AS [Number of Products] FROM Products as P
INNER JOIN Categories AS C ON C.CategoryID=P.CategoryID
GROUP BY C.CategoryName, P.CategoryID
HAVING P.CategoryID=1 

--16. Kaç farkli ulkeye ihracat yapiliyor
SELECT COUNT(DISTINCT Country) AS [Number of Country] FROM Customers

--17. Bu ulkeler hangileri
SELECT DISTINCT Country AS [Countries] FROM Customers

--18. En pahali 5 urun
SELECT TOP 5 ProductName, UnitPrice FROM Products 
ORDER BY UnitPrice DESC

--19. "ALFKI" CustomerID’sine sahip musterinin siparis sayisi
SELECT CustomerID, COUNT(CustomerID) AS [Number of Orders] FROM Orders
GROUP BY CustomerID
HAVING CustomerID='ALFKI'

--20. Urunlerin toplam maliyeti
SELECT SUM(Freight) AS [Total Cost] FROM Orders

--21. sirketin simdiye kadar kadar yaptigi ciro
SELECT SUM(UnitPrice * Quantity - (UnitPrice * Discount) * Quantity) AS [TOTAL TURNOVER] FROM [Order Details]

--22. Ortalama urun fiyatim
SELECT AVG(UnitPrice) AS [Avarage Price] FROM Products

--23. En pahali urunun adi
SELECT TOP 1 ProductName, UnitPrice FROM Products 
ORDER BY UnitPrice DESC

--24. En az kazandiran siparis (Kargo ucretini alici oduyorsa)
SELECT TOP 1 OrderID, SUM(UnitPrice * Quantity - (UnitPrice * Discount) * Quantity) AS [Return on Sales] FROM [Order Details] 
GROUP BY OrderID 
ORDER BY [Return on Sales]

--25. En az kazandiran siparis (Kargo ucretini satici oduyorsa)
SELECT TOP 1 OD.OrderID,(SUM(UnitPrice * Quantity - (UnitPrice * Discount) * Quantity) - O.Freight) AS [Return on Sales] 
FROM [Order Details] AS OD 
INNER JOIN Orders    AS O ON OD.OrderID=O.OrderID
GROUP BY OD.OrderID,O.Freight 
ORDER BY [Return on Sales]

--26. En çok satilan 15 urun
SELECT TOP 15 P.ProductName,OD.ProductID, SUM(OD.Quantity) AS [Number of Sales] FROM [Order Details] AS OD
INNER JOIN Orders   AS O ON OD.OrderID=O.OrderID 
INNER JOIN Products AS P ON P.ProductID=OD.ProductID
GROUP BY OD.ProductID, P.ProductName
ORDER BY [Number of Sales] DESC

--27. En çok satis yapilan 5 tarih
SELECT top 5 CONVERT(DATE, O.OrderDate) AS [ORDER DATES], SUM(OD.Quantity) AS [Number of Sales] FROM [Order Details] AS OD
INNER JOIN Orders AS O ON OD.OrderID=O.OrderID 
GROUP BY O.OrderDate
ORDER BY [Number of Sales] DESC

--28. En çok satis yapan 3 personelin; adi, soyadi, yaptigi satis sayisi
SELECT TOP 3 E.FirstName,E.LastName,SUM(Quantity) AS [Number of Sales] FROM [Order Details] AS OD
INNER JOIN Orders    AS O ON O.OrderID=OD.OrderID
INNER JOIN Employees AS E ON E.EmployeeID=O.EmployeeID
GROUP BY E.FirstName,E.LastName
ORDER BY [Number of Sales] DESC