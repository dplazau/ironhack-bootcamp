-- lab: sql-join

use sakila-pg;

-- 1
select 
    film_category.category_id,
    count(film.film_id) as qty_films_per_category
        from film
            right join film_category 
                on film.film_id = film_category.film_id
                    group by film_category.category_id
                        order by film_category.category_id asc;

-- 2
select 
    staff.first_name,
    staff.last_name,
    address.address
        from staff
            join address
                on staff.address_id = address.address_id;

-- 3
-- dont understand the question

-- 4
select
    film.film_id,
    film.title,
    count(film_actor.actor_id) as qty_actors_per_film
        from film
            left join film_actor
                on film.film_id = film_actor.film_id
                    group by film.film_id
                        order by film.film_id;

-- 5
select
    customer.customer_id,
    customer.last_name,
    sum(payment.amount) as amount_paid_per_customer
        from customer
            left join payment
                on customer.customer_id = payment.customer_id
                    group by customer.customer_id
                        order by customer.customer_id;
