-- Concatenating Fields
SELECT vend_name + ' (' + vend_country + ')' AS vend_title
FROM Vendors
ORDER BY vend_name

SELECT RTRIM(vend_name) + ' (' + RTRIM(vend_country) + ')' AS vend_title -- RTRIM() --> Trim The Right Side of a String
FROM Vendors
ORDER BY vend_name

-- Performing Mathematical Calculations
SELECT prod_id, quantity, item_price,
       quantity * item_price AS expanded_price
FROM OrderItems
WHERE order_num = 20008

-- Test Calculations
SELECT 3 * 2
SELECT TRIM(' ABC ')