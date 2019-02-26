-- Using The WHERE Clause
SELECT prod_name, prod_price
FROM Products
WHERE prod_price = 3.49

-- The WHERE Clause Operators
SELECT prod_name, prod_price
FROM Products
WHERE prod_price <= 10

SELECT vend_id, prod_name
FROM Products
WHERE vend_id <> 'DLL01'  -- Checking for Nonmatches

SELECT vend_id, prod_name
FROM Products
WHERE vend_id != 'DLL01'  -- Checking for Nonmatches
-- != and <> Can Ususally Be Used Interchangably

SELECT prod_name, prod_price
FROM Products
WHERE prod_price BETWEEN 5 AND 10  -- Checking for a Range of Values

SELECT prod_name
FROM Products
WHERE prod_price IS NULL  -- Checking for No Value

SELECT cust_name
FROM Customers
WHERE cust_email IS NULL  -- Checking for No Value