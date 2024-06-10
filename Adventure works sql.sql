Select * from [Sales].[Customer]

select SalesOrderID,UnitPrice from [Sales].[SalesOrderDetail]
where 
OrderQty = 1;

select * from [Production].[Product]
select * from [Production].[ProductDescription]

Select e.Name, e.ProductNumber, s.ProductDescriptionID, s.Description from [Production].[Product] AS e
inner join [Production].[ProductDescription] AS s
on e.ProductID = s.ProductDescriptionID;

select * from [Production].[ProductCategory]


Select e.Name, e.ProductNumber, s.Description

 into [Production].[ProductDetail] 
from [Production].[Product] as e 
inner join [Production].[ProductDescription] AS s
on e.ProductID = s.ProductDescriptionID;


select * from [Production].[ProductDescription];
--Alter TABLE [Production].[ProductModel]
--Alter COLUMN Instructions XML;
--Update  [Production].[ProductModel]
--Set Instructions = coalesce(Instructions,'<root xmlns="http://schemas.microsoft.com/sqlserver/2004/07/adventure-works/ProductModelManuInstructions"/>')
--Where Instructions IS  NULL;

Select * from [Production].[ProductDetail] ;
Select * from [Purchasing].[PurchaseOrderDetail];

select * from [Production].[ProductModel]

WHERE Instructions IS NOT NULL;

Select m.Name, m.ProductNumber, m.[Description], r.UnitPrice,r.ReceivedQty,r.LineTotal, r.OrderQty
from [Production].[NewProductDetail] as m 
inner join [Purchasing].[PurchaseOrderDetail] as r 
on m.ProductDescriptionID = r.PurchaseOrderDetailID;


Alter table [Production].[ProductDetail] drop COLUMN ProductID ;

select * from [Production].[Product]
select * from [Production].[ProductDetail] 

select * from [Production].[ProductDescription];


Select k.Name, K.ProductNumber, h.Description, h.ProductDescriptionID 
into Production.NewProductDetail
FROM [Production].[Product]as k 
inner join [Production].[ProductDescription] as h 
on k.ProductID = h.ProductDescriptionID;

select * from Production.NewProductDetail;

SELECT * from [Production].[ProductDetail];

select * FROM [Sales].[Customer]
SELECT FirstName, LastName, EmailPromotion, Demographics from [Person].[Person];


Select * from [Sales].[SalesOrderDetail];
Select * from [Sales].[Customer];

---Find the top 10 customers by total sales amount

Select TOP 10 
c.CustomerID,
SUM( D.LineTotal) AS TotalAmount
from [Sales].[SalesOrderHeader] AS H
JOIN [Sales].[SalesOrderDetail] AS D ON H.SalesOrderID = D.SalesOrderID
JOIN [Sales].[Customer] AS c ON H.CustomerID = c.CustomerID
GROUP BY c.CustomerID
ORDER BY TotalAmount desc;

--Calculate the total sales amount for each product category for the last year.

select * from [Production].[ProductCategory]
select * from [Sales].[SalesOrderDetail];
SELECT * from [Production].[Product]
SELECT * from [Production].[ProductSubcategory];
select * from [Sales].[SalesOrderHeader]

select 
c.Name AS ProductCategoryName,
SUM(d.LineTotal) AS TotalSalesAmount
from [Sales].[SalesOrderDetail] d 
join [Production].[Product] p ON  d.ProductID = p.ProductID
JOIN [Production].[ProductSubcategory] sc ON P.ProductSubcategoryID = sc.ProductSubcategoryID
JOIN [Production].[ProductCategory] c ON sc.ProductCategoryID = c.ProductCategoryID
JOIN  [Sales].[SalesOrderHeader]h ON  d.SalesOrderID = h.SalesOrderID
where h.OrderDate >= '2013-01-01' AND h.OrderDate <= '2013-12-31'
GROUP BY c.Name
ORDER BY TotalSalesAmount desc;

select YEAR(OrderDate) AS OrderYear from [Sales].[SalesOrderHeader];
select distinct MONTH(OrderDate) as Ordermonth from [Sales].[SalesOrderHeader];


Select c.Name AS ProductCategoryName,
SUM(d.LineTotal) AS TotalSalesAmount from [Sales].[SalesOrderDetail] AS d 
JOIN [Production].[Product] as p ON d.ProductID = p.ProductID
JOIN [Production].[ProductSubcategory] sc ON  p.ProductSubCategoryID = sc.ProductSubCategoryID
JOIN [Production].[ProductCategory] c ON sc.ProductCategoryID = c.ProductCategoryID
GROUP BY c.Name
ORDER BY TotalSalesAmount desc;

---Identify the top 5 selling products and their total sales amount.
select * from [Sales].[SalesOrderDetail]
SELECT * from [Production].[Product];

Select TOP 5
p.Name AS ProductCategoryName,
SUM(d.LineTotal) AS TotalSalesAmount FROM [Sales].[SalesOrderDetail] d 
JOIN [Production].[Product] p ON d.ProductID = p.ProductID
GROUP BY p.Name
ORDER BY TotalSalesAmount desc;

---List all customers who made purchases in the last six months.
SELECT * FROM [Sales].[SalesOrderHeader]
SELECT * FROM [Sales].[Customer];
SELECT * from [Sales].[SalesOrderDetail]

