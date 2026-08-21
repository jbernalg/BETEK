use sakila;

-- Cuantos cliente han alquilado al menos una pelicula

select 
	c.customer_id,
    r.customer_id
from customer c
left join rental r
	on c.customer_id = r.customer_id;
    
select 
	c.customer_id,
    r.customer_id
from rental r
left join customer c
	on r.customer_id = c.customer_id;