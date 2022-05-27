-- Cross and Self Joins

-- Self Joins:
-- allows you to join a table to itself, useful when comparing rows within the same table
-- you use it if you have two or more different values in the same column, but you want to display them in different columns and in the same row instead.
-- more examples: https://www.sqlservertutorial.net/sql-server-basics/sql-server-self-join/

-- find the customers that are from the same district
select * from bank.loan;

select * from bank.account a1
join bank.account a2
on a1.account_id <> a2.account_id -- the same as != (not equal to)
and a1.district_id = a2.district_id
order by a1.district_id, a1.account_id,a2.account_id;

select * from bank.account a1
join bank.account a2
on a1.district_id = a2.district_id
-- and a1.district_id = a2.district_id
order by a1.district_id, a1.account_id,a2.account_id;

-- find the accounts that have both OWNER and DISPONENT
select * from disp;

select * from bank.disp d1
join bank.disp d2
on d1.account_id = d2.account_id
and d1.type <> d2.type
where d1.type = 'DISPONENT';

/*
*/

-- Cross Joins:
-- used when you wish to create a combination of every row from two tables:
-- (A, B, C) x (1, 2): (A, 1), (A, 2), (B, 1), (B, 2), (C, 1), (C, 2)

-- find all the combinations of different card types and ownership of account
select distinct type from bank.card;
select distinct type from bank.disp;

select * from (
  select distinct type from bank.card
) sub1
cross join (
  select distinct type from bank.disp
) sub2;

-- without subquery but less eficient:
select distinct c.type, d.type from bank.card c
join bank.disp d;

-- find all the combinations of different card types and frequency
select * from (
	select distinct type from bank.card
) sub1
cross join (
	select distinct frequency from bank.account
) sub2;

/*
*/

-- Intro to Subqueries
-- similar idea to temporary tables, but it's not stored at all
-- represents a table when inside FROM statement OR represents a value when outside FROM statement

-- Subquery as a value:
-- NOTE: usually, I'm writting the query, when I realize a value that can only be obtained by another query is needed, so  i write a subquery that represents that value

-- Example - Identify the customers who borrowed an amount which is higher than the average:
-- we need to calculate the avg and then filter the table to get only bigger than avg
 
 -- step 1 --> start your main query
select * from bank.loan
where amount > 151410 ; -- avg(amount) won't work, WHERE clause doesn't take agg functions

-- step 2 --> create a query that returns the average (this will be the subquery)
select avg(amount) from bank.loan;

-- step 3 --> place the subquery in the main query
select * from bank.loan
where amount > (
  select avg(amount)
  from bank.loan
);

-- step 4 --> prettify the result
select * from bank.loan
where amount > (select avg(amount) from bank.loan)
order by amount
limit 10;


-- Subquery in the FROM statement:
-- NOTE: usually, I'm writting the query, when I realize I need to apply some more operations over that table to get what I want

-- Example - Return the districts with highest number of inhabitants for each region with the same amount of districts:
-- step 1 --> in this case I intuitively started by the subquery instead
select * from district;

select A3, count(A2) district_count, sum(A4) inhabitants from bank.district
group by A3
order by district_count;

-- so, I realize that the result can be obtained by applying a window function on that table

-- step 2 --> start the main query / put it together
select A3, district_count, inhabitants_region, rank() over (partition by district_count order by inhabitants_region desc) as ranking
from (select A3, count(A2) district_count, sum(A4) inhabitants_region from bank.district
group by A3
order by district_count) mandatory_alias_here;

-- ¯\_(ツ)_/¯ need yet another subquery to finish:
-- step 3 --> finally arrived to the final main query
select A3, amount_districts, inhabitants_region from (select A3, amount_districts, inhabitants_region, rank() over (partition by amount_districts order by inhabitants_region desc) as ranking
from (select A3, count(A2) amount_districts, sum(A4) inhabitants_region from bank.district
group by A3
order by amount_districts) mandatory_alias_here) as another_alias
where ranking = 1;

-- WATCH OUT: to use subqueries in the FROM statement you need to give it the alias, it is the name of the table you'll use in the main query.
-- In this case the necessary aliases are "mandatory_alias_here" and "another_alias"