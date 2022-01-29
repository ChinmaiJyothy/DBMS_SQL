Create Table Student
(
    USN Varchar(10) Primary Key ,
    SName Varchar(25),
    Address Varchar(25),
    Phone Number(10),
    Gender Varchar(1)
);
Create Table Semsec
(
    SSID Varchar(5) Primary Key,
    Sem Number(2),
    Sec Varchar(1)
);
Create Table Class
(
    USN References Student(USN) On Delete Cascade,
    SSID References Semsec(SSID) On Delete Cascade,
    Primary Key (USN,SSID)
);
Create Table Subject
(
    SubCode Varchar(8) Primary Key,
    Title Varchar(20),
    Sem Number(2),
    Credits Number(2)
);
Create Table IAMarks
(
    USN References Student(USN) On Delete Cascade,
    SubCode References Subject(SubCode) On Delete Cascade,
    SSID References Semsec(SSID) On Delete Cascade,
    Test1 Number(2),
    Test2 Number(2),
    Test3 Number(2),
    FinalIA Number(2),
    Primary Key (USN, SubCode, SSID)
);

Insert into Student values ('1GA17CS082', 'Sandhya', 'Bangalore', 8902013245, 'F');
Insert into Student values ('1GA17CS093', 'Trilok', 'Bangalore', 7712312359, 'M');
Insert into Student values ('1GA18CS032', 'Gagan', 'Mangalore', 9902013248, 'M');
Insert into Student values ('1GA18CS103', 'Sahithi', 'Shimoga', 7712311099, 'F');
Insert into Student values ('1GA19CS025', 'Dhanya', 'Tumkur', 8900211201, 'F');
Insert into Student values ('1GA15CS091', 'Vikas', 'Mangalore', 9900232201, 'M');
Insert into Student values ('1GA19CS011', 'Anand', 'Shimoga', 8912415242, 'M');

Insert into Semsec values ('CS1A', 1, 'A');
Insert into Semsec values ('CS1B', 1, 'B');
Insert into Semsec values ('CS2A', 2, 'A');
Insert into Semsec values ('CS2B', 2, 'B');
Insert into Semsec values ('CS3A', 3, 'A');
Insert into Semsec values ('CS3B', 3, 'B');
Insert into Semsec values ('CS4A', 4, 'A');
Insert into Semsec values ('CS4B', 4, 'B');
Insert into Semsec values ('CS4C', 4, 'C');
Insert into Semsec values ('CS5A', 5, 'A');
Insert into Semsec values ('CS5B', 5, 'B');
Insert into Semsec values ('CS6A', 6, 'A');
Insert into Semsec values ('CS6B', 6, 'B');
Insert into Semsec values ('CS7A', 7, 'A');
Insert into Semsec values ('CS7B', 7, 'B');
Insert into Semsec values ('CS8A', 8, 'A');
Insert into Semsec values ('CS8B', 8, 'B');
Insert into Semsec values ('CS8C', 8, 'C');

Insert into Class values ('1GA17CS082', 'CS8B');
Insert into Class values ('1GA17CS093', 'CS8C');
Insert into Class values ('1GA18CS032', 'CS5A');
Insert into Class values ('1GA18CS103', 'CS5A');
Insert into Class values ('1GA19CS025', 'CS3B');
Insert into Class values ('1GA15CS091', 'CS3B');
Insert into Class values ('1GA19CS011', 'CS4C');

Insert into Subject values ('17CS81', 'IOT', 8, 4);
Insert into Subject values ('17CS82', 'Big Data', 8,4);
Insert into Subject values ('17CS83', 'SMS', 8, 3);
Insert into Subject values ('17CS71', 'Web Tech', 7, 4);
Insert into Subject values ('17CS72', 'ACA', 7, 4);
Insert into Subject values ('17CS73', 'ML', 7, 4);
Insert into Subject values ('17CS61', 'CNS', 6, 4);
Insert into Subject values ('17CS62', 'CG', 6, 4);
Insert into Subject values ('17CS63', 'SS and CD', 6, 4);
Insert into Subject values ('18CS51', 'M and E', 5, 3);
Insert into Subject values ('18CS52', 'CN', 5, 4);
Insert into Subject values ('18CS53', 'DBMS', 5, 4);
Insert into Subject values ('18CS42', 'DAA', 4, 4);
Insert into Subject values ('18CS43', 'OOC', 4, 3);
Insert into Subject values ('18CS32', 'DS', 3, 4);
Insert into Subject values ('18CS33', 'DMS', 3, 3);

Insert into IAMarks values ('1GA17CS093', '17CS81', 'CS8C',14, 15, 20, NULL);
Insert into IAMarks values ('1GA17CS093', '17CS82', 'CS8C',16, 14, 20, NULL);
Insert into IAMarks values ('1GA17CS093', '17CS83', 'CS8C',17, 17, 19, NULL);
Insert into IAMarks values ('1GA18CS103', '18CS51', 'CS5A',20, 18, 19, NULL);
Insert into IAMarks values ('1GA15CS091', '18CS32', 'CS3B',16, 19, 20, NULL);
Insert into IAMarks values ('1GA15CS091', '18CS33', 'CS3B',13, 16, 20, NULL);
Insert into IAMarks values ('1GA19CS011', '18CS42', 'CS4C',18, 19, 19, NULL);
Insert into IAMarks values ('1GA19CS011', '18CS43', 'CS4C',19, 18, 19, NULL);

--Query 1)

select S.*,SS.Sem, SS.sec 
from Student S,Semsec ss, Class C 
where S.usn=C.usn and SS.SSID=C.SSID AND SS.Sem=4 AND SS.Sec='C';

--Query 2)

select ss.sem, ss.sec, s.gender, count(s.gender) 
from student s,semsec ss,class c 
where S.usn=c.usn and ss.ssid=c.ssid 
group by ss.sem,ss.sec,s.gender 
order by sem;

--Query 3)

create view test_1 view as select test1, subcode from iamarks where
usn='1ga15cs091';
select * from test1_view;

--Query 4)

create or replace procedure avgmarks is
cursor c_iamarks is
select
greatest(test1,test2) as a,
greatest(test1,test3) as b,
greatest(test3,test2) as c
from iamarks
where finalia is
null for update;
c_a number;
c_b number;
c_c number;
c_sm number;
c_av number;
begin
    open c_iamarks;
        loop
            fetch c_iamarks into c_a, c_b, c_c;
            exit when c_iamarks%notfound;
            if (c_a!=c_b)
                then
                c_sm:=c_a+c_b;
                else
                c_sm:=c_a+c_c;
            end if;
            c_av:=c_sm/2;
            dbms_output.put_line('Average = '||c_av);
            update iamarks set finalia = c_av
            where current of c_iamarks;
        end loop;
    close c_iamarks;
end;

begin
avgmarks;
end;

select * from iamarks;

--Query 5)

select s.usn, s.sname, s.address, s.phone, s.gender,
(
case
    when ia.finalia between 17 and 20 then 'Outstanding'
    when ia.finalia between 12 and 16 then 'Average'
    else 'Weak'
end
)
as category
from student s, semsec ss, iamarks ia, subject sub where s.usn = ia.usn and ss.ssid=ia.ssid
and sub.subcode = ia.subcode and sub.sem = 8;