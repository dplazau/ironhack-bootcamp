use sakila;

-- Create a table rentals_may to store the data from rental table with information for the month of May.
-- Insert values in the table rentals_may using the table rental, filtering values only for the month of May.
create table rentals_may as
	select *
	from rental
	where month(rental_date) = 5 -- May
	order by rental_date;
    
-- Create a table rentals_may to store the data from rental table with information for the month of June.
-- Insert values in the table rentals_may using the table rental, filtering values only for the month of June.
create table rentals_june as
	select *
	from rental
	where month(rental_date) = 6 -- June
	order by rental_date;

-- Check the number of rentals for each customer for May
select customer_id, count(rental_id) as n_rentals
from rentals_may
group by customer_id
order by customer_id;

-- Check the number of rentals for each customer for June
select customer_id, count(rental_id) as n_rentals
from rentals_june
group by customer_id
order by customer_id;