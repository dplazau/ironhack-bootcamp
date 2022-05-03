--  queries-05

-- 1. Drop column `picture` from `staff`.
ALTER TABLE staff
  DROP COLUMN picture;

-- 2. A new person is hired to help Jon. Her name is TAMMY SANDERS, and she is a customer. Update the database accordingly.
insert into 
  customer
    values (
      default,
      2,
      'TAMMY',
      'SANDERS',
      'TAMMY.SANDERS@sakilacustomer.org',
      123,
      true,
      now(),
      now()
      );


select * from customer
  where first_name = 'TAMMY';

select * from staff;

-- 3. Add rental for movie "Academy Dinosaur" by Charlotte Hunter from Mike Hillyer at Store 1. You can use current date for the `rental_date` column in the `rental` table.
--    **Hint**: Check the columns in the table rental and see what information you would need to add there. You can query those pieces of information. For eg., you would notice that you need `customer_id` information as well. To get that you can use the following query:
--     ```sql
--     select customer_id from sakila.customer
--     where first_name = 'CHARLOTTE' and last_name = 'HUNTER';
--     ```
--     Use similar method to get `inventory_id`, `film_id`, and `staff_id`.


select 
    film.film_id 
      from 
        film
          where 
            title = "ACADEMY DINOSAUR";

select 
  inventory.inventory_id 
    from 
      inventory
        where inventory.film_id=1;

select 
  customer_id 
    from 
      customer
        where first_name='CHARLOTTE' and last_name='HUNTER';

select staff_id from staff

insert into rental
values (default, now(), 1, 130, null, 1, now());

select 
  * 
    from 
      rental
        order by 
          last_update desc
            limit 1;


-- 4. Delete non-active users, but first, create a _backup table_ `deleted_users` to store `customer_id`, `email`, and the `date` for the users that would be deleted. Follow these steps:
--    - Check if there are any non-active users
--    - Create a table _backup table_ as suggested
--    - Insert the non active users in the table _backup table_
--    - Delete the non active users from the table _customer_

select 
  * 
    from 
      customer
        where 
          active=0;

create table 
  inactive_customers 
    as 
      select * from customer;

delete from 
  inactive_customers
    where active=1;


SET session_replication_role = 'replica';
delete from 
  customer
    where active = 0;

