/*Fact Table*/
SELECT *
FROM [AdventureWorks2022].[Sales].[SalesOrderHeader] F1 left join [AdventureWorks2022].[Sales].[SalesOrderDetail] F2
on F1.SalesOrderID = F2.SalesOrderID
----------------------------------------------------------
/*Dates Dimension */
SELECT MAX(OrderDate) , MAX(DueDate) , MAX(ShipDate)
FROM [AdventureWorks2022].[Sales].[SalesOrderHeader]

SELECT MIN(OrderDate) , MIN(DueDate) , MIN(ShipDate)
FROM [AdventureWorks2022].[Sales].[SalesOrderHeader]

-- max date = 2014 - 7 - 12
-- min date = 2011 - 5 - 31
----------------------------------------------------------
/*SalesPersons Dimension */
SELECT *
FROM [AdventureWorks2022].[Sales].[vSalesPerson]

SELECT SalesPersonID
FROM [AdventureWorks2022].[Sales].[SalesOrderHeader]
----------------------------------------------------------
/*Territories Dimension */
SELECT *
FROM [AdventureWorks2022].[Sales].[SalesTerritory]
----------------------------------------------------------
/*ShipMethods Dimension */
SELECT *
FROM [AdventureWorks2022].[Purchasing].[ShipMethod]
----------------------------------------------------------
/*Products Dimension */
SELECT *
FROM [AdventureWorks2022].[Production].[Product]
----------------------------------------------------------
/*Categories Dimension */
SELECT *
FROM [AdventureWorks2022].[Production].[ProductCategory]
----------------------------------------------------------
/* SubCategories Dimension */
SELECT *
FROM [AdventureWorks2022].[Production].[ProductSubcategory]

-----------------------------------------------------------------------------------------------------------------------------------------------------------------------
/*Number of Orders (Card Chart) */  --> 31465 order --> 31K thousands

select Count(Distinct F1.SalesOrderID) as Num_of_Orders  
FROM [AdventureWorks2022].[Sales].[SalesOrderHeader] F1 left join [AdventureWorks2022].[Sales].[SalesOrderDetail] F2
on F1.SalesOrderID = F2.SalesOrderID
-----------------------------------------------------------------------------------------------------------------------------------------------------------------------
/*Total Subtotal (Card Chart) */  --> 109846381.4039 --> $109.85 M Miilions

select sum(SubTotal) as Total_Subtotal  
FROM [AdventureWorks2022].[Sales].[SalesOrderHeader]
-----------------------------------------------------------------------------------------------------------------------------------------------------------------------
/*Total Taxes (Card Chart) */ --> 10186974.4602 --> $10.19 M Millions 

select sum(TaxAmt) as Total_taxes  
FROM [AdventureWorks2022].[Sales].[SalesOrderHeader] 
-----------------------------------------------------------------------------------------------------------------------------------------------------------------------
/*Total Freight (Card Chart) */ --> 3183430.2518 --> $3.18 M Millions  

select sum(Freight) as Total_Freight  
FROM [AdventureWorks2022].[Sales].[SalesOrderHeader] 
-----------------------------------------------------------------------------------------------------------------------------------------------------------------------/*Total Due (Card Chart) */ --> 2926970124.0414 --> $2.93bn  Biilions 
/*Total Due (Card Chart) */ -->  123216786.1159 --> $123.22 M  Millions
select sum(TotalDue) as Total_Due  
FROM [AdventureWorks2022].[Sales].[SalesOrderHeader] 
-----------------------------------------------------------------------------------------------------------------------------------------------------------------------
/*Total Quantity (Card Chart) */ --> 274914 --> 275K Thousands

select sum(F2.OrderQty) as Total_Quantity  
FROM [AdventureWorks2022].[Sales].[SalesOrderHeader] F1 left join [AdventureWorks2022].[Sales].[SalesOrderDetail] F2
on F1.SalesOrderID = F2.SalesOrderID
-----------------------------------------------------------------------------------------------------------------------------------------------------------------------
/*Number of orders per Order Date */

select  year(orderdate) as DateYears , count(distinct SalesOrderID) as Num_Of_Orders
FROM [AdventureWorks2022].[Sales].[SalesOrderHeader] 
group by year(orderdate)
order by DateYears
-----------------------------------------------------------------------------------------------------------------------------------------------------------------------
/*Number of orders per Ship Date  */

select  year(ShipDate) as DateYears , count(distinct SalesOrderID) as Num_Of_Orders
FROM [AdventureWorks2022].[Sales].[SalesOrderHeader] 
group by year(ShipDate)
order by DateYears
-----------------------------------------------------------------------------------------------------------------------------------------------------------------------
/*Number of orders per Due date */

select  year(DueDate) as DateYears , count(distinct SalesOrderID) as Num_Of_Orders
FROM [AdventureWorks2022].[Sales].[SalesOrderHeader] 
group by year(DueDate)
order by DateYears
-----------------------------------------------------------------------------------------------------------------------------------------------------------------------/*Number of Orders & total Due By Territory */
/*
	Name				Num_Of_Orders			Total_Due
	Australia				6843				11814376.0952	($11.81 M)
	Southwest				6224				27150594.5893	($27.15 M) 
	Northwest				4594				18061660.371	($18.10 M)
	Canada					4067				18398929.188	($18.40 M)
	United Kingdom			3219				8574048.7082	($8.57  M) 
	France					2672				8119749.346		($8.12	M) 
	Germany					2623				5479819.5755	($5.48	M)
	Southeast				486					8884099.3669	($8.88	M)
	Central					385					8913299.2473	($8.91	M)
	Northeast				352					7820209.6285	($7.82	M)
*/
select	T.Name , 
		count(distinct F1.SalesOrderID) as Num_Of_Orders , 
		Sum(F1.TotalDue) as Total_Due 
