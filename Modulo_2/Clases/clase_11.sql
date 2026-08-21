-- -------------------- Subconsultas ------------------------
use sakila;

-- 1. Cuales peliculas duran mas que el promedio pero tienen un precio de alquiler menor al promedio?
select * from film;

-- primera subconsulta
select
	film_id,
    length duracion
from film 
where length > (select avg(rental_duration) from film);

-- segunda subconsulta
select
	film_id,
    rental_rate
from film 
where rental_rate < (select avg(rental_rate) from film);

-- consulta general
select
	film_id,
	title,
    length,
    rental_rate
from film 
where length > (select avg(rental_duration) from film)     -- primera subconsulta
	and rental_rate < (select avg(rental_rate) from film); -- segunda subconsulta
    
-- 2.  Encontrar todas las peliculas que esten en inventario
-- de la tabla pelicula, filtrar en la tabla inventario

-- subconsulta
select distinct(film_id) from inventory;  

-- consulta general
select
	*
from film
where film_id in (
	select distinct(film_id) from inventory -- subconsulta
);

-- 3. Cuales son los clientes que han realizado al menos un pago de alto valor (superior a 10$)

-- subconsulta
select distinct(customer_id) from payment
where amount > 10;

-- consulta general
select 
	customer_id,
	first_name,
    last_name
from customer
where customer_id in (
	select distinct(customer_id) from payment
	where amount > 10
);

-- 4. selecciona las peliculas que tienen mas de 5 copias en el inventario
select * from inventory;

-- subconsulta
select
	film_id,
    count(*)
from inventory 
group by film_id;

-- consulta general
select * from (
	select
		film_id,
		count(*) cant_copias
	from inventory 
	group by film_id
) as t
where t.cant_copias > 5;

-- solucion con CTE
with t as (
select
	film_id,
	count(*) cant_copias
from inventory 
group by film_id
) 
select * from t 
where t.cant_copias > 5;
