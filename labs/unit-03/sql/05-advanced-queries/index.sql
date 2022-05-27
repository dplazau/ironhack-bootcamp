-- Lab | SQL Advanced queries

-- 1. List each pair of actors that have worked together.
select 
    a.actor_id,
    a.first_name,
    a.last_name,
    count(*)
from actor a
join film_actor a2 on a2.actor_id = a.actor_id
where film_id in (select film_id from film_actor)
group by a.actor_id
order by count(*) desc;


-- 2. For each film, list actor that has acted in more films.
select 
    count(film_actor.actor_id),
    actor.first_name,
    actor.last_name 
from actor 
inner join film_actor using(actor_id)
group by actor_id ;