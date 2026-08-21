-- Preguntas de negocio

use sakila;

-- ¿Cuál fue el pago más alto que procesó cada empleado por año?
select
	staff_id,
    year(payment_date) anio,
    max(amount) pago_mas_alto
from payment
group by staff_id, anio
order by anio, pago_mas_alto;

-- ¿Cuántos alquileres hubo por año y mes?
select
	year(rental_date) anio,
    month(rental_date) mes,
    count(rental_id) cant_alquiler
from rental
group by anio, mes;

-- ¿Qué clientes han gastado más de $150?


-- substring_index: toma una cadena y la divide en dos partes usando un caracter especifico
-- -1 para la parte despues del caracter
-- 1 para la parte antes del caracter
select
	email,
	substring_index(email, '@', 1),
    substring_index(email, '@', -1)
from customer;

-- ¿Cuántos clientes hay por dominio de correo?
select
	substring_index(email, '@', -1) dominio,
    count(*) cant_clientes
from customer
group by dominio;

-- El equipo de marketing quiere realizar una campaña de correos segmentada alfabéticamente. 
-- Necesitan un reporte que muestre cuántos clientes activos se registraron en febrero de 2006, agrupados por la inicial de su apellido. 
-- El resultado debe mostrar la inicial y la cantidad de clientes, ordenado de mayor a menor volumen

select
    substring(last_name, 1, 1) inicial,
	count(customer_id) cant_clientes
from customer
where active = 1 
	and create_date between '2006-02-01' and '2006-02-28'
group by inicial
order by cant_clientes desc;