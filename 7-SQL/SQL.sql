use sakila;

-- 1a
select first_name,last_name from actor;

-- 1b
select UPPER(CONCAT(first_name,' ', last_name)) as "Actor Name" from actor;

-- 2a
 
 select actor_id, first_name, last_name from actor where upper(first_name) = "JOE";
 
 -- 2b
 select * from actor where upper(last_name) like '%GEN%';
 
 -- 2c

select * from actor where upper(first_name) like '%LI%' order by last_name, first_name ASC;

-- 2d
select country_id, country 
from country 
where country in ('Afghanistan', 'Bangladesh', 'China');

-- 3a

alter table actor
add description blob;

-- 3b

alter table actor
drop description;

-- 4a
select last_name, count(last_name) from actor group by last_name;

-- 4b

select last_name, count(last_name) from actor group by last_name  having count(last_name) > 1;
-- 4c

update actor
set first_name = 'HARPO'
where (first_name = 'GROUCHO' and last_name = 'WILLIAMS');

-- 4d

update actor
set first_name = 'GROUCHO'
where (first_name = 'HARPO' and last_name = 'WILLIAMS');

-- 5a

show create table address;

-- 6a

select staff.first_name, staff.last_name, address.address from staff inner join address on staff.address_id = address.address_id;

-- 6b

select staff.first_name, staff.last_name, sum(payment.amount) as 'Total Payment' from staff inner join payment on staff.staff_id = payment.staff_id group by staff.staff_id;

-- 6c

select film.title, count(film_actor.actor_id) as 'Number of Actors' from film inner join film_actor on film.film_id = film_actor.film_id group by film.title;


-- 6d

select count(inventory.film_id) as 'Number of Copies' from inventory inner join film on inventory.film_id = film.film_id where film.title = 'Hunchback Impossible';

-- 6e

select CONCAT(customer.first_name, ' ', last_name) as 'Customer', sum(payment.amount) from customer inner join payment on customer.customer_id = payment.customer_id group by customer.customer_id order by customer.last_name ASC;

-- 7a

select title from film where title like 'K%' or 'Q%' in (select language_id from language where name = 'English');

-- 7b

select concat(first_name, ' ', last_name) as 'Actor' from actor where actor_id in (select actor_id from film_actor where film_id in (select film_id from film where title = 'Alone Trip'))

-- 7c

select concat(customer.first_name, ' ', customer.last_name) as 'Customer', customer.email  from customer inner join address on customer.address_id = address.address_id inner join city on address.city_id = city.city_id inner join country on city.country_id = country.country_id where country.country = 'Canada';

-- 7d

select film.title from film inner join film_category on film.film_id = film_category.film_id inner join category on film_category.category_id = category.category_id where category.name = 'Family';

-- 7e

select title from film order by rental_rate DESC;

-- 7f
select store.store_id, sum(payment.amount) as 'Total Business' from store inner join payment on store.manager_staff_id = payment.staff_id group by store.manager_staff_id;

-- 7g

select store.store_id, city.city, country.country from store inner join address on store.address_id = address.address_id inner join city on address.city_id = city.city_id inner join country on city.country_id = country.country_id;

-- 7h 

select category.name, sum(payment.amount) from category inner join film_category on category.category_id = film_category.category_id inner join inventory on film_category.film_id = inventory.film_id inner join rental on inventory.inventory_id = rental.inventory_id inner join payment on rental.rental_id = payment.rental_id group by category.name order by sum(payment.amount) DESC limit 5;

-- 8a

create view Film_Category_Gross_Revenue as select category.name, sum(payment.amount) from category inner join film_category on category.category_id = film_category.category_id inner join inventory on film_category.film_id = inventory.film_id inner join rental on inventory.inventory_id = rental.inventory_id inner join payment on rental.rental_id = payment.rental_id group by category.name order by sum(payment.amount) DESC limit 5;

-- 8b

select * from Film_Category_Gross_Revenue;

-- 8c

drop view Film_Category_Gross_Revenue;   
