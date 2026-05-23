
with Total_per_month as (
select month(order_date) Month_no , sum(unit_price) total_sales , count(order_id) count_orders from sales_orders group by Month_no),


Ranking as 
(select Month_no ,count_orders ,total_sales, rank() over(order by total_sales desc) Ranker from Total_per_month)

select Month_no ,total_sales, Ranker , count_orders from Ranking
;

-- Views --


Create View Monthly_summary_2 as 
(with Total_per_month as (
select month(order_date) Month_no , sum(unit_price) total_sales , count(order_id) count_orders from sales_orders group by Month_no),

Ranking as 
(select Month_no ,count_orders ,total_sales, rank() over(order by total_sales desc) Ranker from Total_per_month)

select Month_no ,total_sales, Ranker , count_orders from Ranking
);

select Month_no , total_sales ,row_number() over(order by total_sales desc) row_rank from monthly_summary_2;

drop view monthly_summary;






