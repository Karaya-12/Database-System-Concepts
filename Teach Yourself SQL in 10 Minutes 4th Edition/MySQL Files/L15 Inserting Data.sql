-- Inserting Complete Rows
INSERT INTO Customers
VALUES ('1000000006', 'Toy Land', '123 Any Street', 'New York', 'NY', '11111', 'USA', NULL, NULL)
-- NOTE: The Columns Must Be Populated In The Order In Which They Appear In The Table Definition

INSERT INTO Customers (cust_id,
                       cust_name,
                       cust_address,
                       cust_city,
                       cust_state,
                       cust_zip,
                       cust_country,
                       cust_contact,
                       cust_email)
VALUES ('1000000006', 'Toy Land', '123 Any Street', 'New York', 'NY', '11111', 'USA', NULL, NULL)

INSERT INTO Customers (cust_id,
                       cust_contact,
                       cust_email,
                       cust_name,
                       cust_address,
                       cust_city,
                       cust_state,
                       cust_zip,
                       cust_country)
VALUES ('1000000006', NULL, NULL, 'Toy Land', '123 Any Street', 'New York', 'NY', '11111', 'USA')
-- NOTE: Not Necessarily In The Order That The Columns Appear In The Actual Table


-- Inserting Partial Rows
INSERT INTO Customers (cust_id,
                       cust_name,
                       cust_address,
                       cust_city,
                       cust_state,
                       cust_zip,
                       cust_country)
VALUES ('1000000006', 'Toy Land', '123 Any Street', 'New York', 'NY', '11111', 'USA')
-- NOTE: Omitting Columns -->
-- 1. Column is Defined As Allowing NULL Values
-- 2. A Dafault Value is Specified in The Definition


-- Inserting Retrieved Data
/*
Declaration: To Try This Example, Create & Populate The 'CustNew' Table First
INSERT INTO Customers (cust_id,
                       cust_contact,
                       cust_email,
                       cust_name,
                       cust_address,
                       cust_city,
                       cust_state,
                       cust_zip,
                       cust_country)
SELECT cust_id, cust_contact, cust_email, cust_name, cust_address, cust_city, cust_state, cust_zip, cust_country
FROM CustNew
*/


-- Copying from One Table to Another
CREATE TABLE CustCopy AS
SELECT * FROM Customers  -- Explicit Column Names Can Be Specified Instead of The * Wildcard Character
-- NOTE: 'CREATE TABLE ___ AS SELECT ___ FROM ___' Statement Creates a New Table (Created On-the-fly) & Copies The Entire Contents Into It
-- Depending On The DBMS Being Used, Can Overwrite The Table If It Already Exists