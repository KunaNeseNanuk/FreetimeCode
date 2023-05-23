--- kolik zip začíná číslicí 2 
SELECT
    COUNT(*) AS ZipCount
FROM
    Country
WHERE
    Zip LIKE '2%'


SELECT
    COUNT(*) AS ZipCount
FROM
    Country
WHERE
    Zip LIKE '2%'  
 -- Kolik ZIP kódů začíná číslicí 2?
SELECT
    COUNT(*) AS ZipCount
FROM
    Country
WHERE
    LEFT(Zip, 1) = '2'
--Kolik ZIP kódů obsahuje číslici 3?
SELECT
    COUNT(*) AS ZipCount
FROM
    Country
WHERE
    Zip LIKE '%3%'
--Kolik ZIP kódů končí číslicí 3?
SELECT
    COUNT(*) AS ZipCount
FROM
    Country
WHERE
    Zip LIKE '%3'
--Kolik ZIP kódů končí číslicí 3?
SELECT
    COUNT(*) AS ZipCount
FROM
    Country
WHERE
    RIGHT(Zip, 1) = '3'
--Kolik ZIP kódů obsahuje číslici 3 alespoň dvakrát?
SELECT
    COUNT(*) AS ZipCount
FROM
    Country
WHERE
    Zip LIKE '%3%3%' 
--Kolik jsme utržili za posledních 7 let?
SELECT
    SUM(Revenue)
FROM
    Sales
WHERE
    DATEDIFF(YEAR, Date, CURRENT_TIMESTAMP) <= 7
--Vypište posledních 20 prodejů
SELECT TOP 20
	*
FROM
	Sales
ORDER BY
	Date DESC
--Vypište prvních 100 výrobků začínajících písmenem F
SELECT TOP 100
    *
FROM
    Product
WHERE
    Product LIKE N'F%'
ORDER BY
    Product ASC
--Kolik výrobků vyrábí společnost Abbas?
SELECT
    COUNT(*)
FROM
    Product
WHERE
    Product LIKE N'Abbas%'
--Vypište všechna města státu New Hampshire (NH)
SELECT
    DISTINCT City 
FROM 
    Country
WHERE
    State = N'NH'
--Kolik Zip kódů má stát Florida (FL)?
SELECT
    COUNT(*) 
FROM 
    Country
WHERE
    State = N'FL'
--Kolik prodejů proběhlo 21. června 2015?
SELECT
    COUNT(*)
FROM
    Sales
WHERE
    Date >= '2015-06-21' AND Date < '2015-06-22'
--Kolik prodejů proběhlo 21. června 2015?
SELECT
    COUNT(*)
FROM
    Sales
WHERE
    DATEPART(YEAR, Date) = 2015 AND
    DATEPART(MONTH, Date) = 6 AND
    DATEPART(DAY, Date) = 21
--Na který den v týdnu připadnou 30. narozeniny člověka, který se narodil dnes?
SET DATEFIRST 1

SELECT 
    DATEPART(WEEKDAY, 
		DATEADD(YEAR, 30, CURRENT_TIMESTAMP)
	)
--A kolik že jsme toho prodali za 2014?
SELECT
	SUM(Revenue)
FROM
	Sales
WHERE
	[Date] >= '2014-01-01'
	AND [Date] < '2015-01-01'
-- na čem jsme vydělali nejvíc 

SELECT
	ProductID,
	SUM(Revenue)
FROM
	Sales
WHERE
	DATEPART(YEAR, Date) = 2014
GROUP BY
	ProductID
ORDER BY
	SUM(Revenue)
--Aha… A co leden 2014 vs. leden 2015
SELECT
	DATEPART(YEAR, Date),
	SUM(Revenue)
FROM
	Sales
WHERE
	DATEPART(YEAR, Date) IN (2014, 2015)
	AND DATEPART(MONTH, Date) = 1
GROUP BY
	DATEPART(YEAR, Date)
ORDER BY
	SUM(Revenue) DESC
--Kolik máme produktů (ProductId) v kategorii Rural?
SELECT
	COUNT(ProductID) AS ProductCount
FROM
	Product
WHERE
	Category = N'Rural'
--Čeho jsme prodali nejvíc kusů?
SELECT TOP 10
	ProductID,
	SUM(Units) AS UnitsCount
FROM
	Sales
GROUP BY
	ProductID
ORDER BY
	UnitsCount DESC
