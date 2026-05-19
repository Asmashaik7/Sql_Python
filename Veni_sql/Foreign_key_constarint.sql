-- FOREIGN KEY constraint and REFERENTIAL INTEGRITY
--PARENT TABLE

CREATE TABLE CUSTOMER
(
	CUSTOMERID INT PRIMARY KEY,
	NAME VARCHAR(20)
)
drop table CUSTOMER

select * from CUSTOMER
--ERROR: Invalid object name 'CUSTOMER'. As i deleted it to prefix it with FK.
----------------------------------
CREATE TABLE FK_CUSTOMER
(
	CUSTOMERID INT PRIMARY KEY,
	NAME VARCHAR(20)
)

INSERT INTO FK_CUSTOMER(CUSTOMERID,NAME) VALUES(1,'RAM')

1 XXX
2 YYY
3 ZZZ

--CHILD TABLE
CREATE TABLE FK_ORDERS
(
  ORDERID INT PRIMARY KEY,
  CUSTOMERID INT,
  FOREIGN KEY(CUSTOMERID) REFERENCES FK_CUSTOMER(CUSTOMERID)
)

INSERT INTO FK_ORDERS(ORDERID,CUSTOMERID) VALUES(101,1)

select * from FK_ORDERS
-- We have only 1 row in FK_ORDERS table. 

INSERT INTO FK_ORDERS(ORDERID,CUSTOMERID) VALUES(102,2)  - INVALID DATA
--ERROR: The INSERT statement conflicted with the FOREIGN KEY constraint
--Its invalid data, as 102 ORDERID did not exists. WIthput existing how it will have an order? so ERROR.
----------------------------------------------------------------------------

-- WHY WE USE FOREIGN KEY
 -- PREVENTS INVALID DATA ENTRY
 -- MAINTAINS RELASHINSHIP BETWEEN TABLES
 -- ENSURES DATA CONSISTENCY
 =====================================================================================================