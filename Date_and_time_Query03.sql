/*
========================================================
PROJECT: Date & Time Functions Practice - Part 3
TOPIC: Calculations and Validation
DATABASE: SalesDB
AUTHOR: Pratham Thakur

DESCRIPTION:
This file demonstrates advanced date and time operations:

1. Date Calculations using DATEADD()
2. Date Difference Analysis using DATEDIFF()
3. Shipping Duration Analysis
4. Time Gap Analysis using LAG()
5. Date Validation using ISDATE()
6. Data Cleaning using CASE WHEN

CONCEPTS COVERED:
- DATEADD
- DATEDIFF
- LAG
- ISDATE
- CASE WHEN
- Window Functions
- Data Validation
========================================================
*/


--------------------------------------------------------
-- DATEADD()
-- Add/Subtract Time Intervals
--------------------------------------------------------

SELECT
    OrderID,
    OrderDate,

    DATEADD(DAY, -10, OrderDate) AS TenDaysBefore,
    DATEADD(MONTH, -3, OrderDate) AS ThreeMonthsBefore,
    DATEADD(YEAR, -2, OrderDate) AS TwoYearsBefore

FROM Sales.Orders;


--------------------------------------------------------
-- DATEDIFF()
-- Calculate Employee Age
--------------------------------------------------------

SELECT
    EmployeeID,
    BirthDate,

    DATEDIFF(YEAR, BirthDate, GETDATE()) AS Age

FROM Sales.Employees;


--------------------------------------------------------
-- Shipping Duration Analysis
-- Average Days Required To Ship Orders
--------------------------------------------------------

SELECT
    MONTH(OrderDate) AS OrderMonth,

    AVG(
        DATEDIFF(DAY, OrderDate, ShipDate)
    ) AS AvgDaysToShip

FROM Sales.Orders

GROUP BY MONTH(OrderDate);


--------------------------------------------------------
-- Time Gap Analysis
-- Days Between Consecutive Orders
--------------------------------------------------------

SELECT
    OrderID,

    OrderDate AS CurrentOrderDate,

    LAG(OrderDate)
        OVER (ORDER BY OrderDate)
        AS PreviousOrderDate,

    DATEDIFF(
        DAY,
        LAG(OrderDate) OVER (ORDER BY OrderDate),
        OrderDate
    ) AS DaysBetweenOrders

FROM Sales.Orders;


--------------------------------------------------------
-- ISDATE()
-- Date Validation Examples
--------------------------------------------------------

SELECT
    ISDATE('123') AS DateCheck1,
    ISDATE('2025-08-20') AS DateCheck2,
    ISDATE('20-08-2025') AS DateCheck3,
    ISDATE('2025') AS DateCheck4,
    ISDATE('08') AS DateCheck5;


--------------------------------------------------------
-- CASE WHEN + ISDATE()
-- Handle Invalid Date Values
--------------------------------------------------------

SELECT
    OrderDate,

    ISDATE(OrderDate) AS IsValidDate,

    CASE
        WHEN ISDATE(OrderDate) = 1
            THEN CAST(OrderDate AS DATE)

        ELSE '9999-01-01'
    END AS CleanedOrderDate

FROM
(
    SELECT '2025-08-20' AS OrderDate
    UNION
    SELECT '2025-08-21'
    UNION
    SELECT '2025-08-23'
    UNION
    SELECT '2025-08'
) t;