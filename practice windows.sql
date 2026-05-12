use khan;
select * from school;
select name , city ,count(name) over(partition by city) from school;
select name , marks ,course, avg(marks) over(partition by course) from school order by course , marks desc;
select name , marks , sum(marks) over(order by marks ) as running_total from school;
select name ,city  ,marks, sum(marks) over(partition by city) sum_per_city from school order by city , marks desc;
select  course ,name , marks, avg(marks) over(partition by course order by marks desc  
ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW) as average from school;

select city , name , marks ,avg(marks) over(partition by city) as city_average, marks - avg(marks) over(partition by city) as diff from school;

-- Practice of null -- 

use cricket;
select * from stats;

select batting_avg, isnull(batting_avg) ISNULL from stats;

select name , salary , concat(name,coalesce(salary , 0)) from stats;

select * from stats where batting_avg is null  and bowling_avg is null;

SELECT country,
       COUNT(*) AS total_players,
       SUM(CASE WHEN last_match IS NULL THEN 1 ELSE 0 END) AS null_count
FROM stats
GROUP BY country;

select country, count(*) ALL_count , count(last_match) As_null  from stats group by country;

select  matches * batting_avg,
matches * nullif(batting_avg,0) as num
 from stats;
 
set SQL_SAFE_UPDATES = 0; 
update stats 
set batting_avg = 0 
where batting_avg is null;

select nullif(batting_avg,0) / matches from stats;

select * from stats; 
update stats 
set batting_avg = 32.3
where batting_avg = 0;

-- CASE Statments--

select name , runs,
case 
	when runs >= 20000 then "Super Star"
    when runs > 10000 then "Good Player"
    when runs > 5000  then "Emerging Player"
    else "Fuck Off"
end Category
from players order by runs desc;



select Category, sum(runs) total_runs from(
select name , runs,
case 
	when runs >= 20000 then "Super Star"
    when runs > 10000 then "Good Player"
    when runs > 5000  then "Emerging Player"
    else "Fuck Off"
end Category
from players )t
group by Category
order by total_runs desc
;

select  distinct country from team;


select name , salary,
case 
	when salary is null then 0
    else salary 
    end  no_null,
round(avg(salary) over(),2) as avg_salary,
round(avg(case 
		when salary is null then 0
		else salary 
    end) over(),2) clean_avg
from stats;


-- Percent based -- 
select * from (
select name , marks , round(cume_dist() over(order by marks desc),2) CD from school)t
where CD < 0.20;

select * from (
select name , marks , round(cume_dist() over(order by marks),4) CD, 
round(percent_rank() over(order by marks),4) PR from school)t where CD > 0.90;

--  Value Functions ---

select name , marks , lead(marks) over(order by marks desc) lead_marks from school;

use job;
select * from emp;

select *, (Income - lead_income) / Income * 100 as pct_change
from( 
select DOJ ,name , Income, lead(Income) over(order by DOJ)lead_income
 from emp)t;


select *, (Income - lag_income) / Income * 100 as pct_change
from( 
select DOJ ,name , Income, lag(Income) over(order by DOJ) lag_income
 from emp)t;




