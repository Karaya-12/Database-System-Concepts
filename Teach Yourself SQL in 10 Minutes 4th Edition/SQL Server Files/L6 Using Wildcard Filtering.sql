-- Using the LIKE Operator
SELECT prod_id, prod_name
FROM Products
WHERE prod_name LIKE 'Fish%'
-- Any Characters After The Word 'Fish' Will Be Retrieved

SELECT prod_id, prod_name
FROM Products
WHERE prod_name LIKE '%bean bag%'
-- Any Value That Contains The Text 'bean bag' Anywhere Within It Will Be Retrieved

SELECT prod_name
FROM Products
WHERE prod_name LIKE 'F%y'
-- Begin With An 'F' And End With A 'y'

SELECT prod_id, prod_name
FROM Products
WHERE prod_name LIKE '__ inch teddy bear'
-- The Underscore Matches Just A Single Character

SELECT prod_id, prod_name
FROM Products
WHERE prod_name LIKE '% inch teddy bear'
-- Difference Between '_' & '%'

SELECT cust_contact
FROM Customers
WHERE cust_contact LIKE '[JM]%'
ORDER BY cust_contact
-- Find All Contacts Whose Names Begin With The Letter J / M

SELECT cust_contact
FROM Customers
WHERE cust_contact LIKE '[^JM]%'  -- Wildcard Can Be NEGATED by Prefixing The Characters With '^'
-- WHERE NOT cust_contact LIKE '[JM]%'
ORDER BY cust_contact
