-- queries-06

-- 1.0 Add the new films to the database.
select
    *
        from
            film;

COPY 
    film
        (
            film_id,
            title,
            description,
            release_year,
            language_id,
            original_language_id,
            rental_duration,
            rental_rate,
            length,
            replacement_cost,
            rating
        )
            FROM 'C:\Temp\films_2020.csv'
                    DELIMITER ','
                        CSV HEADER;


update 
    film
    set 
        rental_duration = 3, 
        rental_rate = 2.99, 
        replacement_cost = 8.99;