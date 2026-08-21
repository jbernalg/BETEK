-- Taller 3 SQL

use sakila;
show tables;

-- --------------- Parte 1: funciones de fecha ------------------------

-- 1. Encuentra las películas que fueron lanzadas hace exactamente 18 años desde la fecha actual.

select * from film;

select 
	title,
    release_year
from film
where release_year = year(curdate()) - 18;

-- 2. Calcula cuántos días han pasado desde el alquiler más reciente en la base de datos.
select 
    datediff(curdate(), max(rental_date)) dias_pasados
from rental;

-- 3. Extrae el año en que se realizó la primera renta registrada en la base de datos.
select
	year(min(rental_date)) anio_primera_renta
from rental;

-- 4. Muestra el día de la semana en que se realizó la mayor cantidad de rentas.
select
    dayname(rental_date) nombre_dia,
    count(*) as rentas_total
from rental
group by nombre_dia
order by rentas_total desc
limit 1;
    
select * from rental;

-- 5. Muestra todas las películas alquiladas entre el 1 de enero de 2005 y el 31 de diciembre de 2005
select 
	rental_id,
    rental_date
from rental
where  rental_date between '2005-01-01' and '2005-12-31';

-- --------------------------- Parte 2 ---------------------------------
-- 1. Trae una lista de los clientes cuyo nombre comience con la letra 'J'.
select * from customer;

select
	first_name,
    last_name
from customer 
where first_name like 'J%';

-- 2. Muestra el nombre y apellido de los empleados, concatenados en una sola columna y en mayúsculas.
select
	concat(upper(first_name),' ',upper(last_name)) nombre_empleado
from staff;

-- 3. Reemplaza todas las ocurrencias de la palabra "ACTION" por "AVENTURA" en los nombres de las categorías de películas.
select * from category;

update category
set name = 'Aventura'
where name = 'Action';

-- 4. Encuentra los actores cuyo nombre tenga exactamente 5 letras.
select * from actor;

select
	first_name
from actor
where length(first_name) = 5;

-- otra solucion
select
	first_name
from actor
where first_name like '_____';

-- 5. Muestra los primeros tres caracteres del título de cada película.
select
	substring(title, 1, 3) AS primeros_tres_caracteres
from film;

-- ----------------------- Parte 3 --------------------------------

-- 1. Calcula el número total de películas alquiladas por cada cliente.
select * from rental;

select
	customer_id,
    count(*) peliculas_alquiladas
from rental
group by customer_id;

-- 2. Encuentra el monto total recaudado por rentas en cada tienda.
select * from payment;
select * from staff;

select
    s.store_id,
    sum(amount) total_recaudado
from payment p	
join staff s on 
	p.staff_id = s.staff_id
group by s.store_id;

-- otra alternativa
select
	staff_id,
    sum(amount) total_recaudado
from payment
group by staff_id;

-- 3. Muestra el promedio de la duración de las películas por cada categoría.
select * from film;
select * from film_category;
select * from category;

select
	c.name categoria,
    avg(f.length) promedio_duracion
from film f
join film_category fc on
	f.film_id = fc.film_id
join category c on
	fc.category_id = c.category_id
group by categoria;

-- 4. Calcula el ingreso total generado por cada película en la base de datos.
select * from payment;
select * from rental;
select * from inventory;
select * from film;

select
	f.title pelicula,
    sum(p.amount) as total_ingreso
from payment p 
join rental r on
	p.rental_id = r.rental_id
join inventory i on
	r.inventory_id = i.inventory_id
join film f on
	i.film_id = f.film_id
group by pelicula;

-- 5. Encuentra la categoría con la mayor cantidad de películas y muestra cuántas películas pertenecen a esa categoría.
select * from film;
select * from film_category;
select * from category;

select
	c.name categoria,
    count(fc.film_id) cantidad
from category c 
join film_category fc on
	fc.category_id = c.category_id
group by categoria
order by cantidad desc
limit 1;