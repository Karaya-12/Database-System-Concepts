-- Using Views to Simplify Complex Joins
CREATE VIEW ProductCustomers AS
SELECT cust_name, cust_contact, prod_id
FROM Customers, Orders, OrderItems
WHERE Customers.cust_id = Orders.cust_id
  AND OrderItems.order_num = Orders.order_num

-- Usage of The Created View
SELECT cust_name, cust_contact
FROM ProductCustomers
WHERE prod_id = 'RGAN01'


-- Using Views to Reformat Retrieved Data
CREATE VIEW VendorLocations AS
SELECT RTRIM(vend_name) + ' (' + RTRIM(vend_country) + ')' AS vend_title
FROM Vendors

-- Usage of The Created View
SELECT *
FROM VendorLocations


-- Using Views to Filter Unwanted Data
CREATE VIEW CustomerEMailList AS
SELECT cust_id, cust_name, cust_email
FROM Customers
WHERE cust_email IS NOT NULL

-- Usage of Created View
SELECT *
FROM CustomerEMailList


-- Using Views with Calculated Fields
CREATE VIEW OrderItemsExpanded AS
SELECT order_num, prod_id, quantity, item_price,
       quantity * item_price AS expanded_price
FROM OrderItems

-- Usage of The Created View
SELECT *
FROM OrderItemsExpanded
WHERE order_num = 20008