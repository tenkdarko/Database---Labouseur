2. SQL Statements

PEOPLE TABLE
CREATE TABLE people(
PID integer not null,
FirstName varchar(40) not null,
LastName varchar(40) not null,
Address varchar(90),
Primary Key (pid)
);

ACTOR TABLE
CREATE TABLE Actors(
PID integer references People(pid) not null,
HairColor char(30),
EyeColor char(30),
BirthDate date,
HeightInInches integer,
Weight integer, 
SpouseName char(30)
FavoriteColor char(30)
SAGAD date,
Primary Key (pid) 
);

DIRECTOR TABLE
Create Table Director(
PID integer references People(pid) not null,
Spousename char(30),
SchoolAttended varchar(100),
DGAD date,
FavLensmaker char(30),
Primary Key(pid)
);

Movie Table
Create Table Movie(
MID integer not null,
name char(30) not null,
YearReleased char(4),
MPAANumber char(10),
DBOS integer,
FBOS integer,
DVDBlueSales integer,
Primary Key(mid)
);

Movie Director Table
Create Table MovieDirector(
PID integer references People(pid) not null,
MID integer references Movie(mid) not null,
Primary Key(PID,MID)
);
Actor Director Table
Create Table MovieActor(
PID integer references People(pid) not null,
MID integer references Movie(mid) not null,
Primary Key(PID,MID)
);



/*QUERY FOR SEAN */

4. Query For Sean Connery 
Select p.firstname, p.lastname
FROM people p, director d
WHERE p.pid = ( 
Select d.pid
From moviedirector m
Where m.pid = (
(Select a.pid
From actor a, people p
WHERE a.pid = p.pid
AND p.firstname = “Sean”
AND p.lastname = “Connery”)));
