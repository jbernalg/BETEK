use sakila;
show tables;

-- 1. ¿Qué películas tienen una clasificación (rating) "PG-13"?
select
	title,
    rating
from film
where rating = 'PG-13';

SHOW COLUMNS FROM film LIKE 'rating'; -- valores posibles en el campo rating

-- 2. ¿Qué clientes viven en el país "Canada"?
select * from customer;

select
	c.customer_id,
    concat(c.first_name,' ',c.last_name) as 'Nombre Cliente',
    co.country
from customer c
join address a on c.address_id = a.address_id
join city ci on a.city_id = ci.city_id
join country co on ci.country_id = co.country_id
where co.country = 'Canada';

-- 3. ¿Qué películas tienen una duración (length) mayor a 120 minutos?
select * from film;

select
	title,
    length
from film
where length > 120;

-- 4. ¿Qué actores tienen como apellido "CHASE"?
select * from actor;

select
	actor_id,
    concat(first_name,' ', last_name) as 'Nombre Actor'
from actor
where last_name = 'CHASE';

-- 5. ¿Qué películas de la categoría "Action" cuestan más de $2.99 de renta?
select * from film;
select * from category;

select
	f.title as 'Nombre Pelicula',
    ca.name as 'Categoria',
    f.rental_rate as Renta
from film f
join film_category fc on f.film_id = fc.film_id
join category ca on fc.category_id = ca.category_id
where ca.name = 'Action' and f.rental_rate > 2.99;

-- 6. ¿Qué clientes están activos (active = 1) y pertenecen a la tienda (store_id) 1?
select * from customer;

select
	customer_id,
	concat(first_name,' ',last_name) as 'Nombre Cliente'
from customer
where active = 1 and store_id = 1;

-- 7. ¿Qué películas son "PG" y tienen un costo de reemplazo (replacement_cost) menor a $15?
select * from film;

select
	film_id,
    title,
    replacement_cost
from film
where rating='PG' and replacement_cost < 15;

-- 8. ¿Qué rentas se hicieron entre el 1 y el 15 de julio de 2005?
select * from rental;

select
	rental_id
from rental
where rental_date >= '2005-07-01' and rental_date < '2005-07-16';

-- 9. ¿Cuántas películas hay en total en el catálogo?
select * from film;

select 
	count(*)
from film;

-- 10. ¿Cuál es el precio promedio de renta de todas las películas?
select * from film;

select
	round(avg(rental_rate),2) promedio_renta
from film;

-- 11. ¿Cuál es el pago (payment) más alto que ha hecho un cliente?
select * from payment;

select
	max(amount) pago_mas_alto
from payment;

-- 12. ¿Cuánto dinero total se ha recaudado en pagos (payment)?
select
	sum(amount) dinero_total
from payment;

-- 13. ¿Cuántas películas hay por cada clasificación (rating)?
select * from film;

select
	rating,
    count(*)
from film
group by rating;

-- 14. ¿Cuál es el total de pagos recaudados por cada tienda (store_id)?
select * from payment;
select * from store;

select
	s.store_id,
    sum(amount) total_recaudado
from payment p 
join staff s 
	on p.staff_id = s.staff_id
group by s.store_id;

-- 15. ¿Cuántas rentas ha hecho cada cliente (customer_id)?
select * from rental;

select
	customer_id,
    count(rental_id) cant_rentas
from rental
group by customer_id
order by cant_rentas desc;
