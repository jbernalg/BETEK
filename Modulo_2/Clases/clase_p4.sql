use sakila;

-- Ejemplo 1
select 
	customer_id,
	count(*)
from payment
-- where customer_id = 1;
group by customer_id
-- order by count(*) desc
having count(*) > 30;

-- Ejemplo 2
select 
	customer_id,
	count(*) conteo,
    sum(amount) monto
from payment
group by customer_id
having count(*) > 30 and sum(amount) > '4.201356' -- having admite mas de una condicion con funciones de agg
order by monto desc;
