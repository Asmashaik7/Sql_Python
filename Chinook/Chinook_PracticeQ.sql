
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
Q6:
*/
-- Your Query:
GO


/*
Q7:
*/
-- Your Query:
GO


/*
Q8:
*/
-- Your Query:
GO


/*
Q9:
*/
-- Your Query:
GO


/*
Q10:
*/
-- Your Query:
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