--Který výrobce má nejvíce kategorií výrobků?
SELECT TOP 10
	ManufacturerID,
	COUNT(DISTINCT Category) AS CategoriesCount
FROM
	Product
GROUP BY
	ManufacturerID
ORDER BY
	CategoriesCount DESC
--Kolik Zip kódů má stát Florida (FL)?
SELECT
    COUNT(Zip) 
FROM 
    Country
WHERE
    State = N'FL'
--Kolik měst má stát Florida (FL)?
SELECT
    COUNT(DISTINCT City) 
FROM 
    Country
WHERE
    State = N'FL'
--Kolik Zip kódů mají jednotlivá města ve státě Florida (FL)?
SELECT
    City,
    COUNT(Zip) AS ZipCodes
FROM
    Country
WHERE
    State = N'FL'
GROUP BY
    City
--Vypište města ve státě Florida, která mají více Zip kódů
SELECT
    City
FROM
    Country
WHERE
    State = N'FL'
GROUP BY
    City
HAVING
	COUNT(Zip) > 1
--Které floridské město je zhruba stejně velké jako Brno?
--Hint: Brno má 32 různých PSČ

SELECT
    City,
    COUNT(Zip) AS ZipCodes
FROM
    Country
WHERE
    State = N'FL'
GROUP BY
    City
HAVING
    COUNT(Zip) BETWEEN 30 AND 35
--Kolik průměrně vyděláme za jednotlivé produkty? (podle ProductID)
SELECT TOP 100
	ProductID,
	AVG(Revenue) AS AverageRevenue
FROM
	Sales
GROUP BY
	ProductID
ORDER BY
	AverageRevenue DESC
--Kolik průměrně vyděláme za jednotlivé produkty? (podle ProductID)
SELECT TOP 100
	ProductID,
	AVG(Revenue) AS AverageRevenue,
	AVG(Revenue / Units) AS AverageUnitRevenue,
	SUM(Revenue) / SUM(Units) AS AverageUnitRevenue2
FROM
	Sales
GROUP BY
	ProductID
ORDER BY
	AverageRevenue DESC
--Ve kterém segmentu působí nejvíce výrobců?
SELECT TOP 10
	Segment,
	COUNT(DISTINCT ManufacturerID) AS ManufacturersCount
FROM
	Product
GROUP BY
	Segment
ORDER BY
	ManufacturersCount DESC
--Jaké byly největší prodeje na jednotlivých Zip kódech?
SELECT
    Zip,
    MAX(Revenue) AS MaxRevenue
FROM
    Sales
GROUP BY
    Zip
ORDER BY
    MaxRevenue DESC
--Jaké jsou rozsahy Zip kódů jednotlivých států?
SELECT
    State,
    MIN(Zip) AS MinZip,
    MAX(Zip) AS MaxZip
FROM
    Country
GROUP BY
    State
ORDER BY
    State
--Který stát má nejvíce měst?
SELECT
    State,
    COUNT(DISTINCT City) AS Cities
FROM
    Country
GROUP BY
    State
ORDER BY
    Cities DESC
--Které město má nejvíce ZIP kódů?
SELECT
    City,
    COUNT(DISTINCT Zip) AS ZipCount
FROM
    Country
GROUP BY
    City
ORDER BY
    ZipCount DESC
--Jaká je nejčastější první číslice ZIP kódu?
SELECT
    LEFT(Zip, 1) AS FirstDigit,
    COUNT(*) AS ZipCount
FROM
    Country
GROUP BY
    LEFT(Zip, 1)
ORDER BY
    ZipCount DESC
--Jaký byl nejmenší, průměrný a největší počet prodaných ks v jednotlivých měsících roku 2014?
SELECT
    DATEPART(MONTH, Date) AS Month,
    MIN(Units) AS MinUnits,
    AVG(Units) AS AvgUnits,
    MAX(Units) AS MaxUnits
FROM
    Sales
WHERE
    DATEPART(YEAR, Date) = 2014
GROUP BY
    DATEPART(MONTH, Date)
ORDER BY
    Month ASC
--Ve kterém regionu jsme v červenci 2014 vydělali nejvíc?
SELECT TOP 1 WITH TIES
    c.Region,
    SUM(s.Revenue) AS TotalRevenue
FROM
    Sales s
    JOIN Country c ON c.Zip = s.Zip
WHERE
    YEAR(Date) = 2014 AND
    MONTH(Date) = 7
GROUP BY
    c.Region
ORDER BY
    TotalRevenue DESC
