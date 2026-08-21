-- ------------------- Vistas  ------------------------------

use sakila;
select * from peliculas_largas;

-- Modificar una vista ya creada
create or replace view peliculas_largas as
select * from film
where length > 120;

select * from peliculas_largas;

-- Eliminar vistas
drop view peliculas_largas;


-- ---------------- Preguntas de negocio -----------------

-- 1. ¿Qué películas largas (más de 120 minutos) tienen copias en inventario?

-- Filtrar películas largas
-- Simplificar esta consulta creando una vista
select * from film;
select * from inventory;

create view peliculas_largas_inventario as (
select
	distinct (f.film_id),
    f.title,
    f.description,
    f.length
from film f 
inner join inventory i 
	on f.film_id = i.film_id
where f.length > 120
);

-- ------------------------ Vista Materializada --------------------------

-- ------------------------ Indices -------------------------------
-- crear un indice en la tabla customer
create index ind_last_name
	on customer(last_name);
    
-- verificar si el indice funciona
explain select * from customer where last_name = 'DAVIS'; 
    


 