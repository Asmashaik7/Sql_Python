/*TRIM(column_name)

LOWER(column_name)

UPPER(column_name)

LEN(column_name)

LEFT(column_name, number_of_characters)

RIGHT(column_name, number_of_characters)

SUBSTRING(column_name, start_position, number_of_characters)

CHARINDEX('text_to_find', column_name)

REPLACE(column_name, 'old_text', 'new_text')
=========================================================
Final String Challenge — Product Codes

You're working with an e-commerce product table:*/

CREATE TABLE Products
(
    ProductID INT,
    ProductCode VARCHAR(50)
);

INSERT INTO Products
VALUES
(1, ' ELEC-LAPTOP-001 '),
(2, 'HOME-CHAIR-025'),
(3, '  ELEC-PHONE-103'),
(4, 'CLOTH-SHIRT-210  '),
(5, 'HOME-TABLE-055');

select * from Products;
/*
ProductID	ProductCode
1	    ELEC-LAPTOP-001 
2	    HOME-CHAIR-025
3	    ELEC-PHONE-103
4	    CLOTH-SHIRT-210  
5	    HOME-TABLE-055
--------------------------------
The product team wants a clean report:

ProductID	CleanCode	    Category	ProductNumber
1	        ELEC-LAPTOP-001	ELEC	    001
2	        HOME-CHAIR-025	HOME	    025
3	        ELEC-PHONE-103	ELEC	    103
4	        CLOTH-SHIRT-210	CLOTH	    210
5	        HOME-TABLE-055	HOME	    055

------------------------------------------------------------
SUBSTRING(column_name, start_position, number_of_characters)

CHARINDEX('text_to_find', column_name)
-----------------------------------------------*/
select ProductID,
ProductCode,
   substring(ProductCode,1, charindex('-',ProductCode)-1) as Category,
    right(ProductCode,3) as ProductNumber
    from Products;
/*I got but wrong codes,
ProductID	ProductCode	Category	ProductNumber
1	 ELEC-LAPTOP-001 	 ELEC	        01 
2	HOME-CHAIR-025	HOME	            025
3	  ELEC-PHONE-103	  ELEC	        103
4	CLOTH-SHIRT-210  	CLOTH	         0  
5	HOME-TABLE-055	HOME	            055

as i have spaces infront of the productcodes, i got the answers like this.
if i use trim then we can rectify i think
*/
select ProductID,
ProductCode,
   substring(ProductCode,1, charindex('-',ProductCode)-1) as Category,
    right(trim(ProductCode),3) as ProductNumber
    from Products;
/*
ProductID	ProductCode	Category	ProductNumber
1	 ELEC-LAPTOP-001 	 ELEC	001
2	HOME-CHAIR-025	    HOME	025
3	  ELEC-PHONE-103	  ELEC	103
4	CLOTH-SHIRT-210  	CLOTH	210
5	HOME-TABLE-055	    HOME	055
=================================================
Raw data
   ↓
TRIM()
   ↓
Clean data
   ↓
LEFT / RIGHT / SUBSTRING / CHARINDEX
===========================

*/






