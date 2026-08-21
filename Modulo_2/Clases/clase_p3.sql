use sakila;
select * from payment;
select * from rental;
select * from customer;

-- ------------- Funciones de fechas -----------------
select * from rental;

-- DATETIME: (2005-05-24 22:53:30)
-- DATE: (2026-07-28)
-- TIME: (14:30:00)
-- YEAR: (2007)
-- month
-- day

select
	rental_date,
    year(rental_date) anio,
    month(rental_date) mes,
    monthname(rental_date),
    day(rental_date) dia,
    dayname(rental_date) nombre_dia
from rental;

-- mostrar el nombre del dia junto a la fecha (el dia es jueves 25 julio)
select
	rental_date,
    concat('El dia es ',dayname(rental_date),' ',day(rental_date),' ',monthname(rental_date)) fecha_personalizada
from rental;

-- codigo que permite trabajar las fechas en espaniol
SET lc_time_names = 'es_CO';
select
	rental_date,
    concat('El dia es ',dayname(rental_date),' ',day(rental_date),' ',monthname(rental_date)) fecha_personalizada
from rental;


-- obtener hora
select
	rental_date,
    hour(rental_date) hora, -- hora
    time(rental_date) hora_completa-- hora completa
from rental;

-- cantidad de dias rentadas cada pelicula
select
	rental_date,
    return_date,
    datediff(return_date, rental_date) dias_rentado
from rental;

-- Funciones de cadenas

-- Funciones de agregacion