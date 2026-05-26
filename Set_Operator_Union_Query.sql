/*
========================================================
PROJECT: SQL Set Operator Practice
TOPIC: UNION Operator
DATABASE: SalesDB
AUTHOR: Pratham Thakur

DESCRIPTION:
Orders are stored in two separate tables:
1. Orders
2. OrdersArchive

This query combines both tables into a single
report using the UNION operator while removing
duplicate records.

FEATURES:
- UNION Operator
- Table Source Labeling
- Sorting Results
- Multi-table Data Combination
- Report Generation

NOTE:
UNION automatically removes duplicate rows.
========================================================
*/

-- Current Orders Table
SELECT
    'Orders' AS SourceTable,
    OrderID,
    ProductID,
    CustomerID,
    SalesPersonID,
    OrderDate,
    ShipDate,
    OrderStatus,
    ShipAddress,
    BillAddress,
    Quantity,
    Sales,
    CreationTime

FROM Sales.Orders

UNION

-- Archived Orders Table
SELECT
    'OrdersArchive' AS SourceTable,
    OrderID,
    ProductID,
    CustomerID,
    SalesPersonID,
    OrderDate,
    ShipDate,
    OrderStatus,
    ShipAddress,
    BillAddress,
    Quantity,
    Sales,
    CreationTime

FROM Sales.OrdersArchive

-- Sorting Final Combined Report
ORDER BY OrderID;