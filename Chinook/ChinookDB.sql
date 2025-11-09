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