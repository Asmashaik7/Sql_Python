CREATE DATABASE Chinook;
USE Chinook;

CREATE TABLE Album
(
    AlbumId INT PRIMARY KEY IDENTITY(1,1),
    Title NVARCHAR(160) NOT NULL,
    ArtistId INT NOT NULL
);
CREATE TABLE Artist
(
    ArtistId INT NOT NULL IDENTITY(1,1),
    Name NVARCHAR(120),
    CONSTRAINT PK_Artist PRIMARY KEY  (ArtistId)
);

CREATE TABLE Customer
(
    CustomerId INT NOT NULL IDENTITY(1,1),
    FirstName NVARCHAR(40) NOT NULL,
    LastName NVARCHAR(20) NOT NULL,
    Company NVARCHAR(80),
    Address NVARCHAR(70),
    City NVARCHAR(40),
    State NVARCHAR(40),
    Country NVARCHAR(40),
    PostalCode NVARCHAR(10),
    Phone NVARCHAR(24),
    Fax NVARCHAR(24),
    Email NVARCHAR(60) NOT NULL,
    SupportRepId INT,
    CONSTRAINT PK_Customer PRIMARY KEY  (CustomerId)
);
USE Chinook;
GO
CREATE TABLE Employee
(
    EmployeeId INT NOT NULL IDENTITY(1,1),
    LastName NVARCHAR(20) NOT NULL,
    FirstName NVARCHAR(20) NOT NULL,
    Title NVARCHAR(30),
    ReportsTo INT,
    BirthDate DATETIME,
    HireDate DATETIME,
    Address NVARCHAR(70),
    City NVARCHAR(40),
    State NVARCHAR(40),
    Country NVARCHAR(40),
    PostalCode NVARCHAR(10),
    Phone NVARCHAR(24),
    Fax NVARCHAR(24),
    Email NVARCHAR(60),
    CONSTRAINT PK_Employee PRIMARY KEY  (EmployeeId)
);

CREATE TABLE Genre
(
GenreID INT NOT NULL IDENTITY(1,1),
Nane NVARCHAR(40) NOT NULL,
CONSTRAINT PK_Genre PRIMARY KEY (GenreID)
);

CREATE TABLE INVOICE
(
InvoiceID INT NOT NULL IDENTITY(1,1),
CustomerID INT NOT NULL,
Invoicedate DATETIME,
BillingAddress NVARCHAR(80),
BillingCity NVARCHAR(20),
BillingState NVARCHAR(30),
BillingCountry NVARCHAR(30),
BillingPostalCode NVARCHAR(30),
Total NUMERIC(10,2) NOT NULL,
CONSTRAINT PK_Invoice PRIMARY KEY  (InvoiceId)
);


CREATE TABLE InvoiceLine
(
    InvoiceLineId INT NOT NULL IDENTITY(1,1),
    InvoiceId INT NOT NULL,
    TrackId INT NOT NULL,
    UnitPrice NUMERIC(10,2) NOT NULL,
    Quantity INT NOT NULL,
    CONSTRAINT PK_InvoiceLine PRIMARY KEY  (InvoiceLineId)
);

CREATE TABLE MediaType
(
    MediaTypeId INT NOT NULL IDENTITY(1,1),
    Name NVARCHAR(120),
    CONSTRAINT PK_MediaType PRIMARY KEY  (MediaTypeId)
);

CREATE TABLE Playlist
(
    PlaylistId INT NOT NULL IDENTITY(1,1),
    Name NVARCHAR(120),
    CONSTRAINT PK_Playlist PRIMARY KEY  (PlaylistId)
);

CREATE TABLE PlaylistTrack
(
    PlaylistId INT NOT NULL,
    TrackId INT NOT NULL,
    CONSTRAINT PK_PlaylistTrack PRIMARY KEY  (PlaylistId, TrackId)
);

CREATE TABLE Track
(
    TrackId INT NOT NULL IDENTITY(1,1),
    Name NVARCHAR(200) NOT NULL,
    AlbumId INT,
    MediaTypeId INT NOT NULL,
    GenreId INT,
    Composer NVARCHAR(220),
    Milliseconds INT NOT NULL,
    Bytes INT,
    UnitPrice NUMERIC(10,2) NOT NULL,
    CONSTRAINT PK_Track PRIMARY KEY  (TrackId)
);
USE master;
DROP TABLE dbo.Employee;
DROP TABLE dbo.Genre;
DROP TABLE dbo.INVOICE;
DROP TABLE dbo.InvoiceLine;
DROP TABLE dbo.MediaType;
DROP TABLE dbo.Playlist;
DROP TABLE dbo.PlaylistTrack;
DROP TABLE dbo.Track;

USE Chinook;
GO

