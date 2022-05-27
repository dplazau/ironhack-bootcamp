-- lab: self-cross-joins


-- 1. Get all pairs of actors that worked together.
select 
    f0.film_id,
    f1.actor_id,
    f0.actor_id 
        from film_actor as f0
            inner join film_actor as f1
                on  f0.film_id = f1.film_id
                and f0.actor_id <> f1.actor_id
                    order by f0.film_id;

-- 2. Get all pairs of customers that have rented the same film more than 3 times.
select 
    r1.inventory_id,
    r1.customer_id,
    count(distinct r1.customer_id) as qty_rented,
    r2.customer_id,
    count(distinct r2.customer_id)  as qty_rented2
FROM rental r1
JOIN rental r2
ON r1.inventory_id = r2.inventory_id and r1.customer_id <> r2.customer_id
group by 
    r1.inventory_id,
    r1.customer_id,
    r2.customer_id;
having r1.customer_id >= 3 AND r2.customer_id >= 3;
-- NOT FINISHED 

-- 3. Get all possible pairs of actors and films.
DROP TABLE IF EXISTS sakila.distinct_actor;
CREATE TEMPORARY TABLE sakila.distinct_actor
SELECT DISTINCT actor_id FROM sakila.film_actor;

DROP TABLE IF EXISTS sakila.distinct_film;
CREATE TEMPORARY TABLE sakila.distinct_film
SELECT DISTINCT film_id FROM sakila.film_actor;

SELECT concat(a.first_name, " ", a.last_name) as name, sub1.actor_id, sub2.film_id
FROM sakila.distinct_actor as sub1
CROSS JOIN sakila.distinct_film as sub2
    JOIN sakil
