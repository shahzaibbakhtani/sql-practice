--- Windows Function ----
create database windows;
use windows;
create table A ( salary int , city varchar(50) );
INSERT INTO A VALUES
(50000, 'Karachi'),
(60000, 'Karachi'),
(70000, 'Karachi'),
(45000, 'Lahore'),
(55000, 'Lahore'),
(65000, 'Lahore'),
(80000, 'Islamabad'),
(90000, 'Islamabad'),
(100000, 'Islamabad');
select * from A;
select salary , city,
sum(salary) over( partition by city order by salary) as total, 
avg(salary) over(partition by city order by salary) as average,
max(salary) over (partition by city ) as Max
from A; 

-- Window functions-- 
-- Window functions-- 


create database W;
use W;
CREATE TABLE employees (
  id         INT,
  name       VARCHAR(50),
  department VARCHAR(50),
  salary     INT,
  hire_year  INT
);

INSERT INTO employees VALUES
  (1,  'Ali',     'Engineering', 90000, 2019),
  (2,  'Sara',    'Engineering', 95000, 2020),
  (3,  'Omar',    'Engineering', 85000, 2021),
  (4,  'Nadia',   'Marketing',   70000, 2018),
  (5,  'Khalid',  'Marketing',   75000, 2020),
  (6,  'Hana',    'Marketing',   68000, 2022),
  (7,  'Zain',    'Finance',     80000, 2017),
  (8,  'Lina',    'Finance',     88000, 2019),
  (9,  'Tariq',   'Finance',     92000, 2021),
  (10, 'Mona',    'Finance',     78000, 2023);

alter table employees
rename column hire_year to year;

select * from employees;
select department,sum(salary) Total from employees group by department;

select name , department, salary, sum(salary) over(partition by department ) as Total_salary_per_department
from employees;
use W;
select * from employees;
select name,department , salary ,sum(salary) over (partition by department) as Total from employees;
select name , year ,salary, max(salary) over(partition by year) as Per_Year from employees;
select name , sum(salary) over() from employees;

--- Multiple factors can be use -- 

select name , department ,salary, 
sum(salary) over(partition by department) as Per_Dept,
sum(salary) over() as Total_salary
from employees;

select name , department ,salary, year,
sum(salary) over(partition by department) as Per_Dept,
sum(salary) over(partition by department , year ) as Per_Dept_Per_year
from employees order by year;

alter table employees
rename column department to dept;

--- Order by-- 
select name , salary, dept, rank() over (partition by dept order by salary desc ) as dept_winners from employees;

---- Frame clause ----  
select name , dept , salary , sum(salary) over (partition by dept order by salary desc
rows between current row and 1 following)  as total_sales from employees;

select dept, count(dept) from employees group by dept;

select name , dept , salary , sum(salary) over (partition by dept order by salary desc
rows between 2 preceding and current row)  as total_sales from employees;
use W;
select * from employees;
rename table 
employees to emp;
select name , dept,salary ,year , sum(salary) over(partition by dept order by salary desc ) from emp where year in (2019,2020) ;
select * from emp;

select dept ,  sum(salary),
rank() over(order by sum(salary) desc) ranking 
from emp
group by dept  ;

select name , dept , count(salary) over (partition by  dept) as count_per_department from emp;
select count(*) from emp;
