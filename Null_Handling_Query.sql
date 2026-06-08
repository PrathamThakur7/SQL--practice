/*
========================================================
PROJECT: NULL Handling Practice
DATABASE: SalesDB
AUTHOR: Pratham Thakur

DESCRIPTION:
This file demonstrates techniques for handling NULL values
in SQL.

CONCEPTS COVERED:
- IS NULL
- IS NOT NULL
- ISNULL()
- COALESCE()
- NULLIF()
- Anti Joins
- Data Cleaning
- NULL vs Empty String
- Data Standardization
========================================================
*/


--------------------------------------------------------
-- ISNULL()
-- Replace NULL values with a default value
--------------------------------------------------------

SELECT
    CustomerID,
    FirstName,
    Score,
    ISNULL(Score, 0) AS CustomerScore
FROM Sales.Customers;


--------------------------------------------------------
-- COALESCE()
-- Return the first non-NULL value
--------------------------------------------------------

SELECT
    CustomerID,
    FirstName,

    COALESCE(
        CAST(Score AS VARCHAR),
        'Score Not Available'
    ) AS CustomerScore

FROM Sales.Customers;


--------------------------------------------------------
-- IS NULL
-- Identify customers with no score
--------------------------------------------------------

SELECT *
FROM Sales.Customers
WHERE Score IS NULL;


--------------------------------------------------------
-- IS NOT NULL
-- Identify customers with scores
--------------------------------------------------------

SELECT *
FROM Sales.Customers
WHERE Score IS NOT NULL;


--------------------------------------------------------
-- Anti Join Pattern
-- Customers who have not placed orders
--------------------------------------------------------

SELECT
    c.*,
    o.OrderID

FROM Sales.Customers AS c

LEFT JOIN Sales.Orders AS o
    ON c.CustomerID = o.CustomerID

WHERE o.CustomerID IS NULL;


--------------------------------------------------------
-- NULLIF()
-- Prevent division by zero
--------------------------------------------------------

SELECT
    OrderID,
    Sales,
    Quantity,

    Sales / NULLIF(Quantity, 0)
    AS SalesPrice

FROM Sales.Orders;


--------------------------------------------------------
-- NULL vs Empty String vs Blank Space
--------------------------------------------------------

WITH Orders AS
(
    SELECT 1 AS ID, 'A' AS Category
    UNION
    SELECT 2, NULL
    UNION
    SELECT 3, ''
    UNION
    SELECT 4, ' '
)

SELECT
    *,
    DATALENGTH(Category) AS CategoryLength

FROM Orders;


--------------------------------------------------------
-- Data Cleaning Policy
--------------------------------------------------------

WITH Orders AS
(
    SELECT 1 AS ID, 'A' AS Category
    UNION
    SELECT 2, NULL
    UNION
    SELECT 3, ''
    UNION
    SELECT 4, ' '
)

SELECT
    *,

    TRIM(Category)
    AS Policy1,

    NULLIF(TRIM(Category), '')
    AS Policy2,

    COALESCE(
        NULLIF(TRIM(Category), ''),
        'Unknown'
    ) AS Policy3

FROM Orders;