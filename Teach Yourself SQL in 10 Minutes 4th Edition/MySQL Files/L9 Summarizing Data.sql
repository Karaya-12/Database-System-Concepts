-- The AVG() Function
SELECT AVG(prod_price) AS avg_price
FROM Products
WHERE vend_id = 'DLL01'
-- NOTE: NULL Values Will Be IGNORED


-- The COUNT() Function
/* 1. COUNT(*)       --> Count The Number of Rows In a Table, INCLUDING NULL Values
 * 2. COUNT(column)  --> Count The Number of Rows That Have Values In a Specific Column, IGNORING NULL Values */
SELECT COUNT(*) AS num_cust  -- Return 5
FROM Customers

SELECT COUNT(cust_email) AS num_cust  -- Return 3
FROM Customers


-- The MAX() Function
SELECT MAX(prod_price) AS max_price
FROM Products
-- NOTE: NULL Values Will Be IGNORED, MAX() Can Also Be Used With Non-Numeric Data


-- The MIN() Function
SELECT MIN(prod_price) AS min_price
FROM Products
-- NOTE: NULL Values Will Be IGNORED, MIN() Can Also Be Used With Non-Numeric Data


-- The SUM() Function
SELECT SUM(item_price * quantity) AS total_price
FROM OrderItems
WHERE order_num = 20005
-- NOTE: NULL Values Will Ee IGNORED


-- Aggregates On Distinct Values
/* ALL/DISTINCT Argument Can Be Specified To The Aggegate Functions
 * ALL is The Default Behaviour */
SELECT AVG(DISTINCT prod_price) AS avg_price
FROM Products
WHERE vend_id = 'DLL01'
/* NOTE: NO DISTINCT With COUNT(*), Can Be Used With COUNT(Column)
 * Technincally Can Be Used With MIN() & MAX(), But is Actually No Value In Doing So */


-- Combining Aggregate Functions
SELECT COUNT(*) AS num_items,
       MIN(prod_price) AS price_min,
       MAX(prod_price) AS price_max,
       AVG(prod_price) AS price_avg
FROM Products