Select cs.CustomerID,
SUM(d.LineTotal) AS TotalPurchaseAmount from [Sales].[SalesOrderHeader] h
JOIN [Sales].[SalesOrderDetail] d  ON h.SalesOrderID = d.SalesOrderID
JOIN [Sales].[Customer] cs ON h.CustomerID = cs.CustomerID
WHERE h.OrderDate >=  dateadd(m, -6, getdate())
GROUP BY cs.CustomerID
ORDER BY TotalPurchaseAmount desc;

--Sales by Territory: Compare total sales across different sales territories.
select * from [Sales].[SalesTerritory]
SELECT * FROM [Sales].[SalesOrderHeader]
SELECT * from [Sales].[SalesOrderDetail]

select st.Name as Territory, 
SUM(sd.LineTotal) as TotalSalesAmount FROM [Sales].[SalesOrderHeader] sh 
JOIN [Sales].[SalesTerritory] st ON sh.TerritoryID = st.TerritoryID
JOIN [Sales].[SalesOrderDetail] sd ON sh.SalesOrderID = sd.SalesOrderID
GROUP by st.Name
ORDER by TotalSalesAmount;

--Question: Sales Performance Over Time: Analyze sales trends by month, quarter or year.
Select  DATEPART(YEAR, sh.OrderDate) AS SalesYear,
SUM(sd.LineTotal) as TotalSalesAmount from [Sales].[SalesOrderHeader] sh 
Join [Sales].[SalesOrderDetail]sd ON sh.SalesOrderID = sd.SalesOrderID
Group by sh.OrderDate
Order by TotalSalesAmount desc;

SELECT 
    YEAR(OrderDate) AS Year,
    SUM(TotalDue) AS TotalSales
FROM Sales.SalesOrderHeader
GROUP BY YEAR(OrderDate)
ORDER BY Year;

--Customer Analysis: Identify top spending customers and their purchase behavior.
 select * from [Person].[Person]
 select * from [Sales].[Customer]
 select * from [Sales].[SalesOrderHeader]

 select TOP 10 
 --pp.BusinessEntityID, pp.FirstName + ' ' + pp.LastName AS CustomerName,
 COUNT(sh.SalesOrderID) AS NumberOfOrders,
 AVG(sh.TotalDue) AS AverageOrderValue,
 SUM(sh.TotalDue) as SalesAmount
      From [Sales].[SalesOrderHeader] as sh
      INNER JOIN [Sales].[Customer]cs ON cs.CustomerID = sh.CustomerID
      Inner join [Person].[Person] pp ON sh.CurrencyRateID = pp.BusinessEntityID
      GROUP by pp.BusinessEntityID, pp.FirstName, pp.LastName
     -- Order By SalesAmount desc;

     SELECT TOP 10
    pp.BusinessEntityID,
    pp.FirstName + ' ' + pp.LastName AS CustomerName,
    COUNT(sh.SalesOrderID) AS NumberOfOrders,
    AVG(sh.TotalDue) AS AverageOrderValue,
    SUM(sh.TotalDue) AS SalesAmount
FROM [Sales].[SalesOrderHeader] AS sh
INNER JOIN [Sales].[Customer] AS cs ON cs.CustomerID = sh.CustomerID
INNER JOIN [Person].[Person] AS pp ON cs.PersonID = pp.BusinessEntityID
GROUP BY pp.BusinessEntityID, pp.FirstName, pp.LastName
ORDER BY SalesAmount DESC;


--Profitability Analysis: Calculate profit margins for different product categories.
SELECT * from [Production].[Product]
SELECT * from [Sales].[SalesOrderDetail]
SELECT * from [Production].[ProductCategory]
SELECT * from [Production].[ProductSubcategory]

select 
pc.Name as ProductCategory,
SUM(sd.LineTotal) AS TotalSalesAmount,
SUM( pp.StandardCost * sd.OrderQty) as TotalCost,
(SUM(sd.LineTotal)  - SUM(pp.StandardCost * sd.OrderQty) ) AS TotalProfit,
((SUM(sd.LineTotal)  - SUM(pp.StandardCost * sd.OrderQty) ) / SUM(sd.LineTotal)) * 100 AS ProfitMarginPercentage
from [Sales].[SalesOrderDetail] sd
INNER join [Production].[Product] pp ON sd.ProductID = pp.ProductID
INNER JOIN [Production].[ProductSubCategory] ps ON pp.ProductSubcategoryID = ps.ProductSubcategoryID
INNER JOIN [Production].[ProductCategory] pc ON ps.ProductCategoryID = pc.ProductCategoryID
GROUP BY pc.Name
ORDER BY ProfitMarginPercentage desc;

SELECT 
    pc.Name AS ProductCategory,
    SUM(sod.LineTotal) AS TotalSalesAmount,
    SUM(p.StandardCost * sod.OrderQty) AS TotalCostAmount,
    (SUM(sod.LineTotal) - SUM(p.StandardCost * sod.OrderQty)) AS TotalProfit,
    ((SUM(sod.LineTotal) - SUM(p.StandardCost * sod.OrderQty)) / SUM(sod.LineTotal)) * 100 AS ProfitMarginPercentage
FROM Sales.SalesOrderDetail AS sod
INNER JOIN Production.Product AS p ON sod.ProductID = p.ProductID
INNER JOIN Production.ProductSubcategory AS psc ON p.ProductSubcategoryID = psc.ProductSubcategoryID
INNER JOIN Production.ProductCategory AS pc ON psc.ProductCategoryID = pc.ProductCategoryID
GROUP BY pc.Name
ORDER BY ProfitMarginPercentage DESC;
