-- -------------------------- SUBCONSULTAS --------------------------------

use sakila;

-- ----------------------------- Subconsulta en el where ------------------------------------------
-- Trae clientes que alquilaron después de la fecha '2005-08-01'.
select
	first_name,
    last_name
from customer
where customer_id in (
	select
		customer_id
	from rental
    where rental_date > '2005-08-01'
);

-- ----------------------- Subconsulta escalar ---------------------------------------
-- Películas con tarifa mayor al promedio general
select
	title,
    rental_rate
from film
where rental_rate > (
	select avg(rental_rate) from film
);

-- -------------------- Subconsulta en el from ----------------------------------
-- Calcular el gasto por cliente, luego promediar por tienda
select
	store_id,
    avg(total_gastado) promedio_por_cliente
from (
	select
		s.store_id,
        c.customer_id,
        sum(p.amount) total_gastado
	from payment p 
    inner join customer c 
		on p.customer_id = c.customer_id 
	inner join store s 
		on c.store_id = s.store_id
	group by s.store_id, c.customer_id
) gasto_por_cliente
group by store_id;

-- ---------------------- Subconsulta correlacionada ---------------------------------------
-- Clientes que tienen al menos un alquiler sin devolver.
select
	c.customer_id,
    c.first_name
from customer c
where exists (
	select
		1
	from rental r 
    where r.customer_id = c.customer_id
		and r.return_date is null
);

-- ------------------------------- Subconsulta con NOT IN -------------------------------------
-- Clientes que nunca han alquilado.
select
	customer_id,
    first_name
from customer
where customer_id not in (
	select
		customer_id
	from rental
    where customer_id is not null
);
