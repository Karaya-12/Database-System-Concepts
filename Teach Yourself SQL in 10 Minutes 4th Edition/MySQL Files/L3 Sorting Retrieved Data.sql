-- Sorting Data
SELECT prod_name
FROM Products
ORDER BY prod_name

-- Sorting by Multiple Columns
SELECT prod_id, prod_price, prod_name
FROM Products
ORDER BY prod_price, prod_name  -- Sorted First by Price, Then by Name
-- The Products Are Sorted by the 'prod_name' Column Only When Multiple Rows Have The Same 'prod_price' Value

-- Sorting by Relative Column Position
SELECT prod_id, prod_price, prod_name
FROM Products
ORDER BY 2, 3

-- Specifying Sort Direction
SELECT prod_id, prod_price, prod_name
FROM Products
ORDER BY prod_price DESC

SELECT prod_id, prod_price, prod_name
FROM Products
ORDER BY prod_price DESC, prod_name