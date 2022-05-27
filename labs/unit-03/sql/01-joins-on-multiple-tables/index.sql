-- lab: join on multiple tables 

-- 1. Write a query to display for each store its store ID, city, and country.
select
    store.store_id,
    city.city,
    country.country 
        from store
            join address using(address_id)
                join city using(city_id)
                    join country using(country_id);

-- 2. Write a query to display how much business, in dollars, 
-- each store brought in.
select
    store.store_id,
    sum(payment.amount) as total_revenue_per_store
    from store
        left join staff using (store_id)
            left join payment using (staff_id)
                group by store.store_id;


-- 3. What is the average running time of films by category?
select 
    category.name as cat_name,
    round(avg(film.length), 2) as avg_run_time_film
    from film
        join film_category using (film_id)
            join category using (category_id)
                group by cat_name;  

-- 4. Which film categories are longest?
select 
    category.name as cat_name,
    round(avg(film.length), 2) as avg_run_time_film
    from film
        join film_category using (film_id)
            join category using (category_id)
                group by cat_name
                    order by avg_run_time_film desc 
                        limit 5;  

-- 5. Display the most frequently rented movies in descending order.
select 
    film.film_id,
    film.title,
    count(rental.rental_id) as qty_rentals
    from film
        left join inventory using(film_id)
            join rental using(inventory_id)
                group by film.film_id
                    order by qty_rentals desc
                        limit 10;

-- 6. List the top five genres in gross revenue in descending order.
select 
    category.name, 
    sum(payment.amount) as tot_amount 
        from category
            join film_category using(category_id)
            join inventory using(film_id)
            join rental using(inventory_id)
            join payment using (rental_id)
                group by name
                    order by tot_amount desc
                        limit 5;    

-- 7. Is "Academy Dinosaur" available for rent from Store 1?
select
    film.film_id,
    film.title,
    count(inventory.store_id) as copies_per_store
        from film
            join inventory using(film_id)
            join rental using(inventory_id)
                
                    where title = 'ACADEMY DINOSAUR'
                            and store_id=1
                                group by film.film_id;
                                