FROM [AdventureWorks2022].[Sales].[SalesOrderHeader] F1 left join [AdventureWorks2022].[Sales].[SalesTerritory] T
on T.TerritoryID = F1.TerritoryID
group by T.Name
order by Num_Of_Orders desc
-----------------------------------------------------------------------------------------------------------------------------------------------------------------------/*Number Of Orders per Category*/
/* Number of orders by Categories  */

select  D4.Name , Count(Distinct F.SalesOrderID) as Num_of_Orders 
from [AdventureWorks2022].[Sales].[SalesOrderHeader] F inner join [AdventureWorks2022].[Sales].[SalesOrderDetail] D1
on D1.SalesOrderID = F.SalesOrderID
inner join [AdventureWorks2022].[Production].[Product] D2
on D2.ProductID = D1.ProductID
inner join [AdventureWorks2022].[Production].[ProductSubcategory] D3
on D3.ProductSubcategoryID = D2.ProductSubcategoryID
inner join [AdventureWorks2022].[Production].[ProductCategory] D4
on D4.ProductCategoryID = D3.ProductCategoryID
group by D4.Name
-----------------------------------------------------------------------------------------------------------------------------------------------------------------------
/*Number of Orders per SubCategories */

select  D3.Name , Count(Distinct F.SalesOrderID) as Num_of_Orders 
from [AdventureWorks2022].[Sales].[SalesOrderHeader] F inner join [AdventureWorks2022].[Sales].[SalesOrderDetail] D1
on D1.SalesOrderID = F.SalesOrderID
inner join [AdventureWorks2022].[Production].[Product] D2
on D2.ProductID = D1.ProductID
inner join [AdventureWorks2022].[Production].[ProductSubcategory] D3
on D3.ProductSubcategoryID = D2.ProductSubcategoryID
group by D3.Name
order by Num_of_Orders desc
-----------------------------------------------------------------------------------------------------------------------------------------------------------------------
/*Number of Orders per Product */

select  D2.Name , Count(Distinct F.SalesOrderID) as Num_of_Orders 
from [AdventureWorks2022].[Sales].[SalesOrderHeader] F inner join [AdventureWorks2022].[Sales].[SalesOrderDetail] D1
on D1.SalesOrderID = F.SalesOrderID
inner join [AdventureWorks2022].[Production].[Product] D2
on D2.ProductID = D1.ProductID
group by D2.Name
order by Num_of_Orders desc
-----------------------------------------------------------------------------------------------------------------------------------------------------------------------/*Top 10 Sales Persons */
/*Top 10 Sales Persons by number of orders */

select  top 10 CONCAT_WS( ' ' , S.Title , S.FirstName , S.MiddleName , S.LastName) as SalesPersons,
		Count(Distinct F.SalesOrderID) as Num_of_Orders 
from [AdventureWorks2022].[Sales].[SalesOrderHeader] F left join [AdventureWorks2022].[Sales].[vSalesPerson] S
on S.BusinessEntityID = F.SalesPersonID
group by CONCAT_WS( ' ' , S.Title , S.FirstName , S.MiddleName , S.LastName)
order by Num_of_Orders desc
-----------------------------------------------------------------------------------------------------------------------------------------------------------------------/*Number of Orders per ship mode */
/*Num Of orders by ship methods */

select SM.Name as Ship_Method , Count(Distinct F.SalesOrderID) as Num_of_Orders 
from [AdventureWorks2022].[Sales].[SalesOrderHeader] F left join [AdventureWorks2022].[Purchasing].[ShipMethod] SM
on SM.ShipMethodID = F.ShipMethodID
group by SM.Name
order by Num_of_Orders desc
-----------------------------------------------------------------------------------------------------------------------------------------------------------------------
/*Number of orders by Status */

select	case F.Status 
		WHEN 1 THEN 'In process'
        WHEN 2 THEN 'Approved'
        WHEN 3 THEN 'Backordered'
        WHEN 4 THEN 'Rejected'
        WHEN 5 THEN 'Shipped'
        WHEN 6 THEN 'Cancelled'
        ELSE '** Invalid **'
		END as Status ,
		Count(Distinct F.SalesOrderID) as Num_of_Orders 
from [AdventureWorks2022].[Sales].[SalesOrderHeader] F
group by F.Status
order by Num_of_Orders

-----------------------------------------------------------------------------------------------------------------------------------------------------------------------
/*Number of orders by online / offline */

select F.OnlineOrderFlag as Online_Flag , Count(Distinct F.SalesOrderID) as Num_of_Orders 
from [AdventureWorks2022].[Sales].[SalesOrderHeader] F 
group by F.OnlineOrderFlag
order by Num_of_Orders
-----------------------------------------------------------------------------------------------------------------------------------------------------------------------