--Který výrobce prodal nejvíce kusů výrobků řady UM?
SELECT
    m.Manufacturer,
    SUM(s.Units) AS TotalUnits
FROM
    Sales s
    JOIN Product p ON s.ProductID = p.ProductID
    JOIN Manufacturer m ON p.ManufacturerID = m.ManufacturerID
WHERE
    p.Product LIKE N'% UM-%'
GROUP BY
    m.Manufacturer
ORDER BY
    TotalUnits DESC
--Které státy vydělaly nejvíce v kategorii Urban?
SELECT
    c.State,
    SUM(s.Revenue) AS TotalRevenue
FROM
    Sales s
    JOIN Product p ON s.ProductID = p.ProductID
    JOIN Country c ON c.Zip = s.Zip
WHERE
    p.Category = N'Urban'
GROUP BY
    c.State
ORDER BY
    TotalRevenue DESC
--Ve kterém městě vydělala společnost Abbas nejvíce v segmentu Youth?
SELECT TOP 1 WITH TIES
    c.City,
    SUM(s.Revenue) AS TotalRevenue
FROM
    Sales s
    JOIN Country c ON c.Zip = s.Zip
    JOIN Product p ON p.ProductID = s.ProductID
    JOIN Manufacturer m ON m.ManufacturerID = p.ManufacturerID
WHERE
    m.Manufacturer = N'Abbas' AND
    p.Segment = N'Youth'
GROUP BY
    c.City
ORDER BY
    TotalRevenue DESC
--Kolik prodejů se uskutečnilo v dubnu 2014
SELECT
    COUNT(*) AS SalesCount
FROM
    Sales
WHERE
    DATEPART(YEAR, Date) = 2014 AND
    DATEPART(MONTH, Date) = 4
--Vypište všechny Bostony v USA
SELECT
    *
FROM
    Country 
WHERE
    City 
LIKE 
    N'Boston,%'
---Ve které oblasti (ZIP) jsme v dubnu 2014 vydělali nejvíce?
SELECT TOP 1 WITH TIES
    Zip,
    SUM(Revenue) AS TotalRevenue
FROM
    Sales
WHERE
    DATEPART(YEAR, Date) = 2014 AND
    DATEPART(MONTH, Date) = 4
GROUP BY
    Zip
ORDER BY
    TotalRevenue DESC
---Která kategorie obsahuje nejvíce segmentů?
SELECT TOP 1 WITH TIES
    Category,
    COUNT(DISTINCT Segment) AS Segments
FROM
    Product
GROUP BY
    Category
ORDER BY
    Segments DESC
---Který stát má nejméně měst?
SELECT TOP 1 WITH TIES
    State,
    COUNT(DISTINCT City) AS Cities
FROM
    Country
GROUP BY
    State
ORDER BY
    Cities ASC
---Jaký název města se objevuje v nejvíce státech?
---Hint: Použijte CHARINDEX k oříznutí podle čárky
SELECT
    LEFT(City, CHARINDEX(',', City) - 1),
    COUNT(DISTINCT State) AS States
FROM
    Country
GROUP BY
    LEFT(City, CHARINDEX(',', City) - 1)
ORDER BY
    States DESC
---(INNER) JOIN – Spojení tabulek Sales a Country
SELECT TOP 100
	*
FROM
	Sales s
	JOIN Country c ON s.Zip = c.Zip
---(INNER) JOIN – Spojení tabulek Sales a Product
SELECT TOP 100
	*
FROM
	Sales s
	JOIN Product p ON s.ProductID = p.ProductID
---Ve kterých státech jsme vydělali nejvíc?
SELECT
	State,
	SUM(Revenue)
FROM
	Sales s
	JOIN Country c ON s.Zip = c.Zip
GROUP BY
	State
ORDER BY
	SUM(Revenue) DESC
---Kterého výrobku se prodalo nejvíc kusů?
SELECT TOP 1 WITH TIES
    Product,
    SUM(Units) AS TotalUnits
FROM
    Sales s
    JOIN Product p ON s.ProductID = p.ProductID
GROUP BY
    Product
ORDER BY
    TotalUnits DESC
---Který výrobce vyrábí nejvíce různých výrobků?
SELECT
	m.Manufacturer,
	COUNT(ProductID)
FROM
	Product p
	JOIN Manufacturer m
		ON p.ManufacturerID = m.ManufacturerID
GROUP BY
	m.Manufacturer
ORDER BY
	COUNT(DISTINCT ProductID) DESC
