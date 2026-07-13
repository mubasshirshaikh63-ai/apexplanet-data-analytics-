-- SELECT (Retrieving Data)
SELECT * FROM "Sales Data 2021"; -- Fetch all columns and rows

SELECT OrderNumber, ProductKey FROM "Sales Data 2021"; -- Select specific columns

SELECT DISTINCT TerritoryKey FROM "Sales Data 2021"; -- Get unique territory keys

SELECT OrderDate AS DateOfSale FROM "Sales Data 2021"; -- Rename column in result set

SELECT OrderQuantity * 2 FROM "Sales Data 2021"; -- Perform simple math on a column

SELECT OrderNumber || '-' || ProductKey FROM "Sales Data 2021"; -- Combine columns

SELECT COUNT(*) FROM "Sales Data 2021"; -- Count all records

SELECT OrderNumber, OrderQuantity FROM "Sales Data 2021" WHERE OrderQuantity > 5; -- Select with filter

SELECT 'Sales Record' AS Info, OrderNumber FROM "Sales Data 2021"; -- Add custom text column

SELECT MIN(OrderQuantity), MAX(OrderQuantity) FROM "Sales Data 2021";  -- Get range of quantities
--_________________________________________________________________________________________________________________________________________________________________________


--WHERE (Filtering)

SELECT * FROM "Sales Data 2021" WHERE OrderQuantity > 10; -- Filter by quantity

SELECT * FROM "Sales Data 2021" WHERE TerritoryKey = 3; -- Filter by territory

SELECT * FROM "Sales Data 2021" WHERE OrderDate = '2021-05-20'; -- Filter by specific date

SELECT * FROM "Sales Data 2021" WHERE ProductKey IN (100, 101, 102); -- Filter by multiple keys

SELECT * FROM "Sales Data 2021" WHERE OrderNumber LIKE 'SO%'; -- Pattern matching

SELECT * FROM "Sales Data 2021" WHERE OrderQuantity BETWEEN 5 AND 10; -- Filter by range

SELECT * FROM "Sales Data 2021" WHERE OrderQuantity <> 1; -- Not equal filter

SELECT * FROM "Sales Data 2021" WHERE TerritoryKey IS NOT NULL; -- Exclude empty values

SELECT * FROM "Sales Data 2021" WHERE OrderQuantity > 5 AND TerritoryKey = 1; -- Multiple conditions

SELECT * FROM "Sales Data 2021" WHERE ProductKey NOT IN (500, 600); -- Exclusion filter

--_________________________________________________________________________________________________________________________________________________________________________

--ORDER BY (Sorting)
SELECT * FROM "Sales Data 2021" WHERE OrderQuantity IS NOT NULL ORDER BY OrderQuantity DESC; -- Sort high to low

SELECT * FROM "Sales Data 2021" ORDER BY OrderDate ASC; -- Sort oldest to newest

SELECT * FROM "Sales Data 2021" ORDER BY TerritoryKey, OrderQuantity DESC; -- Multi-column sort

SELECT * FROM "Sales Data 2021" ORDER BY OrderNumber ASC; -- Alphabetical/Numeric sort

SELECT * FROM "Sales Data 2021" ORDER BY ProductKey DESC; -- Sort keys high to low

SELECT * FROM "Sales Data 2021" ORDER BY RANDOM(); -- Randomize rows

SELECT * FROM "Sales Data 2021" ORDER BY abs(OrderQuantity); -- Sort by absolute values

SELECT * FROM "Sales Data 2021" ORDER BY OrderDate DESC, OrderQuantity ASC; -- Complex sort

SELECT * FROM "Sales Data 2021" ORDER BY ProductKey LIMIT 10; -- Sort and take top 10

SELECT * FROM "Sales Data 2021" ORDER BY OrderNumber DESC; -- Reverse sort

--_________________________________________________________________________________________________________________________________________________________________________

-- LIMIT (Pagination)
SELECT * FROM "Sales Data 2021" LIMIT 5; -- Take first 5

SELECT * FROM "Sales Data 2021" LIMIT 10 OFFSET 5; -- Skip 5, take next 10

SELECT * FROM "Sales Data 2021" ORDER BY OrderQuantity DESC LIMIT 1; -- Highest quantity

SELECT DISTINCT ProductKey FROM "Sales Data 2021" LIMIT 3; -- Top 3 unique products

SELECT * FROM "Sales Data 2021" WHERE TerritoryKey = 1 LIMIT 5; -- Filter then limit

SELECT * FROM "Sales Data 2021" LIMIT 1; -- Get top row

SELECT * FROM "Sales Data 2021" ORDER BY OrderDate ASC LIMIT 10; -- First 10 chronological

SELECT * FROM "Sales Data 2021" LIMIT 50; -- Limit results

SELECT * FROM "Sales Data 2021" ORDER BY OrderNumber LIMIT 5; -- Sorted limit

SELECT * FROM "Sales Data 2021" LIMIT 1 OFFSET 10; -- Fetch 11th record
--_________________________________________________________________________________________________________________________________________________________________________

-- GROUP BY (Aggregation)
SELECT TerritoryKey, SUM(OrderQuantity) FROM "Sales Data 2021" GROUP BY TerritoryKey; -- Total per territory

SELECT ProductKey, COUNT(*) FROM "Sales Data 2021" GROUP BY ProductKey; -- Orders per product

SELECT TerritoryKey, AVG(OrderQuantity) FROM "Sales Data 2021" GROUP BY TerritoryKey; -- Average per territory

SELECT OrderDate, SUM(OrderQuantity) FROM "Sales Data 2021" GROUP BY OrderDate; -- Daily totals

