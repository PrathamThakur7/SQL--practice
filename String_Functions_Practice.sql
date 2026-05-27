/*
========================================================
PROJECT: SQL String Functions Practice
DATABASE: SalesDB
AUTHOR: Pratham Thakur

DESCRIPTION:
This file contains practice queries using commonly
used SQL string functions.

TOPICS COVERED:
- CONCAT
- UPPER
- LOWER
- LENGTH
- SUBSTRING
- REPLACE
- TRIM
- LEFT
- RIGHT

PURPOSE:
To practice string manipulation techniques used in
real-world SQL queries and data cleaning tasks.
========================================================
*/

--------------------------------------------------------
-- CONCAT FUNCTION
-- Combines multiple strings into one string
--------------------------------------------------------

SELECT
    CONCAT(FirstName, ' ', LastName) AS FullName
FROM Sales.Customers;


--------------------------------------------------------
-- UPPER FUNCTION
-- Converts text into uppercase
--------------------------------------------------------

SELECT
    FirstName,
    UPPER(FirstName) AS UpperCaseName
FROM Sales.Customers;


--------------------------------------------------------
-- LOWER FUNCTION
-- Converts text into lowercase
--------------------------------------------------------

SELECT
    FirstName,
    LOWER(FirstName) AS LowerCaseName
FROM Sales.Customers;


--------------------------------------------------------
-- LENGTH FUNCTION
-- Returns number of characters in a string
--------------------------------------------------------

SELECT
    FirstName,
    LENGTH(FirstName) AS NameLength
FROM Sales.Customers;


--------------------------------------------------------
-- SUBSTRING FUNCTION
-- Extracts part of a string
--------------------------------------------------------

SELECT
    FirstName,
    SUBSTRING(FirstName, 1, 3) AS FirstThreeLetters
FROM Sales.Customers;


--------------------------------------------------------
-- REPLACE FUNCTION
-- Replaces part of a string with another value
--------------------------------------------------------

SELECT
    REPLACE('Data Engineering', 'Engineering', 'Science')
    AS UpdatedText;


--------------------------------------------------------
-- TRIM FUNCTION
-- Removes extra spaces from both sides
--------------------------------------------------------

SELECT
    TRIM('    SQL Practice    ') AS TrimmedText;


--------------------------------------------------------
-- LEFT FUNCTION
-- Extracts characters from left side
--------------------------------------------------------

SELECT
    FirstName,
    LEFT(FirstName, 2) AS LeftCharacters
FROM Sales.Customers;


--------------------------------------------------------
-- RIGHT FUNCTION
-- Extracts characters from right side
--------------------------------------------------------

SELECT
    FirstName,
    RIGHT(FirstName, 2) AS RightCharacters
FROM Sales.Customers;


--------------------------------------------------------
-- PRACTICE QUERY
-- Generate formatted customer usernames
--------------------------------------------------------

SELECT
    CONCAT(
        LOWER(LEFT(FirstName, 3)),
        '_',
        LOWER(LEFT(LastName, 3))
    ) AS GeneratedUsername
FROM Sales.Customers;