Create Table Salesman
(
    Salesman_id Number(4) Primary Key,
    Name Varchar(20),
    City Varchar(20),
    Commission Varchar(20)
); 
Create table Customer
( 
    Customer_ID Number(4) Primary key,
    Customer_Name varchar(20),
    City varchar(20),
    Grade Number(3),
    Salesmain_ID references Salesman(Salesman_ID ) on delete cascade
);
Create table Orders
(
    Order_No Number(5) Primary key,
    Purchase_Amount number(10,2),
    Order_Date date,
    Customer_ID references Customer (Customer_ID) on delete cascade,
    Salesman_ID references Salesman (Salesman_ID) on delete cascade
)

Insert into Salesman values ('101','Richard','Los Angeles','18%');
Insert into Salesman values ('1000','George','New York','32%');
Insert into Salesman values ('110','Charles','Houstan','54%');
Insert into Salesman values ('122','Rowling','Philadelphia','46%');
Insert into Salesman values ('126','Kurt','Chicago','52%');
Insert into Salesman values ('132','Edwin','Phoenix','41%');

Insert into Customer values ('501', 'Smith', 'Los Angeles', '10', '101');
Insert into Customer values ('510', 'Brown', 'Atlanta', '14', '122' );
Insert into Customer values ('522', 'Lewis', 'Bangalore', '10', '132' );
Insert into Customer values ('534', 'Philips', 'Boston', '17', '101' );
Insert into Customer values ('550', 'Parker', 'Atlanta', '19', '126' );
Insert into Customer values ('543', 'Edward', 'Bangalore', '14', '110' );

Insert into Orders values ('1', '1000', '05-APR-08', '501', '1000');
Insert into Orders values ('2', '4000', '12-JUL-03', '522', '132');
Insert into Orders values ('3', '2500', '04-JUL-06', '550', '126');
Insert into Orders values ('5', '6000', '09-MAY-70', '522', '101');
Insert into Orders values ('6', '7000', '30-AUG-98', '550', '126');
Insert into Orders values ('7', '3400', '20-FEB-17', '501', '122');
Insert into Orders values ('8', '3500', '20-FEB-17', '501', '1000');

--Query 1)

Select Grade, count (Customer_id) 
From Customer 
Group By Grade Having Grade > (Select Avg(grade) From Customer Where City='Bangalore');

--Query 2)

Select S.Salesman_id, S.Name 
From Salesman S 
Where 1 < (Select Count (*) From Customer C Where C.Salesman_id=S.Salesman_id);

--Query 3)

Select Salesman.Salesman_id, Name, Cust_name, Commission From Salesman, Customer
Where Salesman.City = Customer.City
Union
Select Salesman_id, Name, 'No Match', Commission From Salesman Where city NOT IN
(Select City From Customer) ;

--Query 4)

Create View DemoView As 
Select B.Ord_date, A.Salesman_id, A.Name 
From Salesman A,Orders B
Where A.Salesman_id = B.Salesman_id And B.Purchase_amt = (select Max(Purchase_amt)
From Orders C Where C.Ord_date = B.Ord_date);
To display view,
Select * from DemoView;

--Query 5)

Delete From Salesman Where Salesman_id=1000;
Select * from Salesman;
Select * from Customer;
Select * from Orders;