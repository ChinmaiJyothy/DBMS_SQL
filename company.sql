create table Department
(
    DNo Varchar(20) Primary Key,
    Dname varchar(20),
    Mgrstartdate Date
);

create table Employee
(
    SSN Varchar(20) Primary Key,
    Fname Varchar(20) ,
    Lname Varchar(20) ,
    Address Varchar(20) ,
    Gender Varchar(1) ,
    Salary Integer,
    SuperSSN references Employee(SSN) On Delete Cascade,
    DNo References Department(DNo) On Delete Cascade
);

Alter Table Department
Add MgrSSN References Employee(SSN) On Delete Cascade;

create table Dlocation
(
    Dloc varchar(20),
    DNo References Department(Dno) on delete cascade,
    Primary Key(DNo,Dloc)
);

create table Project
(
    PNo Integer Primary Key,
    Pname varchar(20),
    Plocation varchar(20),
    DNo References Department(DNo) On Delete Cascade
);

create table Works_On
(
    Hours Number(2),
    SSN references Employee(SSN) On Delete Cascade,
    PNo References Project(PNo) on delete cascade,
    Primary key(SSN,PNo)
);


insert into Employee values('GATECE01','Mohan','Kumar','Bangalore','M',450000,NULL,NULL);
insert into Employee values('GATCSE01','Jagan','Rao','Bangalore','M',500000,NULL,NULL);
insert into Employee values('GATCSE02','Hemanth','Bhat','Bangalore','M',700000,NULL,NULL);
insert into Employee values('GATCSE03','Eshwar','Hegde','Mysore','M',500000,NULL,NULL);
insert into Employee values('GATCSE04','Pavan','Malya','Mangalore','M',650000,NULL,NULL);
insert into Employee values('GATCSE05','Girish','Kumar','Bangalore','M',450000,NULL,NULL);
insert into Employee values('GATCSE06','Neha','K','Mangalore','F',800000,NULL,NULL);
insert into Employee values('GATACC01','Sahana','Kumar','Mysore','F',350000,NULL,NULL);
insert into Employee values('GATACC02','Santhosh','Kumar','Bangalore','M',300000,NULL,NULL);
insert into Employee values('GATISE01','Kavya','M','Mangalore','F',600000,NULL,NULL);
insert into Employee values('GATIT01','Nagesh','H','Bangalore','M',500000,NULL,NULL);

insert into Department values(1,'Accounts','01-JAN-17','GATACC01');
insert into Department values(2,'IT','01-AUG-16','GATIT01');
insert into Department values(3,'ECE','01-JUN-08','GATECE01');
insert into Department values(4,'ISE','01-AUG-15','GATISE01');
insert into Department values(5,'CSE','01-JUN-02','GATCSE05');

UPDATE Employee set DNo=3 where SSN='GATECE01';
UPDATE Employee set DNo=3 where SSN='GATCSE01';
UPDATE Employee set DNo=1 where SSN='GATACC01';
UPDATE Employee set DNo=1 where SSN='GATACC02';
UPDATE Employee set DNo=4 where SSN='GATISE01';
UPDATE Employee set DNo=2 where SSN='GATIT01';


UPDATE Employee set SuperSSN='GATCSE05', DNo=5 where SSN='GATCSE01';
UPDATE Employee set SuperSSN='GATCSE03', DNo=5 where SSN='GATCSE02';
UPDATE Employee set SuperSSN='GATCSE04', DNo=5 where SSN='GATCSE03';
UPDATE Employee set SuperSSN='GATCSE05', DNo=5 where SSN='GATCSE04';
UPDATE Employee set SuperSSN='GATCSE06', DNo=5 where SSN='GATCSE05';



insert into Project values(100,'IOT','Bangalore',5);
insert into Project values(101,'Cloud','Bangalore',5);
insert into Project values(102,'Big Data','Mangalore',5);
insert into Project values(103,'Machine Learning','Bangalore',3);
insert into Project values(104,'Open Stack','Bangalore',4);
insert into Project values(105,'Banking','Mangalore',2);

insert into Works_On values(4,'GATCSE01',100);
insert into Works_On values(6,'GATCSE01',101);
insert into Works_On values(8,'GATCSE01',102);
insert into Works_On values(10,'GATCSE05',100);
insert into Works_On values(3,'GATACC01',100);
insert into Works_On values(5,'GATISE01',103);
insert into Works_On values(4,'GATIT01',104);


--Query 1)

Select Distinct P.Pno 
From Project P,Department D,Employee E1 
where E1.Dno=D.Dno and D.Mgrssn=E1.Ssn and E1.Lname='Kumar'
Union
select Distinct P1.Pno 
From Project P1,Works_On W,Employee E2 
where P1.Pno=W.Pno and E2.ssn=W.Ssn and E2.Lname='Kumar'

--Query 2)

Select E.Fname,E.Lname,1.1*E.Salary 
As Incr_Sal 
From Employee E,Works_On W,Project P 
where E.SSN=W.SSN and W.Pno=P.Pno and P.Pname='IOT';

--Query 3)
Select Sum(E.Salary),Max(E.Salary),Min(E.Salary),Avg(E.Salary) 
From Employee E,Department D 
where E.Dno=D.Dno and D.Dname='Accounts';


--Query 4)
Select E.Fname,E.Lname 
from Employee E
where Not Exists 
(
    Select Pno From Project Where Dno=5
    And Pno NOT IN(Select Pno From Works_On where E.SSN=SSN)
);

--Query 5)
Select D.Dno,count(*) 
from Department D,Employee E 
where D.Dno=E.Dno and E.Salary>600000 and 
D.Dno IN (select E1.Dno from Employee E1 Group By E1.Dno Having Count(*)>5)
Group By D.Dno;