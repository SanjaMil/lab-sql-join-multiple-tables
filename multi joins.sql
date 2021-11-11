use sakila;
-- Lab | SQL Joins on multiple tables
-- 1. Write a query to display for each store its store ID, city, and country.

select store_id, city, country from address
left join city using (city_id)
left join store using (address_id)
left join country on city.country_id = country.country_id;

select * from store;
select * from address;

-- 2. Write a query to display how much business, in dollars, each store brought in.

select store_id, sum(amount) from store s
left join customer c using (store_id)
left join payment p on c.customer_id = p.customer_id
group by store_id;

-- 3. What is the average running time of films by category?
select * from film;
select name, round(avg(length), 0) from category c
left join film_category f using (category_id)
left join film fl on f.film_id = fl.film_id
group by 1;

-- 4. Which film categories are longest?
select name, round(avg(length), 0) from category c
left join film_category f using (category_id)
left join film fl on f.film_id = fl.film_id
group by 1
order by 2 desc
limit 10;


-- 5. Display the most frequently rented movies in descending order.
select * from film;

select title, rental_rate from film
order by rental_rate desc;


-- 6. List the top five genres in gross revenue in descending order.
create temporary table if not exists revenue_per_gender 
select * from payment p
left join rental r using (customer_id)
left join inventory i using (inventory_id)
left join film f using (film_id);

select * from revenue_per_gender ;
select name, round(sum(amount), 0) from film f
left join film_category fc on f.film_id = fc.film_id
left join category cr on fc.category_id = cr.category_id
left join inventory i on f.film_id = i.film_id
left join payment p on i.customer_id = p.customer_id
group by 1
order by 2 desc;

-- 7. Is "Academy Dinosaur" available for rent from Store 1?

select title, return_date, s.store_id from film f
left join inventory i using( film_id)
left join store s on i.store_id = s.store_id
left join rental r on i.inventory_id = r.inventory_id 
where date_format(convert(return_date, date), '%Y-%M-%D') < curdate() and title = 'Academy Dinosaur' and s.store_id = 1;