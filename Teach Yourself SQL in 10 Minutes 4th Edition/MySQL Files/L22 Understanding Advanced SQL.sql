-- Primary Keys
-- First Approach --> Create Primary Keys
CREATE TABLE Vendors
(
  vend_id      char(10) NOT NULL PRIMARY KEY,
  vend_name    char(50) NOT NULL,
  vend_address char(50) NULL,
  vend_city    char(50) NULL,
  vend_state   char(5)  NULL,
  vend_zip     char(10) NULL,
  vend_country char(50) NULL
);

-- Another Approach --> Using The 'Alter Table ... Add Constraint' Syntax
ALTER TABLE Vendors
    ADD CONSTRAINT PRIMARY KEY (vend_id)


-- Foreign Keys
-- First Approach --> Create Foreign Keys
CREATE TABLE Orders
(
  order_num  int      NOT NULL PRIMARY KEY,
  order_date datetime NOT NULL,
  cust_id    char(10) NOT NULL REFERENCES Customers(cust_id)
);

-- Another Approach --> Using The 'Alter Table ... Add Constraint' Syntax
ALTER TABLE Orders
    ADD CONSTRAINT FOREIGN KEY (cust_id) REFERENCES Customers(cust_id)


-- Check Constraints
-- First Approach
CREATE TABLE OrderItems
(
  order_num  int          NOT NULL,
  order_item int          NOT NULL,
  prod_id    char(10)     NOT NULL,
  quantity   int          NOT NULL CHECK (quantity > 0),
  item_price decimal(8,2) NOT NULL
);

-- Another Approach
ALTER TABLE OrderItems
    ADD CONSTRAINT CHECK (quantity > 0)
-- Additional: Gender Contains Only M or F
-- ADD CONSTRAINT CHECK (gender LIKE '[MF]')


-- Understanding Indexes
CREATE INDEX prod_name_ind
  ON Products (prod_name)


-- Understanding Triggers
-- Convert The cust_state Column In The Customers Table to Uppcase On All INSERT & UPDATE Operations
CREATE TRIGGER customer_state
  ON Customers
  FOR INSERT, UPDATE
  AS
  UPDATE Customers
  SET cust_state = UPPER(cust_state)
  WHERE Customers.cust_id = inserted.cust_id
-- NOTE: Constraints Are Faster Than Triggers --> Whenever Possible, Use Constraints Instead