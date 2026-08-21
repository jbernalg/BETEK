use sakila;
show tables;

-- 1. ¿Qué actores han participado en la película "ACADEMY DINOSAUR"?
select * from film_actor;
select * from actor;
select * from film;

select
	a.actor_id,
	a.first_name,
    a.last_name,
    f.title
from film_actor fa
join actor a
	on fa.actor_id = a.actor_id
join film f 
	on f.film_id = fa.film_id
where f.title = 'ACADEMY DINOSAUR';

-- 2. ¿Cuáles son los títulos de las películas junto con el nombre de su categoría?
select * from category;
select * from film_category;
select * from film;

select
	f.title Pelicula,
    c.name Categoria
from film f
join film_category fc
	on f.film_id = fc.film_id
join category c
	on fc.category_id = c.category_id;


-- 3. ¿Qué clientes han rentado alguna vez una película de la categoría "Horror"? (sin duplicados)
select * from customer;
select * from rental;
select * from inventory;
select * from film;
select * from film_category;
select * from category;

select
	distinct concat(c.first_name,' ',c.last_name) nombre_cliente,
    ca.name categoria
from customer c
join rental r
	on c.customer_id = r.customer_id
join inventory i 
	on i.inventory_id = r.inventory_id
join film f
	on i.film_id = f.film_id
join film_category fc
	on f.film_id = fc.film_id
join category ca
	on fc.category_id = ca.category_id
where ca.name = 'Horror';
    

-- 4. ¿Cuál es el nombre completo de cada empleado (staff) junto con el nombre de la tienda donde trabaja?

-- 5. ¿Cuántas películas hay por cada categoría, ordenadas de mayor a menor?

-- 6. ¿Cuál es el ingreso total generado por cada película (a través de sus rentas y pagos)?

-- 7. ¿Cuáles son los 5 actores que más películas han protagonizado?

-- 8. ¿Cuál es el total gastado por cada cliente, incluyendo su nombre completo y ciudad?

-- 9. ¿Qué categorías de películas tienen un precio de renta promedio mayor a $3.50?

-- 10. ¿Qué clientes han hecho más de 40 rentas en total?

-- 11. ¿Qué películas han sido rentadas más de 25 veces?

-- 12. ¿Qué idioma (language) tiene más películas asociadas, y cuántas son?

-- 13. ¿Cuáles son las 10 películas más rentadas junto con su categoría?

-- 14. ¿Qué tienda (store) ha generado más ingresos totales, incluyendo la ciudad donde está ubicada?

-- 15. ¿Qué actor ha generado más ingresos totales considerando todas las películas en las que ha actuado y sus rentas asociadas?