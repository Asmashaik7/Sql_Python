DROP TABLE IF EXISTS Employees1;
DROP TABLE IF EXISTS Departments1;

CREATE TABLE Departments1 (
    Dept_ID INT PRIMARY KEY,
    Dept_Name VARCHAR(50)
);

CREATE TABLE Employees1 (
    Emp_ID INT PRIMARY KEY IDENTITY(1,1),
    Name VARCHAR(50),
    Email VARCHAR(100) UNIQUE,
    Dept_ID INT,
    FOREIGN KEY (Dept_ID) REFERENCES Departments1(Dept_ID)
);


select * from Departments1;
select * from Employees1;
------------------------------------------------------------------------------------
--multiple inserts
INSERT INTO Departments1 (Dept_ID, Dept_Name)
VALUES (1,'HR'), (2,'IT'),(3,'PRODUCTS'),(4,'SALES');

--multiple inserts
INSERT INTO Employees1(Name, Email,Dept_ID) values ('Asma','asma@mail.com',1),
('Aymann','aymann@gmail.com',2),
('Zoi','zoi@gmail.com',1),
('Aymann1','aymann1@gmail.com',2),
('Taqi','Taqi@gmail.com',2),
('Zoya','zoya@gmail.com',1),
('Manha','manha@gmail.com',2),
('Junaina','junaina@mail.com',4),
('Jaffer','jaffer@gmail.com',4),
('shaik','shaik@mail.com',3),
('sk','sk@mail.com',2),
('skasma','skasma@mail.com',3),
('Ayman1','ayman1@gmail.com',2),
('Taqi1','Taqi1@gmail.com',2),
('Zoya1','zoya1@gmail.com',1),
('Manha1','manha1@gmail.com',2),
('Junaina1','junaina1@mail.com',4),
('Jaffer1','jaffer1@gmail.com',4),
('shaik1','shaik1@mail.com',3),
('sk1','sk1@mail.com',2),
('skasma1','skasma1@mail.com',3);

select * from Employees1;