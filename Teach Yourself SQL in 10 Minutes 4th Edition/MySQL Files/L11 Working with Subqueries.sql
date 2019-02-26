-- Filtering by Subquery
-- A List of All The Customers Who Ordered Item 'RGAN01'
SELECT cust_id
FROM Orders
WHERE order_num IN (SELECT order_num
                    FROM OrderItems
                    WHERE prod_id = 'RGAN01')
-- NOTE: Subqueries Are Always Processed With The INNERMOST SELECT Statement And Working Outward
--       Formatting Your SQL !!!

-- Further: Retrieve The Customer Information For Each of Those Customers
SELECT cust_name, cust_contact
FROM Customers
WHERE cust_id IN (SELECT cust_id
                 FROM Orders
                 WHERE order_num IN (SELECT order_num
                                     FROM OrderItems
                                     WHERE prod_id = 'RGAN01'))


-- Using Subqueries as Calculated Fields
-- Display The Total Number of Orders Placed by Every Customer In Customers Table
SELECT cust_name, cust_state,
       (SELECT COUNT(*)
       FROM Orders
       WHERE Orders.cust_id = Customers.cust_id) AS orders
FROM Customers
ORDER BY cust_name