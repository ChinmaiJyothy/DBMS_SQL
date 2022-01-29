Create table Actor
(
  Act_Id Number(3) Primary Key,
  Act_Name varchar(20),
  Act_Gender varchar(1)
);
Create table Director
(
  Dir_Id number(3) primary key,
  Dir_Name varchar(20),
  Dir_Phone number (10)
);
Create Table Movies
(
  Mov_Id Number(4) Primary Key,
  Mov_Title Varchar(25),
  Mov_Year number(4),
  Mov_Lang Varchar(20),
  Dir_Id Number(3) References Director(Dir_Id) On Delete Cascade
);
Create Table Movie_Cast
(
  Act_Id References Actor (Act_Id) on Delete cascade,
  Mov_Id References Movies (Mov_Id) on Delete cascade,
  Role Varchar (10),
  Primary Key (Act_Id, Mov_Id)
);
Create Table Rating
(
  Mov_Id Number (4) References Movies (Mov_Id) on Delete cascade,
  Rev_Stars Number(2)
);


INSERT INTO Actor VALUES(1,'Sharadha','F')
INSERT INTO Actor VALUES(2,'Madhavan','M')
INSERT INTO Actor VALUES(3,'Rakshith','M')
INSERT INTO Actor VALUES(4,'Tom Hanks','M')
INSERT INTO Actor VALUES(5,'Shanvi','F')

INSERT INTO Director VALUES(101,'R Hirani',9956340015);
INSERT INTO Director VALUES(102,'Rishabh',9719600310);
INSERT INTO Director VALUES(103,'Steven Spielberg',6799346111);
INSERT INTO Director VALUES(104,'Pawan',9485399209);
INSERT INTO Director VALUES(105,'Hitchcock',7766138911);

INSERT INTO Movies VALUES(501 ,'U turn',2016,'Kannada',104);
INSERT INTO Movies VALUES(502,'The Terminal',2004,'English',103);
INSERT INTO Movies VALUES(503,'3 Idiots',2009,'Hindi',101);
INSERT INTO Movies VALUES(504,'ASN',2019,'Kannada',102);
INSERT INTO Movies VALUES(505,'Vertigo',1958,'English',105);
INSERT INTO Movies VALUES(506,'Ricky',2016,'Kannada',102);

INSERT INTO Movie_Cast VALUES(1,501,'Heroine');
INSERT INTO Movie_Cast VALUES(5,504,'Heroine');
INSERT INTO Movie_Cast VALUES(4,502,'Hero');
INSERT INTO Movie_Cast VALUES(3,504,'Hero');
INSERT INTO Movie_Cast VALUES(3,506,'Hero');
INSERT INTO Movie_Cast VALUES(2,503,'Supporting');
INSERT INTO Movie_Cast VALUES(5,506,'Supporting');

INSERT INTO Rating VALUES(501,4);
INSERT INTO Rating VALUES(502,4);
INSERT INTO Rating VALUES(503,5);
INSERT INTO Rating VALUES(504,3);
INSERT INTO Rating VALUES(505,3);
INSERT INTO Rating VALUES(506,4);

--1. List the titles of all movies directed by ‘Hitchcock’.

Select Mov_Title 
From Movies M, Director D 
Where M.Dir_Id=D.Dir_Id And Dir_Name='Hitchcock';

--2. Find the movie names where one or more actors acted in two or more movies.

Select Mov_Title 
From Movies M, Movie_Cast C 
Where M.Mov_Id=C.Mov_Id And Act_Id IN 
(Select Act_Id From Movie_Cast Group By Act_Id  Having Count (Act_Id)>1) 
Group By Mov_Title Having Count (*) >1;

--3. List all actors who acted in a movie before 2000 and also in a movie after 2015 (use JOIN operation).

Select A.Act_Name, C.Mov_Title, C.Mov_Year From
Actor A, Movie_Cast B, Movies C
Where A.Act_Id=B.Act_Id And B.Mov_Id=C.Mov_Id And C.Mov_Year Not Between 2000 And 2015;

--4. Find the title of movies and number of stars for each movie that has at least one rating and find the highest number of stars that movie received.
--Sort the result by movie title.

Select Mov_Title, Max (Rev_Stars)
From Movies Inner Join Rating Using (Mov_Id)
Group By Mov_Title
Having Max (Rev_Stars)>0
Order By Mov_Title;

--5. Update rating of all movies directed by ‘Steven Spielberg’ to 5.

Update Rating
Set Rev_Stars=5
Where Mov_Id In (Select Mov_Id
From Movies M,Director D
Where M.Dir_Id=D.Dir_Id And D.Dir_Name='Steven Spielberg');

Select * from Rating;