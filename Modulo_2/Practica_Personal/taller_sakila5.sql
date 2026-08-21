use sakila;
show tables;

-- -------------------- Parte 1: Joins ------------------------------

-- ------------------- INNER JOIN --------------------------------

-- 1. Listar el nombre completo de los clientes y la cantidad de alquileres que han realizado.
-- Agrupar por cliente y mostrar solo aquellos que hayan hecho más de 5 alquileres.
select * from customer;
select * from rental;

select
	c.customer_id,
	concat(c.first_name,' ',last_name) Nombre_Cliente,
    count(rental_id) Cant_Rentas
from customer c
join rental r 
	on r.customer_id = c.customer_id
group by c.customer_id
having Cant_Rentas > 5
order by Cant_Rentas;

-- --------------------------- LEFT JOIN ---------------------------------------

-- 1. Mostrar todos los clientes, hayan alquilado o no, junto con la cantidad de alquileres realizados. 
-- Agrupar por cliente y mostrar solo aquellos con 3 o más alquileres.

select
	c.customer_id,
	concat(c.first_name,' ',last_name) Nombre_Cliente,
    count(r.rental_id) Cant_Rentas
from customer c 
left join rental r 
	 on c.customer_id = r.customer_id
group by c.customer_id
having Cant_rentas >= 3;
     


