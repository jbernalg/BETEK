-- ---------------------- CTEs --------------------------------
use sakila;

-- ----------------- sintaxis ----------------------------
with muestra as (
	select * 
    from customer)
select *
from muestra;
    
-- juntar dos with
with muestra1 as ( -- primer with
	select * 
    from customer),
muestra2 as (     -- segundo with
	select * 
    from customer
)
select * from muestra1;

-- ------------------------------- Respondiendo preguntas de negocio ---------------------
-- 1.  Quienes son los clientes que han gastado mas de 150 en total?

-- solucion tradicional
select
	customer_id,
    sum(amount) total_gastado
from payment
group by customer_id
having sum(amount) > 150;

-- solucion con CTE
with ganancias as (
	select
		customer_id,
		sum(amount) total_gastado
	from payment
	group by customer_id
)
select * from ganancias
where total_gastado > 150; -- importante: utiliza siempre el alias para el select externo

-- 2. El equipo de adquisiciones quiere saber qué títulos de la base de datos no tienen ni una sola copia en 
-- el inventario para evaluar si deben comprarlos.
select * from inventory; 
select * from film;

-- solucion tradicional
select
	f.film_id,
    f.title Pelicula,
    i.inventory_id
from film f 
left join inventory i 
	on f.film_id = i.film_id
where i.inventory_id is null;

-- Solucion con CTE
with inventory_all as (
	select
		f.film_id,
		f.title Pelicula,
		i.inventory_id
	from film f 
	left join inventory i 
		on f.film_id = i.film_id
)
select * from inventory_all 
where inventory_id is null;   -- no incluir la i de referencia de la tabla inventory en el select externo

-- 3. ¿Qué películas tenemos disponibles en la Tienda 1 que están totalmente agotadas (o no existen) en la Tienda 2,
-- para evaluar una transferencia de stock

select * from inventory;

with tienda_uno as (
	select 
		*
	from inventory
	where store_id = 1
),
tienda_dos as (
	select 
		*
	from inventory
	where store_id = 2
)
select
	*
from tienda_uno t1 
left join tienda_dos t2
	on t1.film_id = t2.film_id
where t2.store_id is null;

-- ------------------------------ SUBCONSULTAS -----------------------------------

-- 1. Que peliculas tienen una duracion de alquiler mayor al promedio
select * from film;

select 
	film_id, 
    rental_duration
from film
where rental_duration > (select avg(rental_duration) from film);

-- 2. Que pelicula tiene el precio de alquiler mas alto?
select
	title,
    rental_rate
from film
where rental_rate = (
	select
		max(rental_rate) 
	from film
);
    