-- -------------------- Taller 9 -----------------------
use sakila;

-- 1. Basarse en la del Ejercicio 1 
-- Modifica esa consulta para mostrar el nombre completo de cada cliente, su gasto total y una nueva columna llamada nivel_cliente 
-- que los clasifique como: 
-- 'Premium' si han gastado más de $150. 
-- 'Regular' si han gastado entre $100 y $150. 
-- 'Ocasional' si han gastado menos de $100. 
-- Pista: La forma más limpia de hacerlo es usando un CTE para el cálculo del gasto y luego un CASE en la consulta final.
select * from film;

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
select
	nombre_cliente,
    gasto_total,
    case
		when gasto_total > 150 then 'Premium'
        when gasto_total between 100 and  150 then 'regular'
        else 'Ocasional'
    end as nivel_cliente
from gasto_clientes;


-- 2. Crea una vista llamada vista_film_detalles que contenga el título (title), el idioma (name de language) y la categoría 
-- (name de category) de cada película. 

select * from film;
select * from language;
select * from category;
select * from film_category;

create or replace view vista_film_detalles as
select
	f.title pelicula,
    l.name lenguaje,
    c.name categoria
from film f
inner join language l 
	on l.language_id = f.language_id
inner join film_category fc 
	on f.film_id = fc.film_id
inner join category c 
	on fc.category_id = c.category_id;
    
select * from vista_film_detalles;

-- Una vez creada la vista, úsala para responder a la pregunta: ¿Cuántas películas de la categoría 'Action' están en 'English'? 
select
	count(*)
from  vista_film_detalles
where categoria = 'Action'
	and lenguaje = 'English';


 -- 3. Adapta esa consulta para que devuelva el Top 5 de actores que han aparecido en más películas, pero únicamente de la categoría 'Family'. 
 -- El resultado debe mostrar el nombre completo del actor y la cantidad de películas.  
-- Pista: Un CTE puede ayudarte a aislar primero todas las películas de la categoría 'Family'.

select * from actor;

with peliculas_familiares as (
select
	f.film_id
from film f 
inner join film_category fc
	on f.film_id = fc.film_id 
inner join category c 
	on fc.category_id = c.category_id
where c.name = 'Family'
)
select
	a.actor_id,
	concat(a.first_name,' ',a.last_name) actor,
    count(*) apariciones
from peliculas_familiares pf
inner join film_actor fa 
	on pf.film_id = fa.film_id 
inner join actor a 
	on fa.actor_id = a.actor_id 
group by a.actor_id
order by apariciones desc
limit 5;






