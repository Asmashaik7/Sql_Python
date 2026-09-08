/*
Challenge — Email Cleaning & Extraction*/

select * from CustomerEmails;

/*
CustomerID	Email
101	ayesha@gmail.com
102	rahul@yahoo.com
103	sara@outlook.com
104	imran@gmail.com
105	priya@yahoo.com*/

--SUBSTRING(column_name, start_position, number_of_characters)

select CustomerID,Email,
SUBSTRING(Email, CHARINDEX('@', Email)+1, len(Email)-CHARINDEX('@', Email)+1) as EmailProvider
from CustomerEmails;

/*
CustomerID	Email				EmailProvider
101			ayesha@gmail.com	gmail.com
102			rahul@yahoo.com		yahoo.com
103			sara@outlook.com	outlook.com
104			imran@gmail.com		gmail.com
105			priya@yahoo.com		yahoo.com*/

select CustomerID,Email,
Replace(
SUBSTRING(Email, CHARINDEX('@', Email)+1, len(Email)-CHARINDEX('@', Email)+1),'.com','') as EmailProvider
from CustomerEmails;

/*
CustomerID	Email	EmailProvider
101	ayesha@gmail.com	gmail
102	rahul@yahoo.com	yahoo
103	sara@outlook.com	outlook
104	imran@gmail.com	gmail
105	priya@yahoo.com	yahoo

CHARINDEX('@', Email) → find @
SUBSTRING() → extract after @
REPLACE() → remove .com
LOWER() → standardize case

Now try adding the Username column too. That's the part before @.
--SUBSTRING(column_name, start_position, number_of_characters) */

select 
	CustomerID,
	Email,
	SUBSTRING(Email,1,CHARINDEX('@', Email)-1) as UserName,
	Replace(
		SUBSTRING(Email, CHARINDEX('@', Email)+1, len(Email)-CHARINDEX('@', Email)+1),'.com','') as EmailProvider
from CustomerEmails;

/*
CustomerID	Email	UserName	EmailProvider
101	ayesha@gmail.com	ayesha	gmail
102	rahul@yahoo.com	rahul	yahoo
103	sara@outlook.com	sara	outlook
104	imran@gmail.com	imran	gmail
105	priya@yahoo.com	priya	yahoo

BEFORE @
   ↓
SUBSTRING(..., 1, CHARINDEX('@', Email)-1)

AFTER @
   ↓
SUBSTRING(..., CHARINDEX('@', Email)+1, ...)
*/

