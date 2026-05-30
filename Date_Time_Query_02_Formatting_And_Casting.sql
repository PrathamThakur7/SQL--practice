/*
========================================================
PROJECT: Date & Time Functions Practice - Part 2
TOPIC: Formatting and Data Type Conversion
DATABASE: SalesDB
AUTHOR: Pratham Thakur

DESCRIPTION:
This file demonstrates:

1. Date Formatting using FORMAT()
2. Custom Date Display Formats
3. Monthly Data Aggregation
4. Data Standardization
5. Data Type Conversion using:
   - CAST()
   - CONVERT()

CONCEPTS COVERED:
- FORMAT
- CAST
- CONVERT
- GROUP BY
- COUNT
- Date Presentation
- Data Transformation
========================================================
*/


--------------------------------------------------------
-- FORMAT()
-- Display dates in different formats
--------------------------------------------------------

SELECT
    OrderID,
    CreationTime,

    FORMAT(CreationTime, 'MM-dd-yyyy') AS USA_Format,
    FORMAT(CreationTime, 'dd-MM-yyyy') AS EURO_Format,

    FORMAT(CreationTime, 'dd') AS Day_Number,
    FORMAT(CreationTime, 'ddd') AS Day_Short,
    FORMAT(CreationTime, 'dddd') AS Day_Full,

    FORMAT(CreationTime, 'MM') AS Month_Number,
    FORMAT(CreationTime, 'MMM') AS Month_Short,
    FORMAT(CreationTime, 'MMMM') AS Month_Full,

    FORMAT(CreationTime, 'yy') AS Year_2_Digit,
    FORMAT(CreationTime, 'yyyy') AS Year_4_Digit

FROM Sales.Orders;


--------------------------------------------------------
-- Custom Date Format
-- Example:
-- Day Wed Jan Q1 2025 12:34:56 PM
--------------------------------------------------------

SELECT
    OrderID,
    CreationTime,

    'Day ' +
    FORMAT(CreationTime, 'ddd MMM') +
    ' Q' +
    DATENAME(QUARTER, CreationTime) +
    ' ' +
    FORMAT(CreationTime, 'yyyy hh:mm:ss tt')
    AS CustomFormat

FROM Sales.Orders;


--------------------------------------------------------
-- Data Aggregation
-- Total Orders Per Month
--------------------------------------------------------

SELECT
    FORMAT(OrderDate, 'MMM yy') AS OrderMonth,
    COUNT(*) AS TotalOrders

FROM Sales.Orders

GROUP BY FORMAT(OrderDate, 'MMM yy');


--------------------------------------------------------
-- CONVERT()
-- Data Standardization Examples
--------------------------------------------------------

SELECT

    CONVERT(INT, '123')
    AS [String to Int],

    CONVERT(DATE, '2025-08-20')
    AS [String to Date],

    CreationTime,

    CONVERT(DATE, CreationTime)
    AS [Datetime to Date],

    CONVERT(VARCHAR, CreationTime, 32)
    AS [USA Standard Style],

    CONVERT(VARCHAR, CreationTime, 34)
    AS [Europe Standard Style]

FROM Sales.Orders;


--------------------------------------------------------
-- CAST()
-- Data Type Conversion Examples
--------------------------------------------------------

SELECT

    CAST('123' AS INT)
    AS [String to Int],

    CAST(123 AS VARCHAR)
    AS [Int to String],

    CAST('2025-08-20' AS DATE)
    AS [String to Date],

    CAST('2025-08-20' AS DATETIME2)
    AS [String to Datetime],

    CreationTime,

    CAST(CreationTime AS DATE)
    AS [Datetime to Date]

FROM Sales.Orders;