create database khan;
use khan;
create table school (
ID       INT           NOT NULL PRIMARY KEY,
    name     VARCHAR(100)  NOT NULL,
    course   VARCHAR(100)  NOT NULL,
    city     VARCHAR(100)  NOT NULL,
    marks    DECIMAL(5, 2) NOT NULL,
    class    VARCHAR(50)   NOT NULL
);

insert into school 
VALUES(1,  'Ali Hassan',      'English', 'Karachi', 88.50, 'Grade 10'),
    (2,  'Sara Ahmed',      'Maths',   'Lahore',  92.75, 'Grade 11'),
    (3,  'Usman Khan',      'Science', 'Multan',  76.00, 'Grade 9'),
    (4,  'Fatima Malik',    'English', 'Karachi', 95.25, 'Grade 12'),
    (5,  'Bilal Raza',      'Maths',   'Lahore',  81.00, 'Grade 11'),
    (6,  'Ayesha Siddiqui', 'Science', 'Multan',  89.50, 'Grade 12'),
    (7,  'Zain ul Abideen', 'English', 'Karachi', 73.75, 'Grade 10'),
    (8,  'Hira Noor',       'Maths',   'Lahore',  85.00, 'Grade 9'),
    (9,  'Omar Farooq',     'Science', 'Multan',  78.25, 'Grade 10'),
    (10, 'Nadia Iqbal',     'English', 'Karachi', 91.00, 'Grade 11'),
    (11, 'Hamza Tariq',     'History', 'Karachi', 82.50, 'Grade 10'),
	(12, 'Mariam Ali',      'History', 'Lahore',  90.00, 'Grade 12'),
	(13, 'Saad Qureshi',    'History', 'Multan',  74.25, 'Grade 9'),
	(14, 'Noor Fatima',     'History', 'Karachi', 88.75, 'Grade 11'),
	(15, 'Ahmed Raza',      'History', 'Lahore',  79.50, 'Grade 10');
    

set SQL_SAFE_UPDATES = 0;

update school
set marks = 90 where ID = 11;
select * from school where ID = 11;
select course , count(course) from school group by course;

select name, course, marks, row_number() over(order by marks desc) as Unique_Ranking,
rank() over(order by marks desc) as Real_rank, 
dense_rank() over(order by marks desc) as dense_ranking
from school;

-- top students from each course -- 
select name, course, marks, dense_rank() over(partition by course order by marks desc) rank_per_course from school;

select * from(
select name, course, marks, dense_rank() over(partition by course order by marks desc) rank_per_course from school)t where rank_per_course =1;

-- loweet marks of school based on cities (only want lowest two) --

select * from (
select city, sum(marks), 
row_number() over(order by sum(marks)) City_total_ranking
from school group by city)t where City_total_ranking in (1,2);

-- creating unique ID --

select * , row_number() over(order by ID) from school;
SELECT ROW_NUMBER() OVER(ORDER BY ID) AS unique_id, ID, name, course, city, marks, class FROM school;
use khan;
select * from school;

CREATE TABLE school_dup (
    id INT,
    name VARCHAR(50),
    course VARCHAR(20),
    city VARCHAR(20),
    marks DECIMAL(5,2),
    grade VARCHAR(20)
);

INSERT INTO school_dup
SELECT * FROM school;

select * from school_dup;
insert into school_dup values
(1, 'Rehan Ali',    'History', 'Karachi', 85.00, 'Grade 10'),
(2, 'Sana Khan',    'Maths',   'Lahore',  91.00, 'Grade 11'),
(3, 'Imran Sheikh', 'Science', 'Multan',  77.50, 'Grade 9');

select * from school_dup order by ID;

select ID,name, marks, rank() over(order by marks) from school_dup;

select * from (
select  row_number() over(partition by ID order by marks desc) duplicates ,ID , marks   from school_dup)t
where duplicates >1;

select count(*) from school;

select name, ID, marks ,  ntile(5) over(order by marks desc) 5_buckets,
ntile(4) over(order by marks desc) 4_buckets
 from school;
use khan;
--  hig, medium , low marks --
select * , 
case 
	when tile = 1 then "A Grade"
    when tile = 2 then "B Grade"
    when tile = 3 then "C Grade" 
    end as category
    from(
select ID, name, marks, ntile(3) over(order by marks desc) as tile
from school)t ;
 
select ntile(3) over(order by marks desc) as segment , school.*  from school;

-- Top students -- 

select * from (
select name , marks, round(cume_dist() over(order by marks desc),2) cd from school)t where cd <= 0.2;




