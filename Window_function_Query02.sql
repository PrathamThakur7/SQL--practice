/*==============================================================
                WINDOW AGGREGATE FUNCTIONS
                SUM(), AVG(), MIN(), MAX()
                Moving & Rolling Average
==============================================================*/


/*==============================================================
1. WINDOW SUM()
Find:
- Total sales across all orders
- Total sales for each product
- Display OrderID, OrderDate and Sales
==============================================================*/

SELECT
    orderid,
    orderdate,
    sales,
    SUM(sales) OVER () AS TotalSales,
    SUM(sales) OVER (PARTITION BY productid) AS TotalSalesByProduct
FROM sales.orders;



/*==============================================================
2. Percentage Contribution of Each Order
Find the percentage contribution of each order's sales
to the total sales.
==============================================================*/

SELECT
    orderid,
    productid,
    sales,
    SUM(sales) OVER () AS TotalSales,
    ROUND(
        CAST(sales AS FLOAT) /
        SUM(sales) OVER () * 100,
        2
    ) AS PercentageOfTotal
FROM sales.orders;



/*==============================================================
3. WINDOW AVG()
Find:
- Average sales across all orders
- Average sales for each product
==============================================================*/

SELECT
    orderid,
    orderdate,
    sales,
    AVG(sales) OVER () AS AverageSales,
    AVG(sales) OVER (PARTITION BY productid) AS AverageSalesByProduct
FROM sales.orders;



/*==============================================================
4. Average Customer Score
Display:
- CustomerID
- LastName
- Original Score
- Score with NULL replaced by 0
- Average score
==============================================================*/

SELECT
    customerid,
    lastname,
    score,
    COALESCE(score, 0) AS CustomerScore,
    AVG(score) OVER () AS AverageScore,
    AVG(COALESCE(score, 0)) OVER () AS AverageScoreWithoutNulls
FROM sales.customers;



/*==============================================================
5. Orders Above Average Sales
==============================================================*/

SELECT *
FROM
(
    SELECT
        orderid,
        productid,
        sales,
        AVG(sales) OVER () AS AverageSales
    FROM sales.orders
) t
WHERE sales > AverageSales;



/*==============================================================
6. WINDOW MIN() & MAX()
Find:
- Highest and Lowest sales overall
- Highest and Lowest sales for each product
==============================================================*/

SELECT
    orderid,
    orderdate,
    sales,
    MIN(sales) OVER () AS LowestSales,
    MAX(sales) OVER () AS HighestSales,
    MIN(sales) OVER (PARTITION BY productid) AS LowestSalesByProduct,
    MAX(sales) OVER (PARTITION BY productid) AS HighestSalesByProduct
FROM sales.orders;



/*==============================================================
7. Employees With Highest Salary
==============================================================*/

SELECT *
FROM
(
    SELECT
        *,
        MAX(salary) OVER () AS HighestSalary
    FROM sales.employees
) t
WHERE salary = HighestSalary;



/*==============================================================
8. Moving Average
Calculate the moving average of sales
for each product over time.
==============================================================*/

SELECT
    orderid,
    productid,
    orderdate,
    sales,
    AVG(sales) OVER
    (
        PARTITION BY productid
    ) AS AverageByProduct,

    AVG(sales) OVER
    (
        PARTITION BY productid
        ORDER BY orderdate
    ) AS MovingAverage

FROM sales.orders;



/*==============================================================
9. Rolling Average
Calculate the moving average including
only the current row and the next order.
==============================================================*/

SELECT
    orderid,
    productid,
    orderdate,
    sales,

    AVG(sales) OVER
    (
        PARTITION BY productid
    ) AS AverageByProduct,

    AVG(sales) OVER
    (
        PARTITION BY productid
        ORDER BY orderdate
    ) AS MovingAverage,

    AVG(sales) OVER
    (
        PARTITION BY productid
        ORDER BY orderdate
        ROWS BETWEEN CURRENT ROW AND 1 FOLLOWING
    ) AS RollingAverage

FROM sales.orders;