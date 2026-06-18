-- =====================================================
-- WINDOW FUNCTIONS IN SQL
-- =====================================================

-- =====================================================
-- 1. GROUP BY vs WINDOW FUNCTION
-- =====================================================

-- Aggregate Function
-- Find the total sales across all orders

SELECT
    SUM(sales) AS total_sales
FROM sales.orders;

-- GROUP BY
-- Find the total sales for each product

SELECT
    productid,
    SUM(sales) AS total_sales
FROM sales.orders
GROUP BY productid;

-- WINDOW FUNCTION
-- Find the total sales for each product
-- while also displaying order details

SELECT
    orderid,
    orderdate,
    productid,
    SUM(sales) OVER (PARTITION BY productid) AS total_sales_by_product
FROM sales.orders;

-- =====================================================
-- 2. WINDOW FUNCTION WITHOUT PARTITION
-- =====================================================

-- Find the total sales across all orders
-- while displaying order details

SELECT
    orderid,
    orderdate,
    SUM(sales) OVER () AS total_sales
FROM sales.orders;

-- =====================================================
-- 3. WINDOW FUNCTION WITH PARTITION
-- =====================================================

-- Find the total sales for each product
-- while displaying order details

SELECT
    orderid,
    orderdate,
    productid,
    SUM(sales) OVER (PARTITION BY productid) AS total_sales_by_product
FROM sales.orders;

-- =====================================================
-- 4. MULTIPLE WINDOW CALCULATIONS
-- =====================================================

-- Display:
-- 1. Total sales across all orders
-- 2. Total sales by product

SELECT
    orderid,
    orderdate,
    productid,
    sales,
    SUM(sales) OVER () AS total_sales,
    SUM(sales) OVER (PARTITION BY productid) AS total_sales_by_product
FROM sales.orders;

-- =====================================================
-- 5. MULTIPLE PARTITIONS
-- =====================================================

-- Display:
-- 1. Total sales across all orders
-- 2. Total sales by product
-- 3. Total sales by product and order status

SELECT
    orderid,
    orderdate,
    productid,
    orderstatus,
    sales,
    SUM(sales) OVER () AS total_sales,
    SUM(sales) OVER (PARTITION BY productid) AS total_sales_by_product,
    SUM(sales) OVER (
        PARTITION BY productid, orderstatus
    ) AS total_sales_by_product_and_orderstatus
FROM sales.orders;

-- =====================================================
-- 6. RANK FUNCTION
-- =====================================================

-- Rank orders based on sales
-- from highest to lowest

SELECT
    orderid,
    orderdate,
    sales,
    RANK() OVER (ORDER BY sales DESC) AS rank_sales
FROM sales.orders;

-- =====================================================
-- 7. WINDOW FRAME
-- =====================================================

-- Calculate running totals using a frame
-- Current row + next 2 rows

SELECT
    orderid,
    orderdate,
    orderstatus,
    sales,
    SUM(sales) OVER (
        PARTITION BY orderstatus
        ORDER BY orderdate
        ROWS BETWEEN CURRENT ROW AND 2 FOLLOWING
    ) AS total_sales
FROM sales.orders;

-- =====================================================
-- 8. WINDOW FUNCTION WITH GROUP BY
-- =====================================================

-- Rank customers based on total sales

SELECT
    customerid,
    SUM(sales) AS total_sales,
    RANK() OVER (
        ORDER BY SUM(sales) DESC
    ) AS rank_customer
FROM sales.orders
GROUP BY customerid;