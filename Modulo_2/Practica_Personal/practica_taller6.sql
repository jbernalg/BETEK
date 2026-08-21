use sakila;

-- 1. "Listar todos los clientes (aunque nunca hayan alquilado), junto con los títulos de las películas que han rentado."
select * from customer;
select * from rental;
select * from film;

select 
	concat(c.first_name,' ',last_name) nombre_cliente,
    f.title pelicula
from customer c 
left join rental r
	on c.customer_id = r.customer_id
left join inventory i
	on r.inventory_id = i.inventory_id
left join film f
	on i.film_id = f.film_id;
    
-- 2. "Listar todas las películas del catálogo (aunque nunca se hayan comprado copias), 
-- junto con la categoría a la que pertenecen (toda película siempre tiene categoría)."

select * from inventory;

select
	f.title,
    c.name categoria,
    count(i.inventory_id) copias
from film f
inner join film_category fc
	on f.film_id = fc.film_id
inner join category c
	on fc.category_id = c.category_id
left join inventory i
	on fc.film_id = i.film_id
group by f.film_id, f.title, c.name;

-- Mostrar el nombre completo de cada cliente junto con la ciudad donde vive. Incluir todos los clientes, 
-- incluso si por alguna razón no tuvieran ciudad registrada. Ordenar alfabéticamente por ciudad.

select * from customer;
select * from address;
select * from city;

select
	c.customer_id,
	concat(c.first_name,' ',c.last_name) nombre_cliente,
    cy.city Ciudad
from customer c
left join address a 
	on c.address_id = a.address_id
left join city cy 
	on a.city_id = cy.city_id
order by Ciudad;

-- Listar cada categoría de película junto con la cantidad total de veces que se han alquilado películas de esa categoría. 
-- Incluir categorías que no tengan ningún alquiler registrado. Mostrar solo las categorías con más de 200 alquileres, ordenadas de mayor a menor.

select * from category;
select * from film_category;
select * from film;
select * from inventory;
select * from rental;

select
	c.name categoria,
    count(r.rental_id) cantidad_rentas
from category c 
left join film_category fc
	on c.category_id = fc.category_id
left join film f 
	on fc.film_id = f.film_id
left join inventory i 
	on f.film_id = i.film_id 
left join rental r 
	on i.inventory_id = r.inventory_id
group by c.category_id
having cantidad_rentas > 200
order by cantidad_rentas desc;