---Který výrobce působí v nejvíce segmentech?
SELECT
	m.Manufacturer,
	COUNT(DISTINCT Segment)
FROM
	Product p
	JOIN Manufacturer m
		ON p.ManufacturerID = m.ManufacturerID
GROUP BY
	m.Manufacturer
ORDER BY
	COUNT(DISTINCT Segment) DESC
---Které státy nám nejvíce vydělávají v různých kategoriích?
SELECT
	Category,
	State,
	SUM(Revenue)
FROM
	Sales s
	JOIN Product p ON s.ProductID = p.ProductID
	JOIN Country c ON c.Zip = s.Zip
GROUP BY
	Category,
	State
ORDER BY
	Category,
	SUM(Revenue) DESC
---Ve kterých kategoriích mají jednotlivé státy největší tržby?

SELECT
	Category,
	State,
	SUM(Revenue)
FROM
	Sales s
	JOIN Product p ON s.ProductID = p.ProductID
	JOIN Country c ON c.Zip = s.Zip
GROUP BY
	Category,
	State
ORDER BY
	State,
	SUM(Revenue) DESC
---Kterému výrobku se daří v nejvíce státech?
SELECT TOP 1 WITH TIES
    Product,
    COUNT(DISTINCT State) AS StatesCount
FROM
    Sales s
    JOIN Product p ON p.ProductID = s.ProductID
    JOIN Country c ON c.Zip = s.Zip
GROUP BY
    Product
ORDER BY
    StatesCount DESC
---Který výrobce prodal nejvíce výrobků v prosinci 2014?
SELECT TOP 1
	m.Manufacturer,
	SUM(s.Units) AS UnitsSold
FROM
	Sales s
	JOIN Product p ON p.ProductID = s.ProductID
	JOIN Manufacturer m ON m.ManufacturerID = p.ManufacturerID
WHERE
	DATEPART(YEAR, s.Date) = 2014 AND
	DATEPART(MONTH, s.Date) = 12
GROUP BY
	m.Manufacturer
ORDER BY
	SUM(s.Units) DESC
---Na kterých kategoriích výrobků vydělává společnost Abbas nejvíce?
SELECT
	p.Category,
	SUM(Revenue)
FROM
	Sales s
	JOIN Product p ON p.ProductID = s.ProductID
	JOIN Manufacturer m ON m.ManufacturerID = p.ManufacturerID
WHERE
	m.Manufacturer = N'Abbas'
GROUP BY
	p.Category
ORDER BY
	SUM(Revenue) DESC
---Kolik kusů výrobku Fama UR-40 se prodalo v jednotlivých státech?
SELECT
	c.State,
	SUM(s.Units) AS UnitsSold
FROM
	Sales s
	JOIN Country c ON s.Zip = c.Zip
	JOIN Product p ON p.ProductID = s.ProductID
WHERE
	p.Product = N'Fama UR-40'
GROUP BY
	c.State
ORDER BY
	SUM(s.Units) DESC
---Jaké jsou v jednotlivých regionech tržby za výrobky společnosti Natura?
SELECT
	Region,
	SUM(Revenue)
FROM
	Sales s
	JOIN Country c ON s.Zip = c.Zip
	JOIN Product p ON p.ProductID = s.ProductID
	JOIN Manufacturer m ON m.ManufacturerID = p.ManufacturerID
WHERE
	m.Manufacturer = N'Natura'
GROUP BY
	Region
ORDER BY
	SUM(Revenue) DESC
---Která města začínají písmenem X?
SELECT
    City
FROM
    Country
WHERE
    City LIKE N'X%'
---Kterým písmenem začíná nejvíce měst?
SELECT TOP 1 WITH TIES
    LEFT(City, 1) AS FirstLetter,
    COUNT(DISTINCT City) AS Cities
FROM
    Country
GROUP BY
    LEFT(City, 1)
ORDER BY
    Cities DESC
---Kolik se prodalo výrobků řady UM-01?
SELECT
    SUM(Units) AS TotalUnits
FROM
    Sales s
    JOIN Product p ON s.ProductID = p.ProductID
WHERE
    p.Product LIKE N'% UM-01'
---Kolik jsme vydělali v jednotlivých regionech?
SELECT
    Region,
    SUM(Revenue) AS TotalRevenue
FROM
    Sales s
    JOIN Country c ON s.Zip = c.Zip
GROUP BY
    Region
ORDER BY
    TotalRevenue DESC
