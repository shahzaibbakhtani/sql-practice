create database College;
use college;

create table student (
ID int primary key,
name varchar(50),
marks int not null,
city varchar(20),
grade varchar(1)
);

INSERT INTO student VALUES
(101, "Anil", 78, "Pune", "C"),
(102, "Bhumika", 93, "Mumbai", "A"),
(103, "Chetan", 85, "Mumbai", "B"),
(104, "Dhruv", 96, "Delhi", "A"),
(105, "Emanuel", 12, "Delhi", "F"),
(106, "Farah", 82, "Delhi", "B"),
(107, "Gaurav", 71, "Mumbai", "C"),
(108, "Hina", 88, "Pune", "B"),
(109, "Ishaan", 45, "Delhi", "D"),
(110, "Jaya", 99, "Mumbai", "A");

select * from student;
select name,grade from student;
select distinct city from student;
select * from student where marks > 70;
select * from student where city = "mumbai" and marks > 75;

select * from student where marks+ 20 = 100;
select * from student where marks = 12;
select * from student where marks between 80 and 90;
select * from student where city in ("Mumbai" ,"Karachi");
select * from student where city not in ("Mumbai", "Dheli");
select * from student where marks > 79 limit 3;
select * from student  order by marks DESC limit 3;
select avg(marks) from student;
select marks from student;
select city, count(name) from student group by city;
select city, avg(marks) from student group by city order by avg(marks) DESC;
CREATE TABLE Payments (
    customer_id INT PRIMARY KEY,
    customer VARCHAR(50),
    mode VARCHAR(50),
    city VARCHAR(50)
);
INSERT INTO Payments (customer_id, customer, mode, city) VALUES
(101, 'Olivia Barrett', 'Netbanking', 'Portland'),
(102, 'Ethan Sinclair', 'Credit Card', 'Miami'),
(103, 'Maya Hernandez', 'Credit Card', 'Seattle'),
(104, 'Liam Donovan', 'Netbanking', 'Denver'),
(105, 'Sophia Nguyen', 'Credit Card', 'New Orleans'),
(106, 'Caleb Foster', 'Debit Card', 'Minneapolis'),
(107, 'Ava Patel', 'Debit Card', 'Phoenix'),
(108, 'Lucas Carter', 'Netbanking', 'Boston'),
(109, 'Isabella Martinez', 'Netbanking', 'Nashville'),
(110, 'Noah Wilson', 'Credit Card', 'Austin'),
(111, 'Emma Garcia', 'Debit Card', 'Chicago'),
(112, 'Mason Reed', 'Netbanking', 'Atlanta'),
(113, 'Luna Love', 'Credit Card', 'Dallas');
select * from Payments;
select mode ,count(customer) from Payments group by mode;
select * from student;
select grade, count(name) from student group by grade order by grade;
select city, count(name)  from student group by city having max(marks)> 90;
select marks  from student where marks >= 90;
select marks from student;
set SQL_SAFE_UPDATES = 0;
update student set grade  = "O"  where grade = "A";
select grade from student group by grade;

update student set marks = 82 where ID = 105;
select * from student;

