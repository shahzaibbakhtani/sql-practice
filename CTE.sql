create database sales;
use sales;
CREATE TABLE customers (
    ID   INT PRIMARY KEY,
    name     VARCHAR(50),
    city          VARCHAR(50),
    country       VARCHAR(50)
);

INSERT INTO customers  VALUES
(1, 'Ahmed Khan',   'Karachi',   'Pakistan'),
(2, 'Sara Ali',     'Lahore',    'Pakistan'),
(3, 'John Smith',   'New York',  'USA'),
(4, 'Emma Brown',   'London',    'UK'),
(5, 'Ali Raza',     'Karachi',   'Pakistan'),
(6, 'Fatima Malik', 'Islamabad', 'Pakistan'),
(7, 'James Lee',    'Chicago',   'USA'),
(8, 'Zara Sheikh',  'Lahore',    'Pakistan');

CREATE TABLE employees (
    emp_id INT PRIMARY KEY,
    name VARCHAR(50),
    manager_id INT
);

INSERT INTO employees VALUES
(1, 'Ahmed Khan',   NULL),
(2, 'Sara Ali',     1),
(3, 'Ali Raza',     1),
(4, 'Fatima Malik', 2),
(5, 'James Lee',    2),
(6, 'Zara Sheikh',  3);

select * from customers;
CREATE TABLE sales_orders (
    order_id    INT PRIMARY KEY,
    cust_id     INT REFERENCES customers(ID),
    product     VARCHAR(50),
    category    VARCHAR(30),
    qty         INT,
    unit_price  DECIMAL(10,2),
    order_date  DATE,
    status      VARCHAR(20)
);

INSERT INTO sales_orders VALUES
(101, 1, 'Laptop',      'Electronics', 2, 75000.00, '2024-01-05', 'Delivered'),
(102, 2, 'Phone',       'Electronics', 1, 45000.00, '2024-01-10', 'Delivered'),
(103, 3, 'Desk Chair',  'Furniture',   4, 12000.00, '2024-01-15', 'Shipped'),
(104, 1, 'Monitor',     'Electronics', 1, 30000.00, '2024-02-01', 'Delivered'),
(105, 5, 'Keyboard',    'Electronics', 3,  5000.00, '2024-02-10', 'Pending'),
(106, 4, 'Sofa',        'Furniture',   1, 85000.00, '2024-02-14', 'Delivered'),
(107, 6, 'Laptop',      'Electronics', 1, 75000.00, '2024-03-01', 'Shipped'),
(108, 2, 'Headphones',  'Electronics', 2,  8000.00, '2024-03-05', 'Delivered'),
(109, 7, 'Bookshelf',   'Furniture',   2, 15000.00, '2024-03-12', 'Pending'),
(110, 8, 'Phone',       'Electronics', 1, 45000.00, '2024-03-20', 'Delivered'),
(111, 3, 'Laptop',      'Electronics', 1, 75000.00, '2024-04-01', 'Shipped'),
(112, 5, 'Monitor',     'Electronics', 2, 30000.00, '2024-04-05', 'Delivered'),
(113, 1, 'Office Desk', 'Furniture',   1, 25000.00, '2024-04-10', 'Pending'),
(114, 6, 'Tablet',      'Electronics', 2, 35000.00, '2024-04-15', 'Delivered'),
(115, 8, 'Sofa',        'Furniture',   1, 85000.00, '2024-04-22', 'Shipped');

use sales;

select count(order_id) from sales_orders;

with CTE_Total_sales as (
select cust_id, 
sum(unit_price) as total_sales from sales_orders group by cust_id),
CTE_last_order as (
select cust_id, max(order_date) as last_order from sales_orders group by cust_id
)
-- main query -- 
select ID, name ,cts.total_sales , clo.last_order
from customers C 
 join CTE_Total_sales cts on C.ID = cts.cust_id
left join CTE_last_order clo on C.ID = clo.cust_id
;

select * from sales_orders;

with CTE_one as (
select cust_id , sum(unit_price) as total from sales_orders group by cust_id)

select name, ID , cts.total from Customers C join CTE_one as cts on C.ID = cts.cust_id
order by total desc
;

-- Nested CTE--

with CTE_one as (
select cust_id , sum(unit_price) as total from sales_orders group by cust_id),
CTE_two as  ( select cust_id ,total , rank()  over(order by total desc) as ranking  from CTE_one),
segment as (
select cust_id, total ,
case 
	when total > 100000 then "Wow Man"
    when total > 50000 then "Improve Man"
    when total > 30000 then "Fuck Off Man"
    else "Fuck you more"
end comments from CTE_one
)
select C.ID, C.name, final.total , final.ranking, S.comments
from CTE_two final join Customers C 
on final.cust_id = C.ID 
join segment S on final.cust_id = S.cust_id
order by total desc;

use sales;

-- Recurssive Query -- 

with Recursive Numbers As (
select 1 as my_number 
-- recursive query--
Union All
select my_number +1 
from Numbers
where my_number < 20)
-- Main query -- 
select * from numbers;

with recursive standards AS (
select name, manager_id , 1 as level  from employees
where manager_id is null
Union All
select name , manager_id , level +1 
from standards 
where level <  5                -- always less than sign --
)
select * from standards
;


use cricket;
select * from players;

select name , runs , 
(select avg(runs) from players) as avg,
runs - (select avg(runs) from players) as diff
 from players order by runs desc;

select name , runs from players where runs > (select avg(runs) from players) and 
team_id in (select team_id from team where world_cups>1);

-- Practice --


with C_Total As
(Select cust_id , sum(unit_price) total_sales from sales_orders group by cust_id),

C_Date As 
(select cust_id, max(order_date) as last_order from sales_orders group by cust_id)

select  C.ID , C.name , CT.total_Sales , last_order from customers C 
join C_Total CT on C.ID = CT.cust_id 
join C_Date CD on C.ID = CD.cust_id
ORDER BY  CT.total_sales desc
;

with C_total as
(select cust_id, sum(unit_price) total from sales_orders group by cust_id),

Ranking as 
(select cust_id , total, rank() over(order by total desc) rank_per_cust from C_total),

Segment as 
(select cust_id , total ,
case 
	when total > 110000 then "Bonus is 10%"
    when total > 80000 then "Bonus is 5%"
    when total > 50000 then "Bonus is 3%"
    else "Bonus is 1%"
end bonus from C_total)

Select C.ID , C.name , CT.total , R.rank_per_cust , S.bonus
from customers C
join C_total CT on C.ID = CT.cust_id 
join Ranking R on C.ID = R.cust_id 
join Segment S on C.Id = S.cust_id
ORDER BY R.rank_per_cust;

use sales;
select * from sales_orders;

with Month_no as 
(select monthname(order_date) Month_  , sum(unit_price) Total from sales_orders group by monthname(order_date)),
High as 
(select Month_ , total , rank() over(order by Total desc) ranking from Month_no)
select  Month_ , total from High where ranking = 1;


with Elec As 
(select cust_id,category from sales_orders where category in ("Electronics","Furniture") group by cust_id, category)

select C.name , E.cust_id , E.category from customers C join Elec E on C.ID = E.cust_id;


select * from sales_orders;

with Product as 
(select product ,sum(qty) total from sales_orders group by product)

select product, total from Product where total > 1;


with Product as 
(select product , count(*) total from sales_orders group by product)

select product , total from Product where total > 1;

with Elec as 
(select cust_id , category from sales_orders where category = "Electronics" group by cust_id),
Fur as 
(select cust_id , category from sales_orders where category = "Furniture" group by cust_id)
select C.name , E.cust_id , E.category , F.cust_id , F.category from customers C join Elec E on C.ID = E.cust_id
join Fur F on C.ID = F.cust_id;


with Total as 
(select cust_id , sum(qty * unit_price) as amount from sales_orders group by cust_id),
Average as 
(select cust_id , amount ,avg(amount) over() avg_c from Total)
select C.name ,cust_id, amount, round(avg_c,2) average from customers C join Average A on C.ID = A.cust_id
where amount > avg_c;

select * from customers;

with S_Data as 
(select S.*, C.city from customers C join sales_orders S on C.ID = S.cust_id),
Revenue as 
(select city , sum(qty * unit_price) revenue from S_Data group by city),
Ranker as 
(select city , revenue , rank() over(order by revenue desc) ranking from Revenue)
select city , revenue ,ranking from Ranker where ranking = 1;

with S_Data as 
(select C.name, S.*, C.country  from customers C join sales_orders S on C.ID = S.cust_id),
Revenue as 
(select  country , sum(qty * unit_price) rev from S_Data group by country)













 









