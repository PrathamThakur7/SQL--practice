/*==============================================================
                    SQL SUBQUERIES
        Non-Correlated & Correlated Subqueries
==============================================================*/


/*==============================================================
1. List All Tables
Display all unique table names
from the current database.
==============================================================*/

SELECT DISTINCT
    table_name
FROM information_schema.columns;



/*==============================================================
2. Subquery in FROM Clause
Find products whose price is higher
than the average price of all products.
==============================================================*/

SELECT *
FROM
(
    SELECT
        productid,
        price,
        AVG(price) OVER () AS AveragePrice
    FROM sales.products
) t
WHERE price > AveragePrice;



/*==============================================================
3. Rank Customers by Total Sales
==============================================================*/

SELECT
    *,
    RANK() OVER
    (
        ORDER BY TotalSales DESC
    ) AS CustomerRank
FROM
(
    SELECT
        customerid,
        SUM(sales) AS TotalSales
    FROM sales.orders
    GROUP BY customerid
) t;



/*==============================================================
4. Subquery in SELECT Clause
Display:
- Product ID
- Product Name
- Price
- Total number of orders
==============================================================*/

SELECT
    productid,
    product,
    price,

    (
        SELECT COUNT(orderid)
        FROM sales.orders
    ) AS TotalOrders

FROM sales.products;



/*==============================================================
5. Subquery in JOIN
Show all customers and
their total number of orders.
==============================================================*/

SELECT
    *
FROM sales.customers c

LEFT JOIN
(
    SELECT
        customerid,
        COUNT(*) AS TotalOrders
    FROM sales.orders
    GROUP BY customerid
) o

ON c.customerid = o.customerid;



/*==============================================================
6. Subquery in WHERE Clause
Find products whose price is
higher than the average price.
==============================================================*/

SELECT
    productid,
    price
FROM sales.products

WHERE price >
(
    SELECT AVG(price)
    FROM sales.products
);



/*==============================================================
7. Subquery using IN
Show all orders placed by
customers from Germany.
==============================================================*/

SELECT *
FROM sales.orders

WHERE customerid IN
(
    SELECT customerid
    FROM sales.customers
    WHERE country = 'Germany'
);



/*==============================================================
8. Subquery using NOT IN
Show all orders placed by
customers outside Germany.
==============================================================*/

SELECT *
FROM sales.orders

WHERE customerid NOT IN
(
    SELECT customerid
    FROM sales.customers
    WHERE country = 'Germany'
);



/*==============================================================
9. ANY Operator
Find female employees whose salary
is greater than ANY male employee.
==============================================================*/

SELECT
    employeeid,
    firstname,
    gender,
    salary

FROM sales.employees

WHERE gender = 'F'

AND salary > ANY
(
    SELECT salary
    FROM sales.employees
    WHERE gender = 'M'
);



/*==============================================================
10. ALL Operator
Find female employees whose salary
is greater than ALL male employees.
==============================================================*/

SELECT
    employeeid,
    firstname,
    gender,
    salary

FROM sales.employees

WHERE gender = 'F'

AND salary > ALL
(
    SELECT salary
    FROM sales.employees
    WHERE gender = 'M'
);



/*==============================================================
11. Correlated Subquery
Display all customers along with
their total number of orders.
==============================================================*/

SELECT
    *,

    (
        SELECT COUNT(*)
        FROM sales.orders o
        WHERE o.customerid = c.customerid
    ) AS TotalOrders

FROM sales.customers c;



/*==============================================================
12. EXISTS Operator
Display all orders placed by
customers from Germany.
==============================================================*/

SELECT *
FROM sales.orders o

WHERE EXISTS
(
    SELECT 1
    FROM sales.customers c

    WHERE country = 'Germany'
    AND o.customerid = c.customerid
);