-- queries-03

-- 1.0 How many distinct (different) actors' last names are there?
select 
    count(distinct actor.last_name) as qty_actors_unq_lnames
        from 
            actor;

-- 2.0 In how many different languages where the films originally produced? (Use the column language_id from the film table)
select 
    count(distinct film.language_id) as qty_unq_languages
        from 
            film;

-- 3.0 How many movies were released with "PG-13" rating?
select 
    count(film.rating) as qty_pg13_films
        from 
            film
                where 
                    film.rating = 'PG-13';

-- 4.0 Get 10 the longest movies from 2006.
select 
    film.film_id, 
    film.title, 
    film.length,
    film.release_year
        from
            film
                where 
                    film.release_year = '2006'
                        order by length desc
                            limit 10;

-- 5.0 How many days has been the company operating (check DATEDIFF() function)?
-- there is a problem with this table the last_update column which is present in the ERD
-- isn't shown in the current querie
select 
    EXTRACT(DAY FROM max(payment.last_update) - min(payment.payment_date)) as total_days
        from 
            payment;

-- 6.0 Show rental info with additional columns month and weekday. Get 20.
select 
    *,
    TO_CHAR(rental.rental_date :: DATE, 'MM') as month,
    TO_CHAR(rental.rental_date :: DATE, 'ID') as weekday
        from 
            rental
                limit 20;

-- 7.0 Add an additional column day_type with values 'weekend' and 'workday' depending on the rental day of the week.
select 
    *,
    TO_CHAR(rental.rental_date :: DATE, 'Mon') as month,
    TO_CHAR(rental.rental_date :: DATE, 'ID') as weekday,
        case
            when 
                TO_NUMBER(TO_CHAR(rental.rental_date :: DATE, 'ID'), '9G999g999') > 5 
                    then 'weekend'
                        else 'workday'
        end 
            as day_of_week
                from 
                    rental;


-- 8.0 How many rentals were there in the last month of activity?
select 
    count(rental.rental_id) as rental_last_month
        from 
            rental
                where 
                    TO_NUMBER(TO_CHAR(rental.rental_date :: DATE, 'MM'), '9G999g999') > 
                    (TO_NUMBER(TO_CHAR(rental.last_update :: DATE, 'MM'), '9G999g999') - 1);
