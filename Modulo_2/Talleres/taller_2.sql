-- Taller 2

-- -------------------- Parte 1 ------------------------------

-- 1. El gerente quiere una lista de películas que sean aptas para todo público (rating = 'G') 
-- y que además tengan una duración (length) superior a 90 minutos.

use sakila;

select
	title,
    rating,
    length
from film
where rating = 'G' and length > 90;

-- 2. Necesitamos identificar a los clientes que están activos (active = 1) O que pertenecen a la tienda 1 (store_id = 1). 
-- Esto nos ayudará a dirigir una nueva campaña de marketing

select
	first_name,
    last_name,
    email,
    active,
    store_id
from customer
where active = 1 or store_id = 1;

-- 3. Encuentra los pagos (payment) que fueron de más de $5.00 (amount > 5.00) 
-- Y que se realizaron después del 1 de marzo de 2007 (payment_date > '2007-03-01').

select 
	payment_id,
    amount,
    payment_date
from payment
where amount > 5 and payment_date > '2007-03-01';

-- ------------------- Parte 2 -----------------------------
-- 1.  Queremos una lista de todas las películas cuya clasificación (rating) sea 'G', 'PG' o 'PG-13'.
select 
	title, 
    rating
from film
where rating in ('G', 'PG', 'PG-13');

-- 2.  El gerente quiere ver la información de las direcciones que se encuentran en los distritos ('California', 'Texas' o 'Alberta').
select
	address,
    district,
    postal_code
from address
where district in ('California', 'Texas', 'Alberta');

-- 3. Genera una lista de actores (actor) cuyo nombre (first_name) no sea 'PENELOPE', 'NICK' o 'ED'.
select 
	first_name,
    last_name
from actor
where first_name not in ('PENELOPE', 'NICK', 'ED');

-- ------------------ Parte 3 ---------------------------

-- 1. Encuentra las 10 películas con la mayor duración (length).
select
	title,
    length
from film
order by length desc
limit 10;

-- 2. Muestra los 5 pagos (payment) que se han realizado más recientemente.
select
	payment_id, 
    amount, 
    payment_date
from payment
order by payment_date desc
limit 5;

-- 3. Lista a todos los clientes (customer) ordenados alfabéticamente por su apellido (last_name) 
-- y luego por su nombre (first_name). Muestra solo los primeros 20.

select
	last_name,
    first_name,
    email
from customer
order by last_name, first_name desc
limit 20;

-- ---------------- Parte 4 -----------------------

-- 1. Encuentra todos los actores (actor) cuyo nombre (first_name) comienza con la letra 'A'.
select
	first_name,
    last_name
from actor
where first_name like 'A%';

-- 2. Busca todas las películas (film) que tengan la palabra 'LOVE' en su título (title).
select
	title,
    description
from film
where title like '%LOVE%';

-- 3. Encuentra a todos los clientes (customer) cuyo apellido (last_name) termina con 'SON'.
select
	first_name,
    last_name
from customer
where last_name like '%SON';

-- --------------------- Parte 5 ------------------------------

-- 1. Encuentra las 5 películas más largas que tengan la palabra 'AGENT' en su título y que tengan una clasificación (rating) de 'PG-13'.
select
	title,
    rating,
    length
from film
where title like '%AGENT%' and
	rating = 'PG-13'
order by length desc
limit 5;

-- 2. Busca clientes (customer) cuyo nombre (first_name) comience con 'J' y su apellido (last_name) contenga la letra 'A'. Ordénalos por apellido.
select
	first_name,
    last_name
from customer
where first_name like 'J%' and
	  last_name like '%A%'
order by last_name;
