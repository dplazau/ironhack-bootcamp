-- queries-06

use sakila;

show variables like 'local_infile';
set global local_infile = 1;
show variables like 'secure_file_priv';
set sql_safe_updates = 1;

load data infile 'C:/ProgramData/MySQL/MySQL Server 8.0/Uploads/films_2020.csv'
into table films_2020
fields terminated by ',';

select * from films_2020;

update films_2020
set rental_duration = 3, rental_rate = 2.99, replacement_cost = 8.99;