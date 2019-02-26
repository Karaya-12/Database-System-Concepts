-- Controlling Transactions
BEGIN TRANSACTION
-- ...
COMMIT TRANSACTION


-- Using ROLLBACK
DELETE FROM Orders
ROLLBACK


-- Using COMMMIT
BEGIN TRANSACTION
DELETE OrderItems WHERE order_num = 12345
DELETE Orders WHERE order_num = 12345
COMMIT TRANSACTION
-- NOTE: Because This Involves Updating 2 Database Tables -> Orders & OrderItems,
--       A Transaction Block is Used to Ensure That The Order is Not PARTIALLY Deleted


-- Using Savepoints
SAVE TRANSACTION delete1

ROLLBACK TRANSACTION delete1


-- Complete SQL Server Example
BEGIN TRANSACTION
-- Insertion I
INSERT INTO Customers(cust_id, cust_name)
VALUES ('1000000010', 'Toys Emporium')
SAVE TRANSACTION StartOrder  -- Save Point I
-- Insertion II
INSERT INTO Orders(order_num, order_date, cust_id)
VALUES (20100, '2001/12/1', '1000000010')
IF @@ERROR <> 0 ROLLBACK TRANSACTION StartOrder
-- Insertion III
INSERT INTO OrderItems(order_num, order_item, prod_id, quantity, item_price)
VALUES (20100, 1, 'BR01', 100, 5.49)
IF @@ERROR <> 0 ROLLBACK TRANSACTION StartOrder
-- Insertion IV
INSERT INTO OrderItems(order_num, order_item, prod_id, quantity, item_price)
VALUES (20100, 2, 'BR02', 100, 10.99)
IF @@ERROR <> 0 ROLLBACK TRANSACTION StartOrder
COMMIT TRANSACTION