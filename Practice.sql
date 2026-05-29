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
SELECT city, AVG(marks) 
FROM stu S JOIN subject Su 
ON S.ID = Su.ID 
GROUP BY city;

use cricket; 
select * from players;
select * from team;


select team_id, sum(runs) over(partition by team_id) total_runs_per_team , 
sum(wickets) over(partition by team_id) total_wickets_per_team from players;

select team_id ,sum(runs) , sum(wickets) from players group by team_id having sum(runs) > 20000;

select role , avg(runs) from players group by role;

select name , team_id , wickets from players where (team_id , wickets) in 
(select team_id ,max(wickets) from players group by team_id );

select role ,count(role) from players group by role having count(role) > 1;


select P.name , T.country from players P join team T on P.team_id = T.team_id;

select P.name , P.role ,T.coach from players P join team T on P.team_id = T.team_id; 

select T.country ,count(role) players_per_team from players P  join team T on P.team_id = T.team_id  group by P.team_id;

select P.name , T.world_cups from players P join team T on P.team_id = T.team_id where T.world_cups > 1;

select * from players as P inner join
(select team_id, world_cups from team where world_cups >1)T
on P.team_id = T.team_id;

select T.country , count(name) from players P join team T on P.team_id = T.team_id group by P.team_id; 

select T.country , P.name from players P right join team T on P.team_id = T.team_id;

select name from players where name like "G%"
union 
select coach from team where coach Like "G%";

select * from players where runs >(
select avg(runs) from players); 

select name , runs,
(select avg(runs) from players) as avg_runs,
runs - (select avg(runs) from players) as diff
 from players order by runs desc;

select name , runs, team_id from players
where runs > (select avg(runs) from players) and team_id in (select team_id from team where world_cups>1)
;

select name, team_id from players where team_id in (select team_id from team where country != "Pakistan");

select name , runs , rank() over(order by runs desc) ranking from players;

select team_id , name , runs , rank() over(partition by team_id order by runs desc) Rank_per_team from players;

select name , runs , sum(runs) over(order by runs desc) from players;

select team_id ,name , runs , avg(runs) over(partition by team_id) avg_per_team,
runs - avg(runs) over(partition by team_id) diff_per_team
 from players order by team_id , runs desc ;
 
select team_id,name , runs , sum(runs) over(partition by team_id order by runs rows between current row and unbounded following) 
running_total from players order by team_id, runs desc ; 
use cricket;
select name , runs , rank() over(order by runs desc) ranking from players;

-- Parctice 28/4/26 ---

use khan;
select * from school where marks > 85; 

select * from (
select name , course , marks , max(marks) over(partition by course) maximum from school)t
where marks = maximum;

select class , max(marks) from school group by class having max(marks) > 90 order by max(marks) ; 

select * from school limit 3,1;
use saler;

select * from customers;
set sql_safe_updates = 0;

select * from orders;

select * from customers C left join orders O on C.ID = O.cust_id where city = "Karachi";
select * from products;

select product_name ,category,price ,sum(price) over(order by price rows between unbounded preceding and current row) Total from products;

select sum(price) from products;

select product_name ,category,price ,sum(price) over(order by price rows between current row and unbounded following) from products;

use khan;
select * from school;

select * from (
select ID , name , city ,marks , rank() over(partition by city order by marks desc) Ranking from school)t
where Ranking = 1;

select ID , name , city ,marks , 
row_number() over(order by marks desc)  RN, 
rank() over(order by marks desc) R , 
dense_rank() over(order by marks desc) DR from school;

create temporary table selection(
select * , 
case 
	when Buc = 1 then "Super Star"
    When Buc = 2 then "Star"
    when Buc = 3 then "Work Hard"
end Categories from (
select ID , name , city ,marks, ntile(3) over(order by marks desc) Buc from school)t);

select * from selection where Categories = "Work Hard";

select * , marks - Average as diff from (
select name , marks , avg(marks) over() as Average  from school)t order by marks desc; 


use job;
select *, (Income - Nexty)/Income *100 as diff from 
(select name , Income , lead(Income) over(order by DOJ) Nexty from emp)t;

use khan;

select name , marks , (select avg(marks) from school)  Avg from school;
use cricket;
select * from players;

select * from (
select name ,runs , avg(runs) over() average from players)t
where runs > average
;

select * from players where team_id = 2;

select name , role , runs , avg(runs) over() from players where role = "Bowler";

select name , runs greater_than_bowler from players 
where runs > (select avg(runs) from players where role = "Bowler");

select * , rank() over(order by Run_by_team) ranking from(
select name , runs , sum(runs) over(partition by team_id) Run_by_team from players)t;

select * from (
select team_id , sum(runs) total, rank() over(order by sum(runs) desc) ranking from players group by team_id)t where ranking in (1,2);

SELECT * FROM players
WHERE team_id IN (
  SELECT team_id FROM (
    SELECT team_id, RANK() OVER(ORDER BY SUM(runs) DESC) ranking
    FROM players
    GROUP BY team_id
  ) t
  WHERE ranking IN (1, 2)
); 

select * from players P inner join (select * from team where world_cups>1)W on P.team_id = W.team_id;

select name , runs , team_id from players 
where runs > (select avg(runs) from players) and team_id in (select team_id from team where world_cups >1);
 
 
select coalesce(salary,"millonare") from stats;
 select name , coach_name , concat(name , " " , coalesce(coach_name,"Shahzaib")) from stats;
 

select count(ifnull(price, prev_day_closing)), count(price) from stocks;

select * from stocks;

update stocks 
set price = 190 
where price is null;


select price, HH ,ifnull(price,HH) HH_for_nulls from stocks;
select price , HH ,nullif(ifnull(price,HH), HH) nuller from stocks;

alter table stocks 
rename column company_name to name;

select name , ticker , price from stocks where price >
(select avg(price) from stocks);

SELECT name, ticker, price
FROM stocks s1
WHERE price > (
    SELECT AVG(price)
    FROM stocks s2
    WHERE s1.id <> s2.id
);

select * from (
select *, rank() over(order by price desc) ranking from stocks)t
where ranking = 2;

select * from stocks where price in (select price from stocks order by price desc limit 3);

with Average as
(select *, avg(price) over() avg from stocks)

select * from Average where price > avg;

create table top_three as(
with ranker as 
(select name , price , dense_rank() over(order by price desc ) ranking from stocks)

select * from ranker where ranking <4);

with stats as 
(select * , avg(price) over()avg , max(price) over() max , min(price) over() min from stocks)
select * from stats where price > avg and price < max;   

create temporary table stats_2 as (
select * from top_three where price > 599);

select * from stats_2;
drop table top_three;



