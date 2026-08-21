-- ------------------- 	TALLER 6 JOINS ---------------------------------
use sakila;

-- 1. Listar el nombre completo de los clientes y la cantidad de alquileres que han realizado. 
-- Agrupar por cliente y mostrar solo aquellos que hayan hecho más de 5 alquileres.

select * from customer;
select * from payment;
select * from rental;

select
	c.customer_id,
	concat(c.first_name,' ',last_name) nombre_cliente,
    count(r.rental_id) cant_alquileres
from customer c 
join rental r
	on c.customer_id = r.customer_id
group by c.customer_id
having count(r.rental_id) > 5;

-- 2. Mostrar todos los clientes, hayan alquilado o no, junto con la cantidad de alquileres realizados.
-- Agrupar por cliente y mostrar solo aquellos con 3 o más alquileres.
select
	c.customer_id,
	concat(c.first_name,' ',c.last_name) nombre_cliente,
    count(r.rental_id) cant_alquileres
from customer c 
left join rental r
	on c.customer_id = r.customer_id
group by c.customer_id, nombre_cliente
having count(r.rental_id) >= 3
order by cant_alquileres desc;

-- 3. Listar todos los títulos de películas junto con la cantidad de veces que han sido alquiladas. 
-- Incluir las películas que no se han alquilado nunca. Mostrar solo aquellas que sí tienen al menos una renta.

select * from film;
select * from inventory;
select * from rental;

select
	f.title,
    count(r.rental_id) cant_rentas
from film f
left Join inventory i
	on f.film_id = i.film_id
left join rental r
	on i.inventory_id = r.inventory_id
group by f.title
having cant_rentas >= 1
order by cant_rentas asc;

-- 4. Listar todas las películas que han sido alquiladas y cuántas veces. Usar RIGHT JOIN entre rental e inventory, agrupando por título. 
-- Mostrar solo las que se han alquilado más de 10 veces.
select
	f.title,
    count(r.rental_id) cant_rentas
from film f
inner join inventory i 
	on f.film_id = i.film_id
right join rental r 
	on i.inventory_id = r.inventory_id
group by f.title
having cant_rentas > 10;

-- 5. Unir dos listas: una con clientes de la tienda 1 y otra con los de la tienda 2. Agrupar por tienda y contar cuántos clientes hay por cada una. 
-- Mostrar solo las tiendas con más de 200 clientes.
select * from customer;

select
	store_id,
    count(*) cant_clientes
from customer
where store_id = 1
group by store_id
having count(*) > 200
union
select
	store_id,
    count(customer_id) cant_clientes
from customer
where store_id = 2
group by store_id
having count(*) > 200;

-- 6.  Unir la lista de clientes que han alquilado películas con la de quienes no han alquilado. 
-- Agrupar por tipo ("alquiló" vs. "no alquiló") y contar cuántos clientes hay en cada grupo.
select
	case
		when r.customer_id is null then 'No alquilo' else 'Alquilo'
	end as tipo,
    count(distinct c.customer_id) cant_clientes
from customer c
left join rental r
	on c.customer_id = r.customer_id
group by tipo;

-- otra alternativa
select
	tipo,
    count(*) cant_clientes
from (
	select
		customer_id,
		'Alquilo' tipo
	from customer
	where customer_id in (select distinct customer_id from rental)

	union all

	select
		customer_id,
		'No Alquilo' tipo
	from customer
	where customer_id not in (select distinct customer_id from rental)
) clientes_clasificados
group by tipo;

-- 7. Mostrar el nombre de los empleados y la cantidad de pagos que han procesado. Usar JOIN entre payment, staff y rental. 
-- Agrupar por empleado y mostrar solo aquellos que han procesado más de 200 pagos.
select * from staff;
select * from payment;

select
	s.staff_id,
    concat(s.first_name,' ',last_name) nombre_empleado,
    count(payment_id) cant_transacciones
from staff s
inner join payment p 
	on s.staff_id = p.staff_id
group by s.staff_id
having cant_transacciones > 200;

-- 8. Listar todos los actores y la cantidad de películas en las que han participado. Usar RIGHT JOIN entre film_actor y actor. 
-- Agrupar por actor y mostrar solo aquellos con más de 20 películas.
select * from actor;

select
	a.actor_id,
	concat(a.first_name,' ',a.last_name) nombre_actor,
    count(fa.film_id) cant_peliculas
from film_actor fa
right join actor a 
	on fa.actor_id = a.actor_id
group by a.actor_id
having cant_peliculas > 20;