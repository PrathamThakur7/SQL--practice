/*==============================================================
            WINDOW ANALYTICAL FUNCTIONS
        LEAD(), LAG(), FIRST_VALUE(), LAST_VALUE()
==============================================================*/


/*==============================================================
1. Month-over-Month (MoM) Sales Analysis
Calculate:
- Previous month's sales
- Month-over-month sales change
- Month-over-month percentage change
==============================================================*/

SELECT
    *,
    CurrentMonthSales - PreviousMonthSales AS MoM_Change,
    ROUND(
        CAST(CurrentMonthSales - PreviousMonthSales AS NUMERIC)
        / PreviousMonthSales * 100,
        1
    ) AS MoM_Percentage
FROM
(
    SELECT
        EXTRACT(MONTH FROM orderdate) AS OrderMonth,
        SUM(sales) AS CurrentMonthSales,
        LAG(SUM(sales))
            OVER (ORDER BY EXTRACT(MONTH FROM orderdate))
            AS PreviousMonthSales
    FROM sales.orders
    GROUP BY EXTRACT(MONTH FROM orderdate)
) t;



/*==============================================================
2. Customer Loyalty Analysis
Rank customers based on the average number
of days between their consecutive orders.
==============================================================*/

SELECT
    customerid,
    AVG(DaysUntilNextOrder) AS AverageDaysBetweenOrders,
    RANK() OVER
    (
        ORDER BY AVG(DaysUntilNextOrder)
    ) AS CustomerRank
FROM
(
    SELECT
        orderid,
        customerid,
        orderdate AS CurrentOrderDate,

        LEAD(orderdate)
            OVER
            (
                PARTITION BY customerid
                ORDER BY orderdate
            ) AS NextOrderDate,

        LEAD(orderdate)
            OVER
            (
                PARTITION BY customerid
                ORDER BY orderdate
            ) - orderdate AS DaysUntilNextOrder

    FROM sales.orders
) t
GROUP BY customerid;



/*==============================================================
3. Average Shipping Duration
Calculate the average shipping duration
for each month.
==============================================================*/

SELECT
    EXTRACT(MONTH FROM orderdate) AS OrderMonth,
    AVG(shipdate - orderdate) AS AverageShippingDays
FROM sales.orders
GROUP BY EXTRACT(MONTH FROM orderdate);



/*==============================================================
4. Time Gap Analysis
Find the number of days between
each order and the previous order.
==============================================================*/

SELECT
    orderid,
    orderdate AS CurrentOrderDate,

    LAG(orderdate)
        OVER (ORDER BY orderdate)
        AS PreviousOrderDate,

    orderdate -
    LAG(orderdate)
        OVER (ORDER BY orderdate)
        AS DaysBetweenOrders

FROM sales.orders;



/*==============================================================
5. FIRST_VALUE() & LAST_VALUE()
Find the lowest and highest sales
for each product using different methods.
==============================================================*/

SELECT
    orderid,
    productid,
    sales,

    FIRST_VALUE(sales)
        OVER
        (
            PARTITION BY productid
            ORDER BY sales
        ) AS LowestSales_FirstValue,

    LAST_VALUE(sales)
        OVER
        (
            PARTITION BY productid
            ORDER BY sales
            ROWS BETWEEN CURRENT ROW
                     AND UNBOUNDED FOLLOWING
        ) AS HighestSales_LastValue,

    MIN(sales)
        OVER (PARTITION BY productid)
        AS LowestSales_Min,

    MAX(sales)
        OVER (PARTITION BY productid)
        AS HighestSales_Max,

    FIRST_VALUE(sales)
        OVER
        (
            PARTITION BY productid
            ORDER BY sales DESC
        ) AS HighestSales_FirstValue

FROM sales.orders;