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
SELECT TOP 5 prod_name
FROM Products
