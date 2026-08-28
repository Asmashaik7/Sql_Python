/* STRING FUNCTIONS
First scenario: Customer Data Cleanup

Imagine you're a Data Analyst at an e-commerce company.

The customer database contains messy names:

CustomerID | CustomerName
-----------|----------------
101        | '  Ayesha  '
102        | 'RAHUL'
103        | ' sara '
104        | 'IMRAN   '
105        | '  Priya'

The manager says:

"Give me a clean customer name with unnecessary spaces removed and the name displayed consistently."
*/
CREATE TABLE CustomerDetails
(
    CustomerID INT,
    CustomerName VARCHAR(100),
    Email VARCHAR(100),
    Phone VARCHAR(20)
);

INSERT INTO CustomerDetails
VALUES
(101, '  Ayesha Shaik  ', 'AYESHA@GMAIL.COM', '9876543210'),
(102, 'Rahul Kumar', 'rahul@yahoo.com', '8777777777'),
(103, '  sara ali', 'SARA@OUTLOOK.COM', '9123456780'),
(104, 'IMRAN KHAN  ', 'imran@gmail.com', '9988776655'),
(105, ' Priya Reddy ', 'PRIYA@GMAIL.COM', '9999999999');

select * from CustomerDetails;

/*
CustomerID	CustomerName	Email	Phone
101	  Ayesha Shaik  	AYESHA@GMAIL.COM	9876543210
102	Rahul Kumar	rahul@yahoo.com	8777777777
103	  sara ali	SARA@OUTLOOK.COM	9123456780
104	IMRAN KHAN  	imran@gmail.com	9988776655
105	 Priya Reddy 	PRIYA@GMAIL.COM	9999999999

FUNCTIONS SYNTAX:
LEN(column_name)
-- LEFT
LEFT(column_name, number_of_characters)
-- RIGHT
RIGHT(column_name, number_of_characters)
-- SUBSTRING
SUBSTRING(column_name, start_position, number_of_characters)

Business requirement

The CRM team has imported customer data from different sources, and the names/emails aren't consistently formatted.

They want a report containing:

CustomerID
CleanName — remove unnecessary spaces and display the name consistently
CleanEmail — display the email consistently in lowercase*/

select CustomerID, 
lower(TRIM(CustomerName)) as CustomerName, 
lower(Email) as Email
from CustomerDetails;

/*
CustomerID	CustomerName	Email
101	Ayesha Shaik	ayesha@gmail.com
102	Rahul Kumar	rahul@yahoo.com
103	sara ali	sara@outlook.com
104	IMRAN KHAN	imran@gmail.com
105	Priya Reddy	priya@gmail.com

CustomerID	CustomerName	Email
101	ayesha shaik	ayesha@gmail.com
102	rahul kumar	rahul@yahoo.com
103	sara ali	sara@outlook.com
104	imran khan	imran@gmail.com
105	priya reddy	priya@gmail.com*/

CREATE TABLE StringOrders
(
    OrderID VARCHAR(20)
);

INSERT INTO StringOrders
VALUES
('ORD-2026-001'),
('ORD-2026-145'),
('ORD-2025-089'),
('ORD-2026-230'),
('ORD-2024-017'),
('ORD-2025-312');

select * from StringOrders;
/*
OrderID
ORD-2026-001
ORD-2026-145
ORD-2025-089
ORD-2026-230
ORD-2024-017
ORD-2025-312

The operations team wants:

OrderID	OrderYear	OrderNumber
ORD-2026-001	2026	001
ORD-2026-145	2026	145
*/
select OrderID,
substring(OrderID,5,4) as OrderYear,
right(OrderID,3) as OrderNumber
from StringOrders;

/*
OrderID	OrderYear	OrderNumber
ORD-2026-001	2026	001
ORD-2026-145	2026	145
ORD-2025-089	2025	089
ORD-2026-230	2026	230
ORD-2024-017	2024	017
ORD-2025-312	2025	312

===============================================================================================================

Interview-style Challenge 2 — CHARINDEX()

You have:*/

CREATE TABLE CustomerEmails
(
    CustomerID INT,
    Email VARCHAR(100)
);

INSERT INTO CustomerEmails
VALUES
(101, 'ayesha@gmail.com'),
(102, 'rahul@yahoo.com'),
(103, 'sara@outlook.com'),
(104, 'imran@gmail.com'),
(105, 'priya@yahoo.com');

/*Business requirement

The marketing team wants to analyze customers by email provider.

They need:

CustomerID	Email	EmailProvider
101	ayesha@gmail.com	gmail.com
102	rahul@yahoo.com	yahoo.com

*/
