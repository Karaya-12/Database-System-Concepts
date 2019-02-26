-- Retrieving Individual Columns
SELECT prod_name
FROM Products

-- Retrieving Multiple Columns
SELECT prod_id, prod_name, prod_price
FROM Products

-- Retrieving All Columns
SELECT *
FROM Products

-- Retrieving Distinct Rows
SELECT DISTINCT vend_id
FROM Products

-- Limiting Results
SELECT prod_name
FROM Products
LIMIT 5  -- LIMIT 0, 5

SELECT prod_name
FROM Products
LIMIT 5 OFFSET 5  -- LIMIT 4 OFFSET 5

SELECT prod_name
FROM Products
LIMIT 3, 4  -- Return 4 Rows Starting From Row 3
-- LIMIT offset, rows

SELECT prod_name
FROM Products
LIMIT 2, 100000  -- Return All Rows Below Row 2
