rename table flight_bookings to flight;
select *, curdate(), now() from flight;

select flight_date ,year(flight_date) YEAR_f, month(flight_date) Month_f, day(flight_date) Day_f from flight;

select flight_date, extract(Month from flight_date) month ,
extract(week from flight_date) week , extract(quarter from flight_date) Q from flight;


-- Name --
select extract(hour from flight_date) hour, extract(minute from flight_date) Min,
dayname(flight_date) Day , monthname(flight_date) Month 
from flight;

SET SQL_SAFE_UPDATES = 0;

alter table flight 
rename column flight_date to date;

alter table flight 
rename column booking_date to booking;

select date_format(date, "%Y,%M") YearMonth from flight;






