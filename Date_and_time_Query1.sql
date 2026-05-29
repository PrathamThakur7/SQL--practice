-- =====================================================
-- Date and Time Functions Practice
-- Database: Sales
-- Table: OrdersArchive
-- =====================================================

SELECT
    CustomerID,
    CreationTime,

    -- DATETRUNC Examples
    DATETRUNC(YEAR, CreationTime)    AS Year_Trunc,
    DATETRUNC(MONTH, CreationTime)   AS Month_Trunc,
    DATETRUNC(WEEK, CreationTime)    AS Week_Trunc,
    DATETRUNC(QUARTER, CreationTime) AS Quarter_Trunc,

    -- DATENAME Examples
    DATENAME(YEAR, CreationTime)     AS Year_Name,
    DATENAME(MONTH, CreationTime)    AS Month_Name,
    DATENAME(WEEK, CreationTime)     AS Week_Name,
    DATENAME(QUARTER, CreationTime)  AS Quarter_Name,

    -- DATEPART Examples
    DATEPART(YEAR, CreationTime)     AS Year_Part,
    DATEPART(MONTH, CreationTime)    AS Month_Part,
    DATEPART(WEEK, CreationTime)     AS Week_Part,
    DATEPART(QUARTER, CreationTime)  AS Quarter_Part,

    -- Individual Functions
    YEAR(CreationTime)  AS Year_Value,
    MONTH(CreationTime) AS Month_Value,
    DAY(CreationTime)   AS Day_Value

FROM Sales.OrdersArchive;


-- =====================================================
-- Orders Created Per Month
-- =====================================================

SELECT
    DATETRUNC(MONTH, CreationTime) AS Creation_Month,
    COUNT(*) AS Total_Orders
FROM Sales.OrdersArchive
GROUP BY DATETRUNC(MONTH, CreationTime)
ORDER BY Creation_Month;