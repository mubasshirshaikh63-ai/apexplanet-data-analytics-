-- Using a CTE to calculate the global average price
WITH GlobalAvg AS (
    SELECT AVG(Price) as Overall_Avg FROM ecom_srecords
)
-- Subquery inside the WHERE clause to filter products above global average
SELECT Product, Price 
FROM ecom_srecords
WHERE Price > (SELECT Overall_Avg FROM GlobalAvg);


-- Calculating rankings and trends using Window Functions
SELECT 
    Category,
    Product,
    Price,
    ROW_NUMBER() OVER(PARTITION BY Category ORDER BY Price DESC) as Row_ID,
    RANK() OVER(PARTITION BY Category ORDER BY Price DESC) as Price_Rank,
    LAG(Price) OVER(ORDER BY Date) as Prev_Price,
    LEAD(Price) OVER(ORDER BY Date) as Next_Price
	FROM ecom_srecords;


-- Creating a reusable View for categorized product analysis
CREATE VIEW CategoryPerformance AS
SELECT 
    Category,
    COUNT(Product) as Product_Count,
    SUM(Price * Quantity) as Total_Revenue,
    RANK() OVER(ORDER BY SUM(Price * Quantity) DESC) as Revenue_Rank
FROM ecom_srecords
GROUP BY Category;

-- You can now access this analysis with one simple line
SELECT * FROM CategoryPerformance;

