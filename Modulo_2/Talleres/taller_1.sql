use sakila;

show tables;

-- 1. Cuantas peliculas hay en la BD?
select * from film;
select count(distinct film_id) as cant_peliculas
from film;

-- 2. Cuantos empleados hay en la tienda?
select * from staff;
select count(distinct staff_id) as cant_empleados
from staff;

-- 3. Cuantos registros de rentas tenemos?
select * from rental;
select count(rental_id) from rental;

-- 4. Tenemos peliculas en cuantos idiomas?
select * from language;
select count(distinct language_id) as cant_lenguajes
from language;

-- 5. Trae la lista de nombres y apellidos de actores
select * from actor;
select 
	first_name,
	last_name
from actor;

-- 6. Trae en una sola columna el nombre y apellido de los actores
select 
	concat(first_name,' ',last_name) as 'Nombre Completo' 
from actor;

-- 7. Cual es la pelicula de mayor y menor duracion?
select * from film;

select 
	title,
    length
from film
where 
	length = (select max(length) from film) or 
    length = (select min(length) from film)
order by length desc;

-- 8. ¿Cuál es la película más vieja que tenemos y cuál es la más nueva?
select * from film;

select
	title,
    release_year
from film
where 
	release_year = (select max(release_year) from film) or
    release_year = (select min(release_year) from film)
order by release_year desc;

select distinct release_year from film;

-- 9. ¿Cuáles y cuántas categorías de películas tenemos?
select 
	distinct name
from category;

select 
	count(distinct name)
from category;

-- 10. ¿Cuántos clientes hay registrados en la base de datos?
select * from customer;

select
	count(distinct customer_id) as cant_clientes
from customer;

