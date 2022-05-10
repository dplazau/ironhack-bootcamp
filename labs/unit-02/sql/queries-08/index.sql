-- queries-08

use sakila;

-- 1. Rank films by length .
select 
    title,
    length, 
    dense_rank() over (order by length) as Rank_by_length
        from film
            where length is not null and length <> 0;

-- 2. Rank films by length within the rating category
select 
    title,
    length,
    rating,
    dense_rank() over (partition by rating order by length) as Rank_by_rating
        from film
            where length is not null and length <> 0;

-- 3. How many films are there for each of the categories in the category table. Use appropriate join to write this query
select 
    c.name,
    count(fc.film_id) as qty_films
        from film_category fc
            right join category c on fc.category_id = c.category_id
                group by c.name
                    order by c.name;

-- 4. Which actor has appeared in the most films?
select 
    a.actor_id,
    a.first_name,
    a.last_name,
    count(a.film_id) as n_films
        from actor a
            right join  film_actor fa on a.actor_id = fa.actor_id
                group by a.actor_id, a.first_name, a.last_name
                    order by n_films desc
                        limit 1;

-- 5. Most active customer (the customer that has rented the most number of films)
select 
    c.customer_id,
    c.first_name,
    c.last_name,
    count(r.rental_id) as n_rentals
        from customer c
            right join rental r on c.customer_id = r.customer_id
                where c.customer_id is not null
                    group by c.customer_id, c.first_name, c.last_name
                        order by n_rentals desc
                            limit 1;