Create Table Publisher 
(
    Name Varchar(20) PRIMARY KEY,
    Phone Int,
    Address Varchar(20)
);
Create Table Book
(
    Book_id int Primary Key,
    Title Varchar(20),
    Pub_Year Varchar(20),
    Publisher_name Varchar(20) REFERENCES Publisher(Name) On Delete Cascade 
);
Create Table Book_Authors(
    Author_name Varchar(20),
    Book_id int REFERENCES Book(Book_id) On Delete Cascade 
 );
 Create Table Library_programme
 (
     Programme_id int Primary Key,
     Programme_name Varchar(20),
     Address Varchar(20)
 );
 Create Table Book_copies
 (
     No_of_Copies Int,
     Book_id int REFERENCES Book(Book_id) On Delete CASCADE,
     Programme_id Int REFERENCES Library_programme(Programme_id) On Delete CASCADE,
     PRIMARY KEY(Book_id,Programme_id)
 );
  Create Table Card
 (
     Card_no int Primary Key
 );
 Create Table Book_Lending
 (
     Day_out Date,
     Due_date Date,
     Book_id int REFERENCES Book(Book_id) On Delete CASCADE,
     Programme_id Int REFERENCES Library_programme(Programme_id) On Delete CASCADE,
     Card_no int REFERENCES Card(Card_no) On Delete CASCADE,
     PRIMARY KEY(Book_id,Programme_id,Card_no)
 );

Insert into Publisher values('Mcgraw-hill',9878738737,'Bangalore'); 
Insert into Publisher values('MIT',9987782718,'Mangalore');
Insert into Publisher values('Pearson',8988783721,'New Delhi');
Insert into Publisher values('Wiley',7878378738,'Mysore');
Insert into Publisher values('Prentice Hall',9882736453,'Chennai');

Insert into Book values(1,'DBMS','Jan-2017','Mcgraw-hill'); 
Insert into Book values(2,'ADBMS','Jun-2017','Mcgraw-hill');
Insert into Book values(3,'CD','Sep-2016','Pearson');
Insert into Book values(4,'Algorithms','Sep-2015','MIT');
Insert into Book values(5,'OS','May-2016','Pearson');

Insert into Book_Authors values('Navathe',1); 
Insert into Book_Authors values('Navathe',2);
Insert into Book_Authors values('Ullman',3);
Insert into Book_Authors values('Charles',4);
Insert into Book_Authors values('Galvin',5);

Insert into Library_programme values(10,'Vijay Nagar','Banglore'); 
Insert into Library_programme values(11,'vijay Nagar','Mysore');
Insert into Library_programme values(12,'RR nagar','udupi');
Insert into Library_programme values(13,'Nitte','Mangalore');
Insert into Library_programme values(14,'Manipal','Mangalore');

Insert into Book_copies values(10,1,10);
Insert into Book_copies values(9,1,12);
Insert into Book_copies values(5,2,13);
Insert into Book_copies values(3,3,14);
Insert into Book_copies values(12,4,11);

Insert into Card values(101);
Insert into Card values(102);
Insert into Card values(103);
Insert into Card values(104);
Insert into Card values(105);

Insert into Book_Lending values('2017-01-01','2017-06-01',1,10,101);
Insert into Book_Lending values('2017-11-02','2017-12-09',2,13,101);
Insert into Book_Lending values('2012-11-02','2012-12-09',3,14,101);
Insert into Book_Lending values('2015-11-02','2015-12-09',4,11,101);
Insert into Book_Lending values('2012-06-01','2012-07-11',1,10,104);

SELECT * FROM Book;
SELECT * FROM book_copies;
SELECT * FROM book_authors;
SELECT * FROM book_lending;
SELECT * FROM card;
SELECT * FROM publisher;
SELECT * FROM library_programme;

--Query 1)

Select B.Book_id,B.Title,B.Publisher_name,C.No_of_Copies,A.Author_name,L.Programme_id
From Book B,book_authors A,Book_copies C,Library_programme L 
Where B.Book_id=A.Book_id AND B.Book_id=C.Book_id AND L.Programme_id=C.Programme_id

--Query 2)

Select Card_no 
From Book_Lending 
Where Day_out Between '2017-01-01' AND '2017-06-01'
Group By Card_no Having Count(*)>3;

--Query 3)

Delete FROM Book Where Book_id=3;
SELECT * FROM Book;
SELECT * FROM book_copies;
SELECT * FROM book_authors;
SELECT * FROM book_lending;

--Query 4)

Create VIEW V_BOOKS As 
Select B.Book_id,B.Title,B.Publisher_name,C.No_of_Copies,A.Author_name,L.Programme_id
From Book B,book_authors A,Book_copies C,Library_programme L 
Where B.Book_id=A.Book_id AND B.Book_id=C.Book_id AND L.Programme_id=C.Programme_id

--Query 5)

Create VIEW V_publication As SELECT Pub_year From Book;
Select * from V_publication;