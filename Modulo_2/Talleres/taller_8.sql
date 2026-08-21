-- ----------------------------- Taller 8 -----------------------------------
use sakila;

-- Ejercicio 1 (Subconsultas): Obtén los títulos de todas las películas en las que ha actuado la actriz "UMA WOOD". 
-- Pista: Necesitas conectar actor -> film_actor -> film. Usa subconsultas en el WHERE. 
select * from actor;
select * from film_actor;
select * from film;

select
	f.title,
    concat(a.first_name,' ',a.last_name) nombre_actor
from actor a 
inner join film_actor fa 
	on a.actor_id = fa.actor_id
inner join film f 
	on fa.film_id = f.film_id
where concat(a.first_name,' ',a.last_name) = (
	select
		concat(first_name,' ',last_name) nombre
	from actor
	where first_name = 'UMA' and last_name = 'WOOD'
);

-- Ejercicio 2 (Subconsultas + CTE): Encuentra los clientes que han alquilado al menos una película de la categoría 'Action'. 
-- Pista: Intenta definir una CTE que obtenga todos los film_id de la categoría 'Action' y luego úsala para filtrar la tabla inventory y rental. 
select * from category;
select * from film_category;

-- cambiar categoria 'Avventura' por 'Action'
update category set name = 'Action' where category_id = 1; 
select * from category;

-- CTE
with categoria_peliculas as (
	select
		fc.film_id,
        c.name
	from category c
	inner join film_category fc 
		on c.category_id = fc.category_id
)
select * from categoria_peliculas
where name = 'Action';

select * from inventory;
select * from rental;

-- Subconsulta + CTE
select
	r.customer_id,
    count(r.rental_id) total_rentas
from rental r 
inner join inventory i 
	on r.inventory_id = i.inventory_id
where i.film_id in (
	with categoria_peliculas as (
	select
		fc.film_id,
        c.name
	from category c
	inner join film_category fc 
		on c.category_id = fc.category_id
	)
	select film_id from categoria_peliculas
	where name = 'Action'
)
group by r.customer_id
having count(r.rental_id) > 0;

-- 3. Identifica al cliente que ha gastado más dinero en total. Debes mostrar su nombre completo y el monto total gastado, 
-- pero solo si ese monto es mayor al promedio de gasto de todos los clientes.

-- Crea una CTE para calcular el gasto total por cliente.
select * from payment;
select * from customer;

with gasto_clientes as (
	select
		c.customer_id,
		concat(c.first_name,' ',c.last_name) nombre_cliente,
		sum(p.amount) gasto_total
	from customer c 
	inner join payment p 
		on c.customer_id = p.customer_id
	group by c.customer_id
)
select * from gasto_clientes;


-- Crea otra CTE para calcular el promedio de esos totales.
with gasto_clientes as (
	select
		c.customer_id,
		sum(p.amount) gasto_total
	from customer c 
	inner join payment p 
		on c.customer_id = p.customer_id
	group by c.customer_id
),
estadisticas_gasto as (
	select
		max(gasto_total) gasto_maximo,
		avg(gasto_total) gasto_promedio
	from gasto_clientes
)
select * from estadisticas_gasto;

-- Une ambas en tu consulta final.
with gasto_clientes as (
	select
		c.customer_id,
		concat(c.first_name,' ',c.last_name) nombre_cliente,
		sum(p.amount) gasto_total
	from customer c 
	inner join payment p 
		on c.customer_id = p.customer_id
	group by c.customer_id
),
estadisticas_gasto as (
	select
		max(gasto_total) gasto_maximo,
		avg(gasto_total) gasto_promedio
	from gasto_clientes
)
select
	gc.nombre_cliente,
	gc.gasto_total
from gasto_clientes gc
inner join estadisticas_gasto eg 
	on gc.gasto_total = eg.gasto_maximo
where gc.gasto_total > eg.gasto_promedio;


-- 4. Queremos saber cuántas películas de "duración larga" tiene cada categoría.

-- Define una CTE llamada peliculas_largas que seleccione las películas con una duración superior a 120 minutos.
select * from film;
select * from film_category;
select * from category;

with peliculas_largas as (
	select
		f.film_id,
		f.length duracion
	from film f 
    where f.length > 120
)
select * from peliculas_largas;


-- En la consulta principal, une esta CTE con film_category y category para contar cuántas hay por cada nombre de categoría.
with peliculas_largas as (
	select
		f.film_id,
		f.length duracion
	from film f 
    where f.length > 120
)
select 
	c.category_id,
    c.name categoria,
    count(fc.category_id) cant_por_categoria
from peliculas_largas pl
inner join film_category fc 
	on pl.film_id = fc.film_id 
inner join category c 
	on fc.category_id = c.category_id
group by c.category_id;
