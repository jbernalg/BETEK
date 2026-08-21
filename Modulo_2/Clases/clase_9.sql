use sakila;

-- -------------- MULTIPLES JOINS --------------------------

-- 1. Cuanto Dinero ha pagado cada cliente por cada alquiler realizado?
select
	c.customer_id,
    c.first_name nombre_cliente,
	r.rental_id,
    sum(p.amount) total_pagado
from customer c 
inner join rental r 
	on c.customer_id = r.customer_id
inner join payment p 
	on r.rental_id = p.rental_id
group by r.rental_id, c.customer_id, c.first_name;

-- 2. Listar cada pago individual realizado, junto con el cliente que lo hizo y el alquiler al que corresponde.
select
	c.customer_id,
    c.first_name,
	r.rental_id,
    p.amount
from customer c 
inner join rental r 
	on c.customer_id = r.customer_id
inner join payment p 
	on r.rental_id = p.rental_id;
    
-- Generar un reporte detallado para identificar a los clientes con pagos registrados a partir del 1 de enero de 2006, 
-- filtrando aquellas transacciones individuales mayores a 10.00, y agrupando únicamente a quienes acumulen un total 
-- superior a 100.00 con al menos dos transacciones procesadas. El resultado final debe presentar la identificación del cliente, 
-- el nombre y el apellido en mayúsculas, el volumen total de pagos y el promedio por transacción ordenados de mayor a menor.

select * from payment;
select * from customer;

select 
	c.customer_id,
    upper(concat(c.first_name,' ',c.last_name)) Nombre_cliente,
    sum(p.amount) vol_total_pagos,
    avg(p.amount)
from customer_demo c 
inner join payment_demo p 
	on c.customer_id = p.customer_id
where p.payment_date > '2026-01-01'
	and p.amount > 10
group by c.customer_id, Nombre_cliente
having sum(p.amount) > 100 and count(p.payment_id) > 2
order by sum(p.amount) desc, avg(p.amount) desc;
