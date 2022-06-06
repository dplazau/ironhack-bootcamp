select
    *
from film f
join inventory i using(film_id)
join rental r using(inventory_id); 