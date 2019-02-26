-- Executing Stored Procedures
/*Not Be Able to Actually Run It, As The Stored Prodcedure 'AddNewProduct' Doesn't Exist*/
EXECUTE AddNewProduct ('JTS01',
                       'Stuffed Eiffel Tower',
                       6.49,
                       'Plush stuffed toy with the text La Tour Eiffel in red white and blue')


-- Creating Stored Procedures
/*
                 --Oracle Version--
CREATE PROCEDURE MailingListCount (
  ListCount OUT INTEGER  -- The Stored Procedure Takes A Single Parameter Nmaed 'ListCount'
  -- Keyword OUT: Pass A Value From Stored Procedure
)
IS
v_rows INTEGER;
BEGIN
  SELECT COUNT(*) INTO v_rows
  FROM Customers
  WHERE NOT cust_email IS NULL;
  ListCount := v_rows;
END;
*/

/*
-- Count The NUmber of Customers In a Mailing List Who Have E-Mail Address
-- SQL Server Version
CREATE PROCEDURE MailingListCount
  AS
DECLARE @cnt INTEGER  -- Local Variable Named '@cnt' is Declared Using The DECLARE Statement
SELECT @cnt = COUNT(*)
FROM Customers
WHERE NOT cust_email IS NULL
RETURN @cnt

-- Invoke The Stored Procedure
DECLARE @ReturnValue INT
EXECUTE @ReturnValue = MailingListCount;
SELECT @ReturnValue;

-- Insert A New Order In The 'Orders' Table
-- SQL Server Only Version
CREATE PROCEDURE NewOrder @cust_id CHAR(10)
  AS
DECLARE @order_num INTEGER  -- Declare Variable for Order Number
SELECT @order_num = MAX(order_num)
FROM Orders
SELECT @order_num = @order_num + 1  -- Determine Next Order Number
-- Insert New Order
INSERT INTO Orders(order_num, order_date, cust_id)
VALUES (@order_num, GETDATE(), @cust_id)
RETURN @order_num

-- Another Version of Preceding Code
CREATE PROCEDURE NewOrder @cust_id CHAR(10)
  AS
INSERT INTO Orders(cust_id)
VALUES (@cust_id)
SELECT order_num = @@IDENTITY  -- Return Order Number
*/