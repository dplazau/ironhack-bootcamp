-- 1.Select the first name, last name, and email address of all the customers who have rented a movie.
select c.first_name, c.last_name, c.email from customer c
join rental r on c.customer_id = r.customer_id
order by c.first_name, c.last_name;

-- 2.What is the average payment made by each customer (display the customer id, customer name (concatenated), and the average payment made).
select 
    c.customer_id,
    concat(c.first_name, ' ', c.last_name) as customer_name,
    round(avg(p.amount),2) as average_payment 
from customer c
join payment p on c.customer_id = p.customer_id
group by c.customer_id
order by c.customer_id;

-- 3.Select the name and email address of all the customers who have rented the "Action" movies.
select concat(c.first_name, ' ', c.last_name) as customer_name, c.email from customer c
join rental r on c.customer_id = r.customer_id
join inventory i on r.inventory_id = i.inventory_id
join film_category fc on i.film_id = fc.film_id
join category ca on fc.category_id = ca.category_id
where ca.name = 'Action';

-- Write the query using sub queries with multiple WHERE clause and IN condition
select customer_name, email from (select concat(c.first_name, ' ', c.last_name) as customer_name, c.email from customer c
join rental r on c.customer_id = r.customer_id
join inventory i on r.inventory_id = i.inventory_id
join film_category fc on i.film_id = fc.film_id
join category ca on fc.category_id = ca.category_id
where ca.name = 'Action') sub;

-- 4.Verify if the above two queries produce the same results or not
-- Yes

-- 5.Use the case statement to create a new column classifying existing columns as either or high value transactions based on the amount of payment. 
-- If the amount is between 0 and 2, label should be low and if the amount is between 2 and 4, the label should be medium, and if it is more than 4, then it should be high.
SELECT *,CASE 
		WHEN amount <= 2 THEN 'low' 
		WHEN amount <= 4 THEN 'medium' 
        ELSE 'high' END AS classifying
FROM payment;