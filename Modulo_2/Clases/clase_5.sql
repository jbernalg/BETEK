use sakila;

-- Pregunta de negocio
-- ¿Qué clasificaciones (rating) tienen un promedio de duración de alquiler superior a 5 días y cuentan con al menos 50 películas?
select * from film;

select
	rating,
  avg(rental_duration) duracion_prom,
  count(film_id) cant_peliculas
from film
group by rating
having duracion_prom > 5 and cant_peliculas >= 50;

-- ------------------- Funciones de Fecha -----------------------------

-- mostrar el tipo de datos de los campos de la tabla film
describe film;

-- seleccionar la fecha de un campo timestamp
select
	title,
	date(last_update) DIA,
    last_update
from film;

select
	year(last_update),
    count(*)
from film;

-- agregar dias a una fecha
select
	title,
    date_add(last_update, interval 3 day),
    last_update
from film;

select * from llamadas_enero;

-- fecha y hora actual
select now();

-- extender fecha y hora actual en una tabla
select
	title,
    now()
from film;

-- hora actual
select hour(now());

-- ----------------------- Funciones de Cadena --------------------------

describe film;

-- convertir titulo a minuscula
select
	lower(title)
from film;

-- unir dos cadenas
select
	concat(title,' - ',special_features)
from film;

-- quitar espacios en blanco trim

-- reemplaza una cadena por otra
select
	title,
    replace(title, 'á', 'a')
from film;

