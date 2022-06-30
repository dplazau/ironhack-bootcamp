-- # Lab | SQL Rolling calculations

use sakila;
-- 1. Get number of monthly active customers.
create or replace view sakila.monthly_active_customers as 
select date_format(rental_date, '%Y') as active_year,
date_format(rental_date, '%m') as active_month,
count(customer_id) as active_customers
from rental
group by active_year, active_month
order by active_year, active_month;

select * from monthly_active_customers;

-- 2.Active users in the previous month.
create or replace view sakila.last_month_active_customers as
select *,
lag(active_customers, 1) over () as last_month_customers
from monthly_active_customers;
select * from last_month_active_customers;

-- 3. Percentage change in the number of active customers.
select *,
concat(round((active_customers - last_month_customers)/last_month_customers * 100, 2), '%') as Percentage_variation
from last_month_active_customers;

-- 4. Retained customers every month.
-- Not the same as Percentage change in the number of active customers?
select *,
case 
	when active_customers >= last_month_customers then '100%'
    else concat(round((active_customers)/last_month_customers*100, 2),  '%')
end as 'Customer retention'
from last_month_active_customers;