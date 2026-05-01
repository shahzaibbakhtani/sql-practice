Create database test;
use test;
create table Stu ( 
ID int primary key , name varchar(50) , city varchar(50), marks int not null, age int);
insert into Stu values 
(1,'Aarav','Delhi',85,20),(2,'Priya','Mumbai',92,22),
(3,'Ravi','Delhi',78,21),(4,'Sneha','Karachi',95,23),
(5,'Omar','Lahore',60,19),(6,'Lena','Mumbai',88,22),
(7,'Zara','Delhi',74,20),(8,'Ali','Karachi',91,24),
(9,'Sara','Lahore',55,18),(10,'Ahmed','Mumbai',83,21);

select * from Stu;
select name , marks from stu where city = "Delhi" order by marks desc;
select count(ID), city from stu group by city;
select  avg(marks) from Stu ;
select name from stu where marks > (select  avg(marks) from Stu) ;
create table course (enrollment_id INT PRIMARY KEY,
  student_id INT,
  course_name VARCHAR(50),
  fee INT
);
alter table  course 
change column student_id  ID int;
insert into course values 
(1,1,'SQL',5000),(2,2,'Python',6000),(3,3,'SQL',5000),
(4,4,'Java',7000),(5,5,'Java',7000),(6,6,'Python',6000),
(7,8,'SQL',5000),(8,9,'C++',4000),(9,10,'Python',6000),
(10,11,'SQL',5000);
select * from Stu inner join course on Stu.ID = course.ID;
select * from Stu left join course on Stu.ID = course.ID;
select city , avg(marks) from Stu group by city order by avg(marks)  desc limit 1;
select city , max(marks) from Stu group by city;
select ID from course;
select name from stu where ID not in (select ID from course);
alter table course 
change column course_name course varchar(50);
select course , count(ID) from course group by course order by count(ID) desc;
select name from stu where marks > 80  and ID in (
select ID from course where course = "SQL") ;
select city , sum(fee)  from stu inner join course on Stu.ID = course.ID group by city ;
use test;
select * from stu;
select * from course;
alter table course 
change column enrollment_id E_ID varchar(50);
select E_ID from course order by E_ID desc ;
alter table course 
add column Age int check (age > 18);
insert into course values (22,34, 'SQL',444000, 27);
select ID from course;
select  sum(marks), count(name) ,city from stu group by city;
select city ,max(marks) from stu group by city;
select ID from stu ;

select * from Stu inner  join course  on Stu.ID = course.ID;
select * from Stu where marks > 80;
SET SQL_SAFE_UPDATES = 0;
delete from stu where age < 20;
select age from stu;
alter table course 
modify ID varchar(50);
insert into course value (111,'zzz','Java' , 60000,77);
select ID from course;
alter table course 
drop column age;
select  avg(marks) from Stu;
select * from Stu inner join course on Stu.ID = course.ID 
where course.course = 'Python' and Stu.marks> (select avg(marks) from Stu);
select avg(marks) from stu;
select name , marks from stu where marks >(select avg(marks) from stu);
select name , ID from stu where ID not in ( select ID from course);
alter table course 
rename to Subject;
select * from stu;
select * from stu where marks > 91;
select * from stu order by marks desc limit 3;
--- Alisais -----
select city , avg(marks)  as avg from stu group by city ;
select city , avg(marks)as avg from stu group by city having avg > 70;
--- Unions ----
select * from subject;
alter table subject 
modify column ID int ; 
SET SQL_SAFE_UPDATES = 0;
update subject 
set ID = 31
where ID = 'zzz';
alter table subject 
modify column ID int;
select ID from stu 
union all
select Id from subject;
SELECT COUNT(*) 
FROM (
    SELECT ID FROM stu
    UNION ALL
    SELECT ID FROM subject
) AS combined;
select count(*) from (
select ID from stu
union 
select ID from subject) as one;
select  max(marks) from stu group by city;
select name , max(marks) group by city;
select name , city from stu where city = "Karachi";
select name , marks, 'old' as label from stu where age > 22 ;
select  * from stu ;
select * from  subject;
select * from stu inner join subject on stu.ID = subject.ID;
--- string function -----
select length("Shahzaib");
select name , length(name) from stu order by 2;
select name , upper(name) from stu order by 2;
select name , left(name, 4) from stu ;
select name , left(name, 4) , right(name,3) , substring(name, 1, 4) as "4 initials" from stu;
select name , replace(name , "a" , "z") from stu;
select locate ('a' , "Shahzaib");
select name , locate("A" , name) from stu;
select name , age ,concat(name, age) from stu;
select name ,
CASE
	when age < 22 then "Young" 
    when age between 22 and 24 then "Old"
end as "Age is just a number"
from stu;
select * from stu;
select name , marks ,
case 
	when marks > 90 then "A"
    when marks > 85 then "B"
	when marks between 70 and 85 then "C"
end as "Grades"
from stu;
select name , marks , 
case
	when marks > 90 then (marks +3)
    when marks > 85 then (marks + 2)
	when marks between 70 and 85 then (marks +1)
end as "upgrade"
from stu;
