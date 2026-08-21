use sakila;

-- ------------------ Having ----------------------------
-- Mostrar solo las clasificaciones (rating) que tengan mas de 200 peliculas 
select * from film;

-- Mostrar primero el total de peliculas por clasificacion
select
	rating clasificacion,
    count(film_id) total_peliculas
from film
group by rating;

-- mostrar las clasificaciones que tengan mas de 200 peliculas
select
	rating clasificacion,
    count(film_id) total_peliculas
from film
group by rating
having count(*) > 200;

-- mostrar las clasificaciones que no sean PG
select
	rating clasificacion,
    count(film_id) total_peliculas
from film
group by rating
having rating != 'PG';

-- considera solo peliculas que duren mas de 120 minutos, agruparlas por clasificacion
-- y mostrar unicamente las clasificaciones que tengan mas de 90 peliculas largas.
select
	rating,
    count(*) total_peliculas
from film
where length > 120
group by rating
having count(*) > 90;

select
	rating,
    count(*) total_peliculas
from film
where length > 120
group by rating
having avg(length) > 120; -- es posible operar una funcion de agregacion en having sin haber sido definida en el select