-- Using Table Aliases
SELECT cust_name, cust_contact
FROM Customers AS C, Orders AS O, OrderItems AS OI
WHERE C.cust_id = O.cust_id
  AND O.order_num = OI.order_num
  AND prod_id = 'RGAN01'


-- Using Different Join Types
-- Self Joins
SELECT cust_id, cust_name, cust_contact
FROM Customers
WHERE cust_name = (SELECT cust_name
                  FROM Customers
                  WHERE cust_contact = 'Jim Jones')

SELECT c1.cust_id, c1.cust_name, c1.cust_contact
FROM Customers AS C1, Customers AS C2
WHERE C1.cust_name = C2.cust_name
  AND C2.cust_contact = 'Jim Jones'
-- NOTE: Most DBMSs Process JOIN Far More Quickly Than They Do Subqueries

-- Natural Joins -> Eliminate Multiple Occurences So That Only One of Each Column is Returned
SELECT C.*, O.order_date, OI.prod_id, OI.quantity, OI.item_price
FROM Customers AS C, Orders AS O, OrderItems AS OI
WHERE C.cust_id = O.cust_id
  AND O.order_num = OI.order_num
  AND prod_id = 'RGAN01'

-- Outer Joins -> Include Rows That Have No Related Rows
SELECT Customers.cust_id, Orders.order_num
FROM Customers INNER JOIN Orders
    ON Customers.cust_id = Orders.cust_id

SELECT Customers.cust_id, Orders.order_num
FROM Customers LEFT OUTER JOIN Orders       -- Left
    ON Customers.cust_id = Orders.cust_id

SELECT Customers.cust_id, Orders.order_num
FROM Customers RIGHT OUTER JOIN Orders      -- Right
    ON Customers.cust_id = Orders.cust_id

SELECT Customers.cust_id, Orders.order_num
FROM Customers FULL OUTER JOIN Orders       -- Full
    ON Customers.cust_id = Orders.cust_id


-- Using Joins with Aggregate Functions
SELECT Customers.cust_id, COUNT(Orders.order_num) AS num_ord
FROM Customers INNER JOIN Orders            -- Inner Join
    ON Customers.cust_id = Orders.cust_id
GROUP BY Customers.cust_id

SELECT Customers.cust_id, COUNT(Orders.order_num) AS num_ord
FROM Customers LEFT OUTER JOIN Orders       -- Left Outer Join
    ON Customers.cust_id = Orders.cust_id
GROUP BY Customers.cust_id