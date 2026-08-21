use sakila;

-- ------------------ Opciones de like ------------------------    
-- Pregunta: Necesitamos un listado de las películas calificadas como 'G' o 'PG' 
-- que tengan una duración de renta estrictamente de 3 días para nuestra próxima promoción familiar.
select *
from film
where (rating = 'PG' or rating = 'G') and rental_duration = 3;

-- piso para representar caracteres
-- buscar peliculas cuyo nombre tenga la letra 'c' como segundo caracter
select *
from film
where title LIKE '_c%';

-- buscar peliculas cuyo nombre tenga la letra 'i' como penultimo caracter
select *
from film
where title LIKE '%i_';

select *
from film
where title LIKE '%i_';

-- ----------------- REGEX ---------------------
-- mostrar peliculas que tengan en el titulo la palabra 'LOVE'
select *
from film
where title regexp '\\bLOVE\\b';

-- -------------- ORDER BY -----------------------
-- cuando se utilizan muchos campos, se usan los numeros; en caso contrario se usan los nombres

select * from film
order by rental_duration; -- asc por defecto

select * from film
order by rental_duration asc, rental_rate asc; -- ordena por primer campo, luego por el segundo agrupado por el primero

select * from film
order by 7; -- admite el numero o el nombre del campo

select * from film
order by last_update desc; -- ordena por fechas

-- ----------------- Group by ---------------------
select 
	rating,
    avg(length),
    min(rental_rate)
from film
group by rating;

select 
	rating,
    release_year,
    avg(length),
    min(rental_rate),
    count(*)
from film
group by rating, release_year;

-- Respondiendo preguntas de negocio con la BD Sakila

-- 1. Necesitamos un listado de las películas calificadas como 'G' o 'PG' que tengan una duración 
-- de renta estrictamente de 3 días para nuestra próxima promoción familiar.
select *
from film
where rating in ('G', 'PG')
	and rental_duration = 3;

-- 2. 
select * from payment;

select 
	staff_id,
    sum(amount) total_generado
from payment
group by staff_id;

-- mostrar solo las ventas que sean mayor a 3
select 
	staff_id,
    sum(amount) as total_generado
from payment
where amount > 3
group by staff_id;

-- mostrar solo las ventas que sean mayor a 3 y ordenar por total generado
select 
	staff_id,
    sum(amount) as total_generado
from payment
where amount > 3
group by staff_id
order by total_generado desc;

-- mostrar solo las ventas que sean mayor a 3, ordenar por total generado y mostrar los clientes atendidos por emepleado
select 
	staff_id,
    customer_id,
    sum(amount) as total_generado
from payment
where amount > 3
group by staff_id, customer_id
order by total_generado desc;