SELECT ProductKey, MAX(OrderQuantity) FROM "Sales Data 2021" GROUP BY ProductKey; -- Max per product

SELECT TerritoryKey, MIN(OrderQuantity) FROM "Sales Data 2021" GROUP BY TerritoryKey; -- Min per territory

SELECT TerritoryKey, ProductKey, COUNT(*) FROM "Sales Data 2021" GROUP BY TerritoryKey, ProductKey; -- Multi-group

SELECT COUNT(DISTINCT ProductKey) FROM "Sales Data 2021" GROUP BY TerritoryKey; -- Unique products per group

SELECT ProductKey, SUM(OrderQuantity) FROM "Sales Data 2021" GROUP BY ProductKey ORDER BY 2 DESC; -- Sorted groups

SELECT strftime('%m', OrderDate), SUM(OrderQuantity) FROM "Sales Data 2021" GROUP BY 1; -- Monthly group
--_________________________________________________________________________________________________________________________________________________________________________

-- HAVING (Filtering Groups)
SELECT TerritoryKey, SUM(OrderQuantity) FROM "Sales Data 2021" GROUP BY TerritoryKey HAVING SUM(OrderQuantity) > 500; -- Territories with high volume

SELECT ProductKey, COUNT(*) FROM "Sales Data 2021" GROUP BY ProductKey HAVING COUNT(*) > 2; -- Popular products

SELECT TerritoryKey, AVG(OrderQuantity) FROM "Sales Data 2021" GROUP BY TerritoryKey HAVING AVG(OrderQuantity) > 2; -- High avg quantity

SELECT ProductKey, MAX(OrderQuantity) FROM "Sales Data 2021" GROUP BY ProductKey HAVING MAX(OrderQuantity) = 1; -- Only units sold

SELECT TerritoryKey, COUNT(*) FROM "Sales Data 2021" GROUP BY TerritoryKey HAVING COUNT(*) < 5; -- Low activity groups

SELECT ProductKey, SUM(OrderQuantity) FROM "Sales Data 2021" GROUP BY ProductKey HAVING SUM(OrderQuantity) > 100; -- High volume products

SELECT OrderDate, COUNT(*) FROM "Sales Data 2021" GROUP BY OrderDate HAVING COUNT(*) > 1; -- Busy days

SELECT TerritoryKey, SUM(OrderQuantity) FROM "Sales Data 2021" GROUP BY TerritoryKey HAVING TerritoryKey IN (1, 2); -- Specific groups

SELECT ProductKey, AVG(OrderQuantity) FROM "Sales Data 2021" GROUP BY ProductKey HAVING AVG(OrderQuantity) BETWEEN 1 AND 3; -- Range avg

SELECT TerritoryKey, COUNT(*) FROM "Sales Data 2021" GROUP BY TerritoryKey HAVING COUNT(*) > 10 ORDER BY 2 DESC; -- Top groups
--_________________________________________________________________________________________________________________________________________________________________________

-- JOIN

-- inner join
SELECT 
    t21.productkey, 
    t21.Total_Qty_2021, 
    t22.Total_Qty_2022
FROM (
    SELECT productkey, SUM(orderquantity) AS Total_Qty_2021
    FROM "Sales Data 2021"
    GROUP BY productkey
) AS t21
INNER JOIN (
    SELECT productkey, SUM(orderquantity) AS Total_Qty_2022
    FROM "Sales Data 2022"
    GROUP BY productkey
) AS t22 
ON t21.productkey = t22.productkey;

--right join

SELECT 
    t22.productkey, 
    t21.Total_Qty_2021, 
    t22.Total_Qty_2022
FROM (
    SELECT productkey, SUM(orderquantity) AS Total_Qty_2022
    FROM "Sales Data 2022"
    GROUP BY productkey
) AS t22
LEFT JOIN (
    SELECT productkey, SUM(orderquantity) AS Total_Qty_2021
    FROM "Sales Data 2021"
    GROUP BY productkey
) AS t21 
ON t22.productkey = t21.productkey;


--left join

SELECT 
    t21.productkey, 
    t21.Total_Qty_2021, 
    t22.Total_Qty_2022
FROM (
    SELECT productkey, SUM(orderquantity) AS Total_Qty_2021
    FROM "Sales Data 2021"
    GROUP BY productkey
) AS t21
LEFT JOIN (
    SELECT productkey, SUM(orderquantity) AS Total_Qty_2022
    FROM "Sales Data 2022"
    GROUP BY productkey
) AS t22 
ON t21.productkey = t22.productkey;



-- full outer join

-- Step 1: Get all 2021 products and match them with 2022 data
SELECT 
    t21.productkey, 
    t21.Total_Qty_2021, 
    t22.Total_Qty_2022
FROM (
    SELECT productkey, SUM(orderquantity) AS Total_Qty_2021
    FROM "Sales Data 2021"
    GROUP BY productkey
) AS t21
LEFT JOIN (
    SELECT productkey, SUM(orderquantity) AS Total_Qty_2022
    FROM "Sales Data 2022"
    GROUP BY productkey
) AS t22 
ON t21.productkey = t22.productkey

UNION

-- Step 2: Get all 2022 products and match them with 2021 data
SELECT 
    t22.productkey, 
    t21.Total_Qty_2021, 
    t22.Total_Qty_2022
FROM (
    SELECT productkey, SUM(orderquantity) AS Total_Qty_2022
    FROM "Sales Data 2022"
    GROUP BY productkey
) AS t22
LEFT JOIN (
    SELECT productkey, SUM(orderquantity) AS Total_Qty_2021
    FROM "Sales Data 2021"
    GROUP BY productkey
) AS t21 
ON t22.productkey = t21.productkey;
