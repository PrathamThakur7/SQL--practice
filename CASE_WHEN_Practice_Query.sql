/*
========================================================
PROJECT: CASE WHEN Practice
DATABASE: SalesDB
AUTHOR: Pratham Thakur

DESCRIPTION:
This file demonstrates practical uses of the CASE WHEN
expression in SQL.

CONCEPTS COVERED:
- Categorization
- Value Mapping
- Data Cleaning
- Conditional Aggregation
- Window Functions
- Business Reporting

USE CASES:
1. Sales Categorization
2. Gender Mapping
3. Country Code Mapping
4. NULL Value Handling
5. Conditional Counting
========================================================
*/


--------------------------------------------------------
-- Sales Categorization Report
--
-- High   : Sales > 50
-- Medium : Sales > 20 and <= 50
-- Low    : Sales <= 20
--------------------------------------------------------

SELECT
    Category,
    SUM(Sales) AS TotalSales

FROM
(
    SELECT
        OrderID,
        Sales,

        CASE
            WHEN Sales > 50 THEN 'High'
            WHEN Sales > 20 THEN 'Medium'
            ELSE 'Low'
        END AS Category

    FROM Sales.Orders
) t

GROUP BY Category

ORDER BY TotalSales DESC;


--------------------------------------------------------
-- Value Mapping
-- Display Gender As Full Text
--------------------------------------------------------

SELECT
    EmployeeID,
    FirstName,
    LastName,
    Gender,

    CASE
        WHEN Gender = 'M' THEN 'Male'
        WHEN Gender = 'F' THEN 'Female'
        ELSE 'Not Available'
    END AS GenderFullText

FROM Sales.Employees;


--------------------------------------------------------
-- Country Code Mapping
--------------------------------------------------------

SELECT
    CustomerID,
    FirstName,
    LastName,
    Country,

    CASE
        WHEN Country = 'Germany' THEN 'DE'
        WHEN Country = 'USA' THEN 'US'
        ELSE 'N/A'
    END AS CountryCode

FROM Sales.Customers;


--------------------------------------------------------
-- Distinct Countries
--------------------------------------------------------

SELECT DISTINCT Country
FROM Sales.Customers;


--------------------------------------------------------
-- Alternative CASE Syntax
-- Useful When Comparing One Column
--------------------------------------------------------

SELECT
    CustomerID,
    FirstName,
    LastName,
    Country,

    CASE
        WHEN Country = 'Germany' THEN 'DE'
        WHEN Country = 'USA' THEN 'US'
        ELSE 'N/A'
    END AS Abbreviation1,

    CASE Country
        WHEN 'Germany' THEN 'DE'
        WHEN 'USA' THEN 'US'
        ELSE 'N/A'
    END AS Abbreviation2

FROM Sales.Customers;


--------------------------------------------------------
-- Data Cleaning
-- Treat NULL Scores As Zero
--------------------------------------------------------

SELECT
    CustomerID,
    LastName,
    Score,

    CASE
        WHEN Score IS NULL THEN 0
        ELSE Score
    END AS ScoreClean,

    AVG(
        CASE
            WHEN Score IS NULL THEN 0
            ELSE Score
        END
    ) OVER () AS AvgCustomerClean,

    AVG(Score) OVER () AS AvgCustomer

FROM Sales.Customers;


--------------------------------------------------------
-- Conditional Aggregation
--
-- Count Orders With Sales > 30
--------------------------------------------------------

SELECT
    CustomerID,

    SUM(
        CASE
            WHEN Sales > 30 THEN 1
            ELSE 0
        END
    ) AS TotalOrdersHighSales,

    COUNT(*) AS TotalOrders

FROM Sales.Orders

GROUP BY CustomerID;