
---------------------------------------------------------
-- SQL PRACTICE FILE
-- CHINOOK DATABASE
-- Created by Asma (Practice + Interview Prep)
---------------------------------------------------------

-- Always set the database first
USE Chinook;
GO


=========================================================
-- LEVEL 1: BASIC SELECT QUERIES
=========================================================

/*
Q1: Get the first 10 rows from the Track table.*/
SELECT TOP 10 *
FROM TRACK;
GO


/* Q2:Show Name, Composer, UnitPrice of all tracks.*/
SELECT NAME, Composer,UnitPrice from Track; 
GO


/*Q3:Write a query to find the total number of tracks.*/
select count(*) from Track;
GO
--4503

/* Q4:Get all tracks where UnitPrice is more than 0.99.*/
select * from Track where UnitPrice>0.99;
GO

/*Q5:Find all albums released by the Artist ‘Queen’*/
select Ar.ArtistId, Ar.Name,al.Title
from Artist Ar
join Album Al on
Ar.ArtistId = Al.ArtistId
where Name='Queen';


select * from Album;

/*
Q6:List all artists whose name starts with ‘A’
*/
SELECT ArtistId, Name
FROM Artist
WHERE Name LIKE 'A%';
GO


/*
Q7:List all artists whose name starts with ‘A’ with case sensitive
*/
SELECT ArtistId, Name
FROM Artist
WHERE lower(Name) LIKE 'a%';
GO


/*
Q8:Show all albums along with their Artist names
*/
SELECT ar.ArtistId, ar.Name AS ArtistName, al.AlbumId, al.Title AS AlbumTitle
FROM Album al
JOIN Artist ar ON al.ArtistId = ar.ArtistId
ORDER BY ar.ArtistId, al.AlbumId;
GO


/*
Q9:Find all tracks whose UnitPrice is greater than 0.99
*/
SELECT TrackId, Name AS TrackName, UnitPrice
FROM Track
WHERE UnitPrice > 0.99
ORDER BY UnitPrice DESC;

GO


/*
Q10:Count how many tracks are in each Album
*/
SELECT al.AlbumId, al.Title AS AlbumTitle, COUNT(t.TrackId) AS TrackCount
FROM Album al
LEFT JOIN Track t ON al.AlbumId = t.AlbumId
GROUP BY al.AlbumId, al.Title
ORDER BY TrackCount DESC, al.Title;
GO


/*
Q11:Find the total number of customers from each Country
*/
SELECT Country, COUNT(CustomerId) AS CustomerCount
FROM Customer
GROUP BY Country
ORDER BY CustomerCount DESC, Country;
GO
=========================================================
-- LEVEL 3: GROUP BY QUERIES
=========================================================

/*
Q11:
*/
-- Your Query:
GO


/*
Q12:
*/
-- Your Query:
GO


/*
Q13:
*/
-- Your Query:
GO


/*
Q14:
*/
-- Your Query:
GO


/*
Q15:
*/
-- Your Query:
GO



=========================================================
-- LEVEL 4: SUBQUERY PRACTICE
=========================================================

/*
Q16:
*/
-- Your Query:
GO


/*
Q17:
*/
-- Your Query:
GO


/*
Q18:
*/
-- Your Query:
GO


/*
Q19:
*/
-- Your Query:
GO


/*
Q20:
*/
-- Your Query:
GO



=========================================================
-- LEVEL 5: INTERVIEW-STYLE QUESTIONS
=========================================================

/*
Q21:
*/
-- Your Query:
GO


/*
Q22:
*/
-- Your Query:
GO


/*
Q23:
*/
-- Your Query:
GO


/*
Q24:
*/
-- Your Query:
GO


/*
Q25:
*/
-- Your Query:
GO



---------------------------------------------------------
-- END OF PRACTICE FILE
---------------------------------------------------------

