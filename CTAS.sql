create table monthly_flights as
select monthname(booking) MonthName , count(*) Total from flight group by monthname(booking);

drop table monthly_flights;

select * from monthly_flights; 

-- Temporary tables --

create temporary table Men1 as 
select * from products where category = "Men";

delete from Men1 where price > 3000;
select * from Men1;


create temporary table Women as 
select * from products where category ="Women";

select * from Women;