---Který výrobce prodává v nejméně státech?
SELECT TOP 1 WITH TIES
    Manufacturer,
    COUNT(DISTINCT State) AS StateCount
FROM
    Sales s
    JOIN Country c ON s.Zip = c.Zip
    JOIN Product p ON s.ProductID = p.ProductID
    JOIN Manufacturer m ON p.ManufacturerID = m.ManufacturerID
GROUP BY
    Manufacturer
ORDER BY
    StateCount ASC
---Které výrobky se neprodávaly?
SELECT
	*
FROM
	Product p
	LEFT JOIN Sales s ON p.ProductID = s.ProductID
WHERE
	s.Date IS NULL
---Kteří výrobci neprodávají zboží z kategorie Rural?
SELECT
    m.[Manufacturer]
FROM
    Sales s
    JOIN Product p ON s.[ProductID] = p.[ProductID] AND p.[Category] = N'Rural'
    RIGHT JOIN Manufacturer m ON p.[ManufacturerID] = m.[ManufacturerID]
WHERE
    p.[ProductID] IS NULL
ORDER BY
    m.[Manufacturer]
---Kteří výrobci nemají výrobky a které výrobky nemají výrobce?
SELECT
	*
FROM
	Product p
	FULL JOIN Manufacturer m ON p.ManufacturerID = m.ManufacturerID
WHERE
	m.Manufacturer IS NULL OR
	p.Product IS NULL
---Vypište pro všechny státy město s nejvyšším ZIP kódem?
SELECT
    c1.State,
    c1.Zip,
    c1.City
FROM
    Country c1
    LEFT JOIN Country c2 ON c1.State = c2.State AND c2.Zip > c1.Zip
WHERE
    c2.Zip IS NULL
ORDER BY
    c1.State
---Které výrobky se neprodávaly před rokem 2014?
SELECT
    Product
FROM
    Product p
    LEFT JOIN Sales s ON p.ProductID = s.ProductID AND s.Date < '2014-01-01'
WHERE
    s.ProductID IS NULL
ORDER BY
    Product
---Které výrobky se neprodávaly před rokem 2014?
SELECT
    p.Product
FROM
    Product p
    LEFT JOIN Sales s ON p.ProductID = s.ProductID
GROUP BY
    p.ProductID,
    p.Product
HAVING
    MIN(Date) >= '2014-01-01' OR
    MIN(Date) IS NULL
ORDER BY
    p.Product
---Kteří výrobci nemají žádný výrobek v kategorii Rural?
SELECT
    m.[Manufacturer]

FROM
    Manufacturer m
    LEFT JOIN Product p
	ON m.[ManufacturerID] = p.[ManufacturerID] AND p.[Category] = N'Rural'
WHERE
    p.[ProductID] IS NULL
ORDER BY
    m.Manufacturer ASC
---Kteří výrobci neprodali od 1.1.2015 žádný výrobek?
SELECT
    m.[Manufacturer]
FROM
    Product p
    JOIN Sales s ON s.[ProductID] = p.[ProductID] AND s.[Date] > '2015-01-01'
    RIGHT JOIN Manufacturer m ON p.[ManufacturerID] = m.[ManufacturerID]
WHERE
    s.[ProductID] IS NULL
GROUP BY
    m.[Manufacturer]
---Ve které oblasti (regionu) jsme vydělali nejvíc?
SELECT
	c.Region,
	SUM(s.Revenue)
FROM
	Sales s
	JOIN Country c ON s.Zip = c.Zip
GROUP BY
	c.Region
ORDER BY
	SUM(s.Revenue) DESC
---Který výrobce nám vydělal nejvíc celkem?
SELECT
	m.Manufacturer,
	SUM(s.Revenue) AS TotalRevenue
FROM
	Sales s
	JOIN Product p ON s.ProductID = p.ProductID
	JOIN Manufacturer m ON p.ManufacturerID = m.ManufacturerID
GROUP BY
	m.Manufacturer
ORDER BY
	SUM(s.Revenue) DESC
---Kteří výrobci nám vydělali nejvíc v jednotlivých státech?
SELECT
	c.State,
	m.Manufacturer,
	SUM(s.Revenue) AS TotalRevenue
FROM
	Sales s
	JOIN Country c ON s.Zip = c.Zip
	JOIN Product p ON s.ProductID = p.ProductID
	JOIN Manufacturer m ON p.ManufacturerID = m.ManufacturerID
GROUP BY
	c.State,
	m.Manufacturer
ORDER BY
	c.State,
	SUM(s.Revenue) DESC
