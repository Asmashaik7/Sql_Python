IF NOT EXISTS(select * from sys.databases where name= 'School_db')
begin
create database School_db;
print 'DB created successfully';
end
Go

use school_db;
GO

create table if not exists students(
id integer primary key,
fname TEXT,
lname TEXT,
age integer
)
GO
