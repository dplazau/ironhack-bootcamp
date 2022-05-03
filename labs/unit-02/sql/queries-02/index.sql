-- queries-02

-- 1.0 Select all the actors with the first name ‘Scarlett’.
select 
    *
        from
            actor
                where 
                    actor.first_name = 'SCARLETT';

-- 2.0 Select all the actors with the last name ‘Johansson’.
select 
    *
        from
            actor
                where 
                    actor.last_name = 'JOHANSSON';

-- 3.0 How many films (movies) are available for rent?
select 
    count(inventory.film_id) as qty_films
        from
            inventory;
        
-- 4.0 How many films have been rented?
select
    *
        FROM
            rental
                where rental.return_date = null;
    

-- 5.0 What is the shortest and longest rental period?
select
    min(film.rental_duration),
    max(film.rental_duration)
        from 
            film;

-- 6.0 What are the shortest and longest movie duration? Name the values max_duration and min_duration.
select
    min(film.length) as min_duration,
    max(film.length) as max_duration
        from 
            film;

-- 7.0 What's the average movie duration?
select
    round(avg(film.length), 2) as avg_duration
        from 
            film;

-- 8.0 What's the average movie duration expressed in format (hours, minutes)?
select 
    date_part('hours',interval '1 minute' * round(avg(film.length), 2)) as hours, 
    date_part('minutes',interval '1 minute' * round(avg(film.length), 2)) as minutes
        from 
            film;

-- 9.0 How many movies longer than 3 hours?
select
    count(distinct film.film_id)
        from
            film 
                where 
                    film.length > 180;

-- 10.0 Get the name and email formatted. Example: Mary SMITH - mary.smith@sakilacustomer.org.
select 
    concat(left(first_name, 1), 
    right(lower(first_name),char_length(first_name)-1), 
    ' ',
	last_name, ' - ', lower(email)) as name_and_email
        from 
            customer;

-- 11.0 What's the length of the longest film title?
select
    title,
    char_length(film.title) as title_length
        from 
            film
                group by 
                    film.film_id
                        order by
                            char_length(film.title) desc
                                limit 1;