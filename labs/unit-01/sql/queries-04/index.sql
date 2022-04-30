-- queries-04

-- 1.0 Get film ratings.
select 
    distinct film.rating
        from
            film;

-- 2.0 Get release years.
select 
    distinct film.release_year
        from
            film;


-- 3.0 Get all films with ARMAGEDDON in the title.
select 
    *
        from 
            film
                where 
                    film.title like '%ARMAGEDDON%'

-- 4.0 Get all films with APOLLO in the title
select 
    *
        from 
            film
                where 
                    film.title like '%APOLLO%'


-- 5.0 Get all films which title ends with APOLLO.
select 
    *
        from 
            film
                where 
                    film.title like '%APOLLO'

-- 6.0 Get all films with word DATE in the title.
select 
    *
        from 
            film
                where 
                    film.title like '%DATE%'

-- 7.0 Get 10 films with the longest title.
select
    title,
    char_length(film.title) as title_length
        from 
            film
                group by 
                    film.film_id
                        order by
                            char_length(film.title) desc
                                limit 10;

-- 8.0 Get 10 the longest films.
select
    title,
    film.length as film_duration
        from 
            film
                order by
                    film.length desc
                        limit 10;

-- 9.0 How many films include **Behind the Scenes** content?
select 
    count(*) as qty_films_behind_scenes
        from film
            where 
                film.special_features::TEXT like '%Behind_the_Scenes%';

-- 10.0 List films ordered by release year and title in alphabetical order.
select
    *
        from film
            order by
                film.release_year desc, 
                film.title;