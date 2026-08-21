use sakila;
show tables;

-- ----------------------- Parte 1: El Arte de Resumir Datos (Funciones de Agregación) ----------------------------

-- 1. ¿Cuántos pagos se han registrado en total? Usamos COUNT() para contar todas las filas en la tabla payment.
select * from payment;

select
	count(payment_id) total_pagos_realizados
from payment;

-- 2. ¿Cuál es el ingreso total por alquileres? Usamos SUM() para sumar todos los montos (amount) de la tabla payment.
select
	sum(amount) total_alquiler
from payment;

-- 3. ¿Cuál es el pago promedio, el más alto y el más bajo? Aquí combinamos AVG(), MAX() y MIN() en una sola consulta.
select
	round(avg(amount),2) pago_promedio,
    max(amount) pago_mas_alto,
    min(amount) pago_mas_bajo
from payment;


-- ------------------------ Parte 2: Agrupando Información (GROUP BY y HAVING) -----------------------------------

-- 1. ¿Cuántas películas hay para cada clasificación (rating)? Agrupamos por  la columna rating y contamos las películas en cada grupo.
 select
	rating,
    count(*)
from film
group by rating;


-- 2. ¿Cuál es el ingreso total generado por cada empleado (staff_id)? Agrupamos por staff_id y sumamos los pagos que cada uno procesó. 
show tables;

select 
	staff_id,
    SUM(amount) tota_ingreso
from payment
group by staff_id;

-- 3. ¿Qué clientes han gastado más de $150? Primero agrupamos por cliente, sumamos sus pagos y luego, con HAVING, 
-- filtramos para quedarnos solo con aquellos cuyo total supera 150. 
select * from payment;

select
	customer_id,
    sum(amount)
from payment
group by customer_id
having sum(amount) > 150;


-- 4. ¿Cuál es el ingreso total generado por el empleado con ID 1, para cada cliente? Aquí usamos WHERE para filtrar los datos antes de agrupar. 
-- Solo consideramos los pagos procesados por staff_id = 1. 
select
	staff_id,
    customer_id,
    sum(amount) ingreso_total
from payment
where staff_id = 1
group by customer_id;

-- ---------------------------------- Parte 3: Manipulando Texto (Funciones de Cadena) -------------------------------------

-- 1. Crear el nombre completo de los actores. Usamos CONCAT() para unir el nombre y el apellido.
select
	concat(first_name, ' ',last_name) Nombre_Actor
from actor;

-- 2. Mostrar los títulos de las películas en mayúsculas y su longitud. Usamos UPPER() para convertir a mayúsculas y LENGTH() para obtener la longitud.
select
	upper(title) Titulo,
    length(title) Longitud_Titulo
from film;

-- 3. Mostrar un resumen de la descripción de las películas. Usamos SUBSTRING() para extraer una parte de una cadena. En este caso, 
-- los primeros 50 caracteres de la descripción, seguidos de puntos suspensivos.
select
	concat(substring(description, 50), '...') Breve_descripcion
from film;

-- ---------------------------------- Parte 4: Trabajando con Fechas (Funciones de Fecha) -----------------------------------------

-- 1. Extraer el año, mes y día de los alquileres. Usamos YEAR(), MONTH() y DAY() sobre la columna rental_date. 
select * from rental;

select
	rental_date,
	year(rental_date) Anio,
    month(rental_date) Mes,
    day(rental_date) Dia
from rental;

-- 2. Calcular los días que un cliente tuvo una película alquilada. DATEDIFF() calcula la diferencia en días entre dos fechas.
select
	customer_id,
    datediff(return_date, rental_date) dias_alquilados
from rental
order by dias_alquilados;

-- deteccion de valores nulos en return_date
SELECT COUNT(*) AS total_nulos
FROM rental
WHERE return_date IS NULL;

-- --------------------------------- Parte 5: ¡Ahora te toca a ti! ---------------------------------------

-- 1. Calcula la duración promedio (length) de las películas, así como la duración de la película más larga y la más corta.
select
	avg(length) duracion_prom,
    max(length) duracion_mas_larga,
    min(length) duracion_mas_corta
from film;

-- 2. Muestra el email de cada cliente (customer) pero en letras minúsculas. Llama a la columna email_minusculas.
select
	lower(email) email_minuscula
from customer;

-- 3. ¿En qué día de la semana (DAYNAME) se realizaron la mayor cantidad de pagos? Muestra el nombre del día y la cantidad de pagos. (Pista: GROUP BY).
select * from payment;

select
    dayname(payment_date) nombre_dia,
    count( dayname(payment_date)) cant_pagos
from payment
group by nombre_dia
order by cant_pagos desc
limit 1;

-- 4. Encuentra las películas (film_id) que han sido alquiladas más de 30 veces. Muestra el film_id y el número de veces que ha sido alquilada.
select * from rental;
select * from inventory;

select
	film_id,
    count(film_id) veces_alquiladas
from rental r
join inventory i 
	on r.inventory_id = i.inventory_id
group by film_id
having veces_alquiladas > 30;

-- 5. Obtén un reporte que muestre, para cada cliente (customer_id), su nombre y apellido concatenados, el total de dinero que ha
-- gastado y el número total de alquileres que ha realizado. Muestra solo a los clientes que han realizado más de 35 alquileres.
select * from customer;
select * from payment;
select * from rental;

select
	c.customer_id,
    concat(c.first_name, ' ', last_name) Nombre_Cliente,
    sum(p.amount) Total_Gastado,
    count(distinct r.rental_id) Cant_Alquileres
from customer c
join payment p 
	on c.customer_id = p.customer_id
join rental r 
	on p.rental_id = r.rental_id
group by c.customer_id
having Cant_Alquileres > 35;