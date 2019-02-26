-- Text Manippolation Functions
SELECT vend_name, UPPER(vend_name) AS vend_name_upcase
FROM Vendors
ORDER BY vend_name_upcase
/*
Commonly Used Text-Manipulation Functions --> Refer to Table 8.2
upper(), lower()
left(), right()
ltrim(), rtrim(), trim()
length()
soundex()
*/

SELECT cust_name, cust_contact
FROM Customers
WHERE cust_contact = 'Michael Green'  -- Not Using The soundex() --> Return Nothing

SELECT cust_name, cust_contact
FROM Customers
WHERE SOUNDEX(cust_contact) = SOUNDEX('Michael Green')
-- Using The soundex()  --> Return The Result Which Has A Similar Sound -> 'Michelle Green'

SELECT order_num
FROM Orders
WHERE DATEPART(yy, order_date) = 2012  -- DATEPART() --> Return Just The YEAR From The 'order_date' Column

/*
Commonly Used Numeric Manipulation Functions --> Refer to Table 8.3
ABS(), SQRT()
EXP()
PI()
COS(), SIN(), TAN()
 */