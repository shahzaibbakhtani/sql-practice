use sakila;
select * from actor;
select *, (select count(actor_id) from actor) from actor;
DESCRIBE actor;

Set SQL_SAFE_UPDATES = 0;

use aga;
select * from school;
Describe school;
alter table school
modify column name varchar(32);
describe school;
update  school
set ID = 1 where name = "Ali Hassan";

use tesla;
select * from charging_sessions;
select city , sum(session_duration_min) over(partition by city) SUM from charging_sessions;
select city , sum(session_duration_min) SUM from charging_sessions group by city order by SUM desc;

select * from service_appointments;
select  count(distinct month(appointment_date)), count(month(appointment_date)) from service_appointments;

select Monthname(appointment_date) Month , sum(cost)Total from 
service_appointments group by Monthname(appointment_date)
order by Total ;

Select year(appointment_date)Year,  monthname(appointment_date) Month
,sum(cost) Total from service_appointments group by year
(appointment_date),monthname(appointment_date) 
having Year = 2022 and Month = "September" order by Year ;

select * from orders where 
sale_price = (select max(sale_price) from orders);


select * from orders;
select C.first_name, C.last_name ,C.city, O.sale_price ,  O.discount 
from customers C left join orders O 
on C.customer_id = O.customer_id ;

select C.first_name , C.last_name, sum(O.sale_price)Total, count(O.sale_price) Count
from customers C join orders O on C.customer_id = O.customer_id 
group by C.first_name , C.last_name ;
use tesla;

select * from service_appointments;

select monthname(appointment_date) "Month", count(status) "Total Orders" from service_appointments 
where status = "Completed" group by monthname(appointment_date) order by count(status) desc;

select * from customers;
select * from service_appointments;

select customer_id , appointment_date , max(appointment_date) 
over(partition by customer_id) "Latest Order" , min(appointment_date) 
over(partition by customer_id) "Oldest Order" from service_appointments;
use tesla;

Select * from customers;

select first_name , last_name , total_spent from customers;

Select * from (
select * , nullif(Ranking , Row_num) Nuller from (
select *, rank() over(order by Total desc)Ranking, row_number() over(order by Total desc) Row_num from (
select state ,sum(total_spent) as Total from customers group by state)t)t)t where Nuller is not null or Ranking in (8,9);

select * from customers;

select loyalty_tier ,sum(total_spent) Total  from customers group by 
loyalty_tier order by Total desc;

select * from customers;

select country,city  , count(*) from customers group by country, city having city = "Austin" ;


select city , sum(total_spent) Total from customers group by city order by Total desc ;

select * from vehicles;
select * from customers;
select * from orders;


with Cte_2 as(
With Cte_one as (
select  C.customer_id ,C.first_name, C.City , C.total_spent, O.vehicle_id
from customers C join orders O 
on C.customer_id = O.customer_id)

select C.vehicle_id, C.first_name , C.total_spent , V.model , V.category
 from Cte_one C  join vehicles V on C.vehicle_id = V.vehicle_id)
 select first_name , sum(total_spent) Total from Cte_2 group by first_name;
 
 use tesla;
select * from customers;
select * from orders;

select customer_id, order_date  , min(order_date) over(partition by customer_id) "First Order"
, Month(order_date) "Month" , YEAR(order_date) "Year"
from orders;

select Month ,count(customer_id) "Total" from(
select * , date_format(order_date, "%M") as Month from orders)t
group by Month
;

select * from orders;

select customer_id, order_date,
min(order_date) over(partition by customer_id) as First_Order,
timestampdiff(Month, min(order_date) over(partition by customer_id), order_date) Diff from orders;


select customer_id , order_date , 
min(order_date) over(partition by customer_id) Cohort_Month,
timestampdiff(Month , min(order_date) over(partition by customer_id), order_date) as Diff
 from orders;

select count(distinct customer_id) as Total from customers;

select * from orders;


use tesla;
select * from orders;

select customer_id ,count(order_date) 
Total from  orders group by customer_id having Total > 0;

select order_status ,count(order_id) from orders group by order_status;


select "Delivered" , count(order_id) from orders where order_status = "Delivered";

select * from orders;

select "Signed Up"  as Stage , count(distinct customer_id) "Total" from customers
union 
select "Placed Order" , count(distinct customer_id) "Order" from orders
union 
select "Delivered" , count(distinct customer_id) "Done" from orders where order_status = "Delivered";



