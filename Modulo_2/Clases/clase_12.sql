-- ------------------------Case -----------------------------
use sakila;

-- 1. Segmentar los pagos para posterior agrupacion
-- Las categorias son: bajo < 2, medio entre 2 y 5 y alto > 5
select * from payment;

select
    case
		when amount < 2 then 'Bajo'
        when amount between 2 and 5 then 'Medio'
        else 'Alto'
    end as categoria_pago,
    count(*)
from payment
group by categoria_pago;

-- 2. Segmentar los pagos segun la tienda para posterior agrupacion
-- Las categorias son: bajo < 2, medio entre 2 y 5 y alto > 5
select
    case
		when amount < 2 and staff_id =1 then 'Bajo tienda 1'
        when amount between 2 and 5  and staff_id = 1 then 'Medio tienda 2'
        else 'Alto'
    end as categoria_pago,
    count(*),
    staff_id
from payment
group by categoria_pago, staff_id;


-- 2. A que publico objetivo pertenece cada pelicula segun su clasificacion de rating
-- Si rating 'G', 'PG' es Familiar, si es PG-13 es Adolescentes, en caso contrario es adulto

select * from film;

select
	case
		when rating = 'G' or rating = 'PG' then 'Familiar'
        when rating = 'PG-13' then 'Adolescente'
        else 'Adulto'
    end as clasificacion_peliculas,
    rating,
    film_id,
    title
from film;

-- 3. Comno clasificar las peliculas segun su tarifa de alquiler?
select
	title,
    rental_rate,
	case rental_rate
		when 0.99 then 'Economica'
        when 2.99 then 'Estandar'
        when 4.99 then 'Premium'
        else 'Otras'
    end as categoria_renta
from film;

-- ------------------------------- Vistas -------------------------------------
-- 4. Vista que muestre solo las peliculas largas
create view peliculas_largas as
select 
	title,
    length
from film
where length > 180;

select * from peliculas_largas;