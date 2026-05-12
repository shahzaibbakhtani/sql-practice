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

select * from school;

select name ,marks , avg(marks) over(partition by course) from school order by marks desc ;

select name , city , marks, rank() over(partition by city order by marks ) from school;


select * from(
select name , course ,marks, avg(marks) over(partition by course ) avg_per_course 
from school)t
where marks > avg_per_course  order by course , marks desc  ;

select * from (
select name , course , marks, rank() over(partition by course order by marks desc) rank_per_course from school)t
where rank_per_course <= 2
;

select * from (
select name , city, marks , avg(marks) over(partition by city ) avg_per_city from school order by city, marks desc)t
where marks > avg_per_city
;
select  distinct  course ,max_per_course, min_per_course, 
    max_per_course - min_per_course AS difference from (
select name, course, marks , max(marks) over(partition by course ) max_per_course,
min(marks) over(partition by course) min_per_course
from school order by course,marks desc) t
where max_per_course - min_per_course > 15
;
use khan;


create table sale (
Em_ID int, name varchar(30), Position VARCHAR(50),
    City VARCHAR(50),
    Month VARCHAR(20),
    Amount INT
);

truncate table sales;
alter table sales
rename column Date to S_date;
alter table sales
modify column S_date Date;


-- Value Functions -- 


INSERT INTO Sales VALUES
(101, 'Shahzaib', 'Manager', 'Karachi', '2024-01-01', 1000),
(101, 'Shahzaib', 'Manager', 'Karachi', '2024-02-01', 1500),
(101, 'Shahzaib', 'Manager', 'Karachi', '2024-03-01', 1200),
(101, 'Shahzaib', 'Manager', 'Karachi', '2024-04-01', 1800),
(101, 'Shahzaib', 'Manager', 'Karachi', '2024-05-01', 900),
(101, 'Shahzaib', 'Manager', 'Karachi', '2024-06-01', 2100),
(101, 'Shahzaib', 'Manager', 'Karachi', '2024-07-01', 1300),
(102, 'Asad', 'Analyst', 'Lahore', '2024-01-01', 2000),
(102, 'Asad', 'Analyst', 'Lahore', '2024-02-01', 1700),
(102, 'Asad', 'Analyst', 'Lahore', '2024-03-01', 2200),
(102, 'Asad', 'Analyst', 'Lahore', '2024-04-01', 1900),
(102, 'Asad', 'Analyst', 'Lahore', '2024-05-01', 2500),
(102, 'Asad', 'Analyst', 'Lahore', '2024-06-01', 2300),
(102, 'Asad', 'Analyst', 'Lahore', '2024-07-01', 1800),
(103, 'Asif', 'Executive', 'Islamabad', '2024-01-01', 1600),
(103, 'Asif', 'Executive', 'Islamabad', '2024-02-01', 1300),
(103, 'Asif', 'Executive', 'Islamabad', '2024-03-01', 1900),
(103, 'Asif', 'Executive', 'Islamabad', '2024-04-01', 2100),
(103, 'Asif', 'Executive', 'Islamabad', '2024-05-01', 1750),
(103, 'Asif', 'Executive', 'Islamabad', '2024-06-01', 2400);

select * from sales;



select city , sum(Amount) from sale group by city having sum(Amount) > 1000;

set SQL_SAFE_UPDATES = 0;
alter table sale
rename to sales;
select * from sales;
select city,month, amount , lead(amount,1,0) over(order by month) mom_comparsions from sales;

select * , 
round((current_month_sales - previous_month_sales)/previous_month_sales  *100,2) as Mom_diff
from 
(select  month(S_date) as Order_Month, sum(Amount) current_month_sales , 
lag(sum(Amount),1,0) over(order by month(S_date)) as previous_month_sales
from sales group by Order_Month)t;


select *,
datediff (NextDate ,CurrDate) as DateDiff, 

avg(DateDiff) as avgerage
 from
(select Em_ID, S_date CurrDate,
lead(S_date) over(partition by Em_Id order by S_date) NextDate
 from sales)t ;

select S_date ,Em_ID, Amount , lead(Amount) over(partition by Em_ID order by S_date ) next_month_sales from sales;

select *, current - next_month_sales  as mom_diff from(
select S_date ,Em_ID,Amount as current, lead(Amount) over(partition by Em_ID order by S_date) next_month_sales from sales)t;


select Em_ID , Amount , lead(Amount) over(partition by Em_ID order by S_date) next_month_sales, lag(Amount) over(partition by Em_ID order by S_date) previous_month_sales from sales;

select * from(
Select Em_ID , Amount as curr_sales, 
lag(Amount) over(partition by Em_ID order by S_date) previous_sales

from sales)t 
where curr_sales > previous_sales;


select * , next_month - curr_sales as next_minus_current,
curr_sales - previous_month  as current_minus_previuos from
(select Em_ID, Amount curr_sales, 
lead(Amount) over(partition by Em_ID order by S_date) next_month,
lag(Amount) over(partition by Em_Id order by S_date) previous_month 
from sales)t;

select * , round((curr_sales - previous_sales)/ previous_sales * 100,2) as percent_change from (
select S_date, Em_ID , Amount as curr_sales , lag(Amount) over(partition by Em_ID order by S_date) as previous_sales from sales)t;

select Em_ID , month(S_date) as Month_num , curr_sales, previous_sales, next_sales from (
select S_date, Em_ID , Amount as curr_sales , lag(Amount) over(partition by Em_ID order by S_date) as previous_sales,
lead(Amount) over (partition by Em_ID order by S_date) as next_sales
 from sales)t

where curr_sales < previous_sales and curr_sales < next_sales
;
use khan; 

use school;
-- Practice session -- 

use khan;
select * from school;

select name , course , marks , rank() over(order by marks desc) Ranking ,
row_number() over(order by marks desc) row_ranking,
dense_rank() over(order by marks desc) dense_ranking
from school;

select course , name , marks , rank() over(partition by course order by marks desc) course_wise_ranking from school;

select * from (
select city , sum(marks), row_number() over(order by sum(marks) desc) total_marks_rank from school group by city)t
where total_marks_rank in (1,3)
;


select row_number() over(order by marks) unique_ID
,ID from school;

select * from school_dup;

select * from (
select row_number() over() Unique_ID , ID , name from school_dup)t
where Unique_ID > 15
;


select name , categories from (
select * , 
CASE 
	when 5_buckets = 1 then "High Achiver"
    when 5_buckets = 2 then "Medium Achiver"
    when 5_buckets = 3 then "Medium - low"
    when 5_buckets = 4 then "Low"
    when 5_buckets = 5 then "Very Low"
END as categories from (
select name , marks , ntile(5) over(order by marks desc) 5_buckets from school)t)t where categories = "High Achiver" ;