---Kolik bylo v jednotlivých státech měst, kde jsme v lednu 2014 nic neprodali?

SELECT
    State,
    COUNT(City) AS Cities
FROM
    Country c
    LEFT JOIN Sales s ON s.Zip = c.Zip AND 
	s.Date BETWEEN '2014-01-01' AND '2014-01-31'
WHERE
    s.ProductID IS NULL
GROUP BY
    State
ORDER BY
    Cities DESC
---Jaký je podíl výrobců na prodejích v jednotlivých státech?

;WITH StateRevenues AS
(
    SELECT
        State,
        SUM(TotalRevenue) AS StateRevenue
    FROM
        StateManufacturerView
    GROUP BY
        State
)
SELECT
    *,
    100.0 * TotalRevenue / StateRevenue AS RevenueShare
FROM
    StateManufacturerView smv
    JOIN StateRevenues sr ON smv.State = sr.State
ORDER BY
    smv.State ASC,
    smv.TotalRevenue DESC
---Kolik mají jednotliví výrobci produktů v jednotlivých kategoriích?
SELECT
	m.Manufacturer,
	p.Category,
	COUNT(p.ProductID) AS ProductCount
FROM
	Product p
	JOIN Manufacturer m ON p.ManufacturerID = m.ManufacturerID
GROUP BY
	m.Manufacturer,
	p.Category
    
---Která města mají v názvu „aa“?
SELECT
	DISTINCT City
FROM
	Country
WHERE
	City LIKE N'%aa%'

---Kolik měst začíná slovem „new“?
SELECT
	COUNT(DISTINCT City)
FROM
	Country
WHERE
	City LIKE N'new %'
---Kolik jsme vydělali ve 45. týdnu roku 2014?
SELECT
	SUM(Revenue) AS WeekRevenue
FROM
	Sales
WHERE
	DATEPART(YEAR, Date) = 2014 AND
	DATEPART(WEEK, Date) = 45
---Ve kterém regionu je nejvíce států?
SELECT
	Region,
	COUNT(DISTINCT State) AS States
FROM
	Country
GROUP BY
	Region
ORDER BY
	States DESC
---Vypište prodeje s nejnižší tržbou?
SELECT TOP 1 WITH TIES
	*
FROM
	Sales
ORDER BY
	Revenue ASC
---Vypište prodeje s nevyplněnou tržbou?

SELECT
	*
FROM
	Sales
WHERE
	Revenue IS NULL
---Který produkt (ProductID) má nejvyšší průměrný počet kusů v rámci jednoho prodeje, pokud uvažujeme jen faktury s částkou vyšší než 10000?

SELECT TOP 1 WITH TIES
	ProductID,
	AVG(Units) AS AvgUnits
FROM
	Sales
WHERE
	Revenue > 10000
GROUP BY
	ProductID
ORDER BY
	AvgUnits DESC
---Ve kterých letech jsme na Floridě vydělali přes 
--10 000 000?
SELECT
	DATEPART(YEAR, Date) AS Year,
	SUM(Revenue) AS TotalRevenue
FROM
	Sales s
	JOIN Country c ON s.Zip = c.Zip
WHERE
	c.State = N'FL'
GROUP BY
	DATEPART(YEAR, Date)
HAVING
	SUM(Revenue) > 10000000
---Které výrobky se nikdy neprodávaly?
SELECT
	Product
FROM
	Product p
	LEFT JOIN Sales s ON s.ProductID = p.ProductID
WHERE
	s.ProductID IS NULL
---Kolik výrobků řady UM se prodalo v roce 2013?
SELECT
	SUM(Units) AS TotalUnits
FROM
	Sales s
	JOIN Product p ON s.ProductID = p.ProductID
WHERE
	p.Product LIKE N'% UM-%' AND
	DATEPART(YEAR, s.Date) = 2013
---Ve kterém státě se prodalo nejvíce různých výrobků?
SELECT TOP 1 WITH TIES
	State,
	COUNT(DISTINCT ProductID) AS ProductCount
FROM
	Sales s
	JOIN Country c ON c.Zip = s.Zip
GROUP BY
	State
ORDER BY
	ProductCount DESC
---Ve kterém státě proběhlo nejvíce prodejů?
SELECT TOP 1 WITH TIES
	State,
	COUNT(*) AS SalesCount
FROM
	Sales s
	JOIN Country c ON c.Zip = s.Zip
GROUP BY
	State
ORDER BY
	SalesCount DESC














