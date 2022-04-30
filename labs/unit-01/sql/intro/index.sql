-- sql-intro

-- 1.0
-- use sakila-pg;

-- 2.0

select * from actor;
select * from film;
select * from customer;

-- 3.0
select -- 2 --
    *,
    film.title
        from 
            film; -- 1st -- 


-- 4.0 
select -- 2nd -- 
    distinct 
        language.name,
        language.language_id
            from 
                language -- 1st --
                    order by 
                        language.language_id; -- 3rd --

-- 5.0

-- 5.1
select
    count(distinct store.store_id) as qty_stores
        from
            store;

-- 5.2
select
    count(distinct staff.store_id) as qty_staff
        from
            staff;

-- 5.3
select
    staff.first_name
        from
            staff;