create database Aga;
use Aga;
create table school (
ID       INT           NOT NULL PRIMARY KEY,
    name     VARCHAR(100)  NOT NULL,
    course   VARCHAR(100)  NOT NULL,
    city     VARCHAR(100)  NOT NULL,
    marks    DECIMAL(5, 2) NOT NULL,
    class    VARCHAR(50)   NOT NULL
);

INSERT INTO school (ID, name, course, city, marks, class)
VALUES(1,  'Ali Hassan',      'English', 'Karachi', 88.50, 'Grade 10'),
    (2,  'Sara Ahmed',      'Maths',   'Lahore',  92.75, 'Grade 11'),
    (3,  'Usman Khan',      'Science', 'Multan',  76.00, 'Grade 9'),
    (4,  'Fatima Malik',    'English', 'Karachi', 95.25, 'Grade 12'),
    (5,  'Bilal Raza',      'Maths',   'Lahore',  81.00, 'Grade 11'),
    (6,  'Ayesha Siddiqui', 'Science', 'Multan',  89.50, 'Grade 12'),
    (7,  'Zain ul Abideen', 'English', 'Karachi', 73.75, 'Grade 10'),
    (8,  'Hira Noor',       'Maths',   'Lahore',  85.00, 'Grade 9'),
    (9,  'Omar Farooq',     'Science', 'Multan',  78.25, 'Grade 10'),
    (10, 'Nadia Iqbal',     'English', 'Karachi', 91.00, 'Grade 11');
  
select * from school;
set SQL_SAFE_UPDATES = 0;
delete from school;
select name , marks ,city, count(marks) over (partition by city) from school; 
select name , marks, course ,  rank () over (partition by course order by marks desc ) Ranking from school;

select name , city ,marks, max(marks) over (partition by city order by marks desc) total_per_city from school;

select city , count(marks) from school group by city order by count(marks) ;

select city ,name, rank () over (partition by city order by  marks desc ) from school;


 
select * ,count(name) over ()    -- total students --
from school;
select * , sum(marks) over()  sum_marks,
count(marks) over() total_students
from school order by marks desc ;

-- check duplicates --
select ID , count(ID) over (partition by ID) from school;

select name , marks , sum(marks) over (partition by  city) from school;

-- sum -- 
select name, course , sum(marks) over(partition by course) total_per_course,
sum(marks) over() Total from school;

select name , marks ,sum(marks) over() from school order by marks desc;

select name , marks , sum(marks) over()  as Total, 
round(marks/sum(marks) over() * 100,2) Percentage_per_mark
from school;
 
 -- Average --
 
 select city ,course, marks, 
 count(name) over(partition by course)total_students_course,
 sum(marks) over(partition by course) total_marks_per_course,
 avg(marks) over(partition by course) as Average_per_course 
from school order by course, marks desc ;
 
 select course ,marks, sum(marks) over(partition by course),
 marks/ sum(marks) over(partition by course) from school;

-- marks greater than avg marks --
 select * from (
 select name, marks, avg(marks) over() avg_marks
 from school)t where marks > avg_marks;

-- min/max--

select city, marks, max(marks) over(partition by city) Max_per_city,
min(marks) over(partition by city) min_per_city ,
max(marks) over() highest,
min(marks) over() lowest
from school order by city , marks desc;

select max(marks), min(marks) from school;

-- hightest --

select * from (
select name, marks , max(marks) over() high from school)t where marks = high;

-- deviation -- 

select name, marks , max(marks) over() , 
min(marks) over(),
marks - min(marks) over() deviation_from_min,
marks - max(marks) over() deviation_from_max
from school order by marks desc;

-- Moving Average -- 

select name, marks, avg(marks) over(order by marks rows between 2 preceding and current row) as 3_day_MA from school;

select name,course, marks , avg(marks) over(partition by course order by marks) MA_per_course from  school;

select name,course, marks , avg(marks) over(partition by course order by marks rows between 1 preceding and current row) MA_per_course from  school;

use aga;
select * from school;

select name , course, sum(marks)  over(partition by city) from school;

select name, course, marks, avg(marks) over(partition by course) avg_per_course, 
round(marks - avg(marks) over(partition by course),2) differnce
from school;
 
select name , marks, sum(marks) over(partition by course) Total ,
round((marks / sum(marks) over(partition by course))*100,2) percent from school order by marks desc;

select name, marks , course , city , sum(marks) over(partition by course) total_per_course,
sum(marks) over(partition by city) total_per_city from school;

 
select name, course, marks, max(marks) over(partition by course) Max_marks,
min(marks) over(partition by course) Min_marks from school;
 
select name, course, marks, count(*) over(partition by course) from school;
 
select name, course, marks, avg(marks) over(partition by course) Average, 
case 
	when marks > avg(marks) over(partition by course) then "Above Average"
    when marks < avg(marks) over(partition by course) then "Below Average"
    else "Average"
    end as "Performane" from school order by course, marks desc;

 use khan;
 select * from school;
 
 select name, course , marks , rank() over(partition by course order by marks desc) ranking from school;
 
 select city ,name , marks , avg(marks) over(partition by city) Avg_per_city from school;
 
 select city ,name , marks , sum(marks) over(partition by city order by ID) running_total from school;
 
select * from (
select course ,name , marks , avg(marks) over(partition by course) average from school)t
where marks > average
;
select course ,name , marks , lead(marks) over(partition by course) from school;
 

 
 
 
 
 
 
 
 
 
 
 
 
 
 