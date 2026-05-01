Create database company;
use company;
create table sales (
ID int primary key, 
name varchar(20),
sales int not null,
bonus int ,
position varchar(15)
); 
insert into sales values 
(1, 'Ali Khan', 50000, 5000, 'Manager'),
(2, 'Sara Ahmed', 42000, 4200, 'Executive'),
(3, 'Usman Tariq', 38000, 3800, 'Executive'),
(4, 'Ayesha Noor', 60000, 7000, 'Manager'),
(5, 'Hamza Ali', 30000, 2500, 'Associate'),
(6, 'Zain Malik', 45000, 4500, 'Executive'),
(7, 'Hira Shah', 52000, 5200, 'Manager'),
(8, 'Bilal Raza', 28000, 2000, 'Associate'),
(9, 'Fatima Khan', 47000, 4700, 'Executive'),
(10, 'Danish Iqbal', 35000, 3000, 'Associate'),
(11, 'Noor Ali', 62000, 8000, 'Senior Manager'),
(12, 'Saad Qureshi', 41000, 4100, 'Executive'),
(13, 'Mehwish Ali', 39000, 3900, 'Executive'),
(14, 'Farhan Sheikh', 27000, 1800, 'Associate'),
(15, 'Rabia Aslam', 55000, 6000, 'Manager');

select * from sales;
select * from sales where sales <= 50000;
select * from sales where sales < 50000 order by sales ;
SELECT name, sales
FROM sales;
select position, sum(sales) from sales group by position order by sum(sales) desc ;
select position , sum(bonus) from sales group by position order by sum(bonus) desc;
SELECT *
FROM sales
WHERE position = 'Senior Manager';
set SQL_SAFE_UPDATES = 0;
update sales set bonus = 100000 where position = "Senior Manager";
select * from sales;
SELECT position, SUM(sales) AS total_sales
FROM sales
GROUP BY position
ORDER BY total_sales;
select position from sales where position = "Senior manager";
select * from sales;
update sales set sales = sales + 5000;
delete from sales where bonus < 2000;
select * from sales;

CREATE DATABASE company;
USE company;
create table sales (
ID int primary key, 
name varchar(20),
sales int not null,
bonus int ,
position varchar(15)
); 
-- Parent table
CREATE TABLE sales (
    ID INT PRIMARY KEY,
    name VARCHAR(20),
    sales INT NOT NULL,
    bonus INT,
    position VARCHAR(15)
);
DROP TABLE IF EXISTS em_cities;
drop table sales;
use company;


INSERT INTO sales VALUES 
(1, 'Ali Khan', 50000, 5000, 'Manager'),
(2, 'Sara Ahmed', 42000, 4200, 'Executive'),
(3, 'Usman Tariq', 38000, 3800, 'Executive'),
(4, 'Ayesha Noor', 60000, 7000, 'Manager'),
(5, 'Hamza Ali', 30000, 2500, 'Associate'),
(6, 'Zain Malik', 45000, 4500, 'Executive'),
(7, 'Hira Shah', 52000, 5200, 'Manager'),
(8, 'Bilal Raza', 28000, 2000, 'Associate'),
(9, 'Fatima Khan', 47000, 4700, 'Executive'),
(10, 'Danish Iqbal', 35000, 3000, 'Associate'),
(11, 'Noor Ali', 62000, 8000, 'Senior Manager'),
(12, 'Saad Qureshi', 41000, 4100, 'Executive'),
(13, 'Mehwish Ali', 39000, 3900, 'Executive'),
(14, 'Farhan Sheikh', 27000, 1800, 'Associate'),
(15, 'Rabia Aslam', 55000, 6000, 'Manager');

drop table em_cities;
-- Child table
CREATE TABLE em_cities (
    ID INT,
    city VARCHAR(10),
    FOREIGN KEY (ID) REFERENCES sales(ID)
    on update cascade 
    on delete cascade
);

INSERT INTO em_cities VALUES 
(1, 'Karachi'),
(2, 'Lahore'),
(3, 'Islamabad'),
(4, 'Quetta'),
(5, 'Peshawar'),
(6, 'Karachi'),
(7, 'Lahore'),
(8, 'Islamabad'),
(9, 'Quetta'),
(10, 'Peshawar'),
(11, 'Karachi'),
(12, 'Lahore'),
(13, 'Islamabad'),
(14, 'Quetta'),
(15, 'Peshawar');

update sales 
set ID = 88
where ID = 13;
select * from sales;
select * from em_cities;
alter table sales
add Age int not null;
select * from sales;
alter table sales
drop column age ;
select * from sales;
alter table sales
add column age int not null default 22;    -- this will make every age is = 19
select * from sales;
