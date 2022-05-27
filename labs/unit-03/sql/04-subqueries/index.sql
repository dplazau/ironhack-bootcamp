-- # Lab  SQL Subqueries

-- 1. How many copies of the film _Hunchback Impossible_ exist in the inventory system?
select
    film.title,
    count(inventory.film_id) as qty_copies_per_film
from 
    film
left join
    inventory
on 
    film.film_id = inventory.film_id
where film.title = 'HUNCHBACK IMPOSSIBLE'
group by 
    film.film_id
order by 
    film.title;


-- 2. List all films whose length is longer than the average of all the films.
with cte_average_length_all_films as (
    select 
        round(avg(film.length), 0) as average_length_all_films
    from
        film
) 
select f.length
from film f
where length > (select average_length_all_films from cte_average_length_all_films)
order by length desc;



-- 3. Use subqueries to display all actors who appear in the film _Alone Trip_.
select
    film.title,
    film_actor.film_id, 
    film_actor.actor_id
from film
right join film_actor
using (film_id)
where film.title = 'ALONE TRIP' ;

-- 4. Sales have been lagging among young families, and you wish to target all family movies for a promotion. 
-- Identify all movies categorized as family films.
select 
    title,
    category
from film_list
where category = 'Family';


-- 5. Get name and email from customers from Canada using subqueries. Do the same with joins.
-- Note that to create a join, you will have to identify the correct tables with their primary keys and foreign keys, 
-- that will help you get the relevant information.
SELECT 
    country,
    last_name,
    first_name,
    email
FROM country c
LEFT JOIN customer cu
    ON c.country_id = cu.customer_id
WHERE country = 'Canada';


-- 6. Which are films starred by the most prolific actor?
-- Most prolific actor is defined as the actor that has acted in the most number of films.
-- First you will have to find the most prolific actor and then use that actor_id to find the different films that he/she starred.
select 
    actor.actor_id,
    actor.first_name,
    actor.last_name,
    count(actor_id) as film_count
from actor 
join film_actor using (actor_id)
group by actor_id
order by film_count desc
limit 1;

-- 7. Films rented by most profitable customer. 
-- You can use the customer table and payment table to find the most profitable customer ie the customer that has made the largest sum of payments
with cte_most_profitable_customer as (
    select
        sum(payment.amount) as total_payments,
        payment.customer_id
    from payment
    group by customer_id
    order by total_payments desc
    limit 1
)
select 
    film_id,
    film.title,
    inventory.inventory_id,
    customer_id
from
    film
join inventory using (film_id)
join rental using (inventory_id)
join cte_most_profitable_customer using (customer_id)
order by inventory_id;


-- 8. Get the `client_id` and the `total_amount_spent` of those clients who spent more than the average of the `total_amount` spent by each client.
with cte_total_spent_per_customer as (
    select
        sum(payment.amount) as total_payments,
        payment.customer_id
    from payment
    group by customer_id
    order by total_payments desc
), cte_avg_total_spent_by_customers as (
    select
        round(avg(total_payments), 2) as avg_spent 
    from cte_total_spent_per_customer
)
select 
    cte_total_spent_per_customer.customer_id,
    cte_total_spent_per_customer.total_payments
from 
    cte_total_spent_per_customer
where cte_total_spent_per_customer.total_payments > (
    select avg_spent from cte_avg_total_spent_by_customers);
