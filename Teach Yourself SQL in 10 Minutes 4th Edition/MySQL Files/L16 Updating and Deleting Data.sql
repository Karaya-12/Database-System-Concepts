-- Updating Data
-- Update A Specific Row
UPDATE Customers
SET cust_email = 'kim@thetoystore.com'
WHERE cust_id = '1000000005'

-- Update Multiple Rows
UPDATE Customers
SET cust_contact = 'Sam Roberts',
    cust_email = 'sam@toyland.com'
WHERE cust_id = '1000000006'

-- Set NULL --> Delete A Column's Value (Not Data !)
UPDATE Customers
SET cust_email = NULL
WHERE cust_id = '1000000005'


-- Deleting Data
DELETE FROM Customers
WHERE cust_id = '1000000006'
-- NOTE: DELETE Statement Deletes (All) Rows From The Table. But DELETE NEVER Deletes The Table Itself