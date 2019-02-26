-- Creating Cursors
DECLARE CustCursor CURSOR
FOR
  SELECT *
  FROM Customers
  WHERE cust_email IS NULL


-- Using Cursors
-- OPEN CustCursor
DECLARE @cust_id CHAR(10),
        @cust_name CHAR(50),
        @cust_address CHAR(50),
        @cust_city CHAR(50),
        @cust_state CHAR(5),
        @cust_zip CHAR(10),
        @cust_country CHAR(50),
        @cust_contact CHAR(50),
        @cust_email CHAR(255)
OPEN CustCursor
FETCH NEXT FROM CustCursor
    INTO @cust_id, @cust_name, @cust_address,
         @cust_city, @cust_state, @cust_zip,
         @cust_country, @cust_contact, @cust_email
WHILE @@FETCH_STATUS = 0
    BEGIN
      FETCH NEXT FROM CustCursor
          INTO @cust_id, @cust_name, @cust_address,
               @cust_city, @cust_state, @cust_zip,
               @cust_country, @cust_contact, @cust_email
     END
CLOSE CustCursor
DEALLOCATE CustCursor


/*
NOTE: Common Syntax Format
DECLARE ____(name of cursor) CURSOR
FOR
SELECT ...
FROM ...
WHERE ...

OPEN ____(name of cursor)
FETCH NEXT FROM ____ INTO ...(variables)
WHILE @@FETCH_STATUS=0
        BEGIN
                  SQL Segments... ...
                  FETCH NEXT FROM ____ INTO ...(variables)
        END
CLOSE ____
DEALLOCATE ____
 */