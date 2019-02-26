-- Understanding Data Grouping
SELECT vend_id, COUNT(*) AS num_prods
FROM Products
GROUP BY vend_id
-- NOTE: 'GROUP BY' Causes 'num_prods' to Be Calculated Once Per 'vend_id' Rather Than Once For The Entire Table


-- Filtering Groups
-- NOTE: The Only Difference Between 'WHERE' & 'HAVING' -->
--       WHERE' Filters Rows (Before Data is Grouped), 'HAVING' Filters Groups (After Data is Grouped)
SELECT cust_id, COUNT(*) AS orders
FROM Orders
GROUP BY cust_id
HAVING COUNT(*) >= 2

SELECT vend_id, COUNT(*) AS num_prods
FROM Products
WHERE prod_price >= 4
GROUP BY vend_id
HAVING COUNT(*) >= 2


-- Grouping & Sorting
-- Note: Data Grouped Using 'GROUP BY' Will Indeed Be Output In Group Order By Default
--       But One Should ALWAYS Provide An Explicit 'ORDER BY' Clause As Well
SELECT order_num, COUNT(*) AS items
FROM OrderItems
GROUP BY order_num
HAVING COUNT(*) >= 3
ORDER BY items, order_num