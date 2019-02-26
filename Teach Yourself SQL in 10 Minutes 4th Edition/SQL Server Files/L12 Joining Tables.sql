-- Creating a Join
SELECT vend_name, prod_name, prod_price
FROM Vendors, Products
WHERE Vendors.vend_id = Products.vend_id

-- Inner Join Version
SELECT vend_name, prod_name, prod_price
FROM Vendors INNER JOIN Products ON Vendors.vend_id = Products.vend_id

-- Joining Multiple Tables
SELECT vend_name, prod_name, prod_price, quantity
FROM OrderItems, Vendors, Products
WHERE Vendors.vend_id = Products.vend_id
  AND OrderItems.prod_id = Products.prod_id
  AND order_num = 20007


-- Recall Lesson 11
SELECT cust_name, cust_contact
FROM Customers
WHERE cust_id IN (SELECT cust_id
                 FROM Orders
                 WHERE order_num IN (SELECT order_num
                                     FROM OrderItems
                                     WHERE prod_id = 'RGAN01'))

-- Now Can Be Transformed Into...
SELECT cust_name, cust_contact
FROM Customers, Orders, OrderItems
WHERE Customers.cust_id = Orders.cust_id
  AND Orders.order_num = OrderItems.order_num
  AND prod_id = 'RGAN01'