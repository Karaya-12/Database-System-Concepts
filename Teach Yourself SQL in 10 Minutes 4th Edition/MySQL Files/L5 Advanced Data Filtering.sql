-- Combining WHERE Clause
SELECT prod_id, prod_price, prod_name
FROM Products
WHERE vend_id = 'DLL01' AND prod_price <= 4

SELECT prod_name, prod_price
FROM Products
WHERE vend_id = 'DLL01' OR vend_id = 'BRS01'

/*Pay Great Attention: Order of Evaluation !!!*/
SELECT prod_name, prod_price
FROM Products
WHERE vend_id = 'DLL01' OR vend_id = 'BRS01' AND prod_price >= 10  -- SQL Processes AND Before OR
-- Actual Meaning: ( vend_id = 'DLL01' ) OR ( vend_id = 'BRS01' AND prod_price >= 10 )

SELECT prod_name, prod_price
FROM Products
WHERE (vend_id = 'DLL01' OR vend_id = 'BRS01') AND prod_price >= 10  --Revised

-- Using the IN Operator
SELECT prod_name, prod_price
FROM Products
WHERE vend_id IN ('DLL01', 'BRS01')
-- WHERE vend_id = 'DLL01' OR vend_id = 'BRS01'
ORDER BY prod_name

-- Using the NOT Operator
SELECT prod_name
FROM Products
WHERE NOT vend_id = 'DLL01'
-- WHERE vend_id <> 'DLL01'
ORDER BY prod_name
