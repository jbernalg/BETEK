-- ---------------- Tipos de joins ---------------------------

use sakila;

select * from customer;
select * from payment;

-- ---------- INNER --------------------------
select
	c.customer_id,
    c.first_name,
    p.payment_id,
    p.amount
from customer c        -- tabla izquierda
inner join payment p   -- tabla derecha
	on c.customer_id = p.customer_id;
    
-- ----------------- LEFT ----------------------------

-- Mostrar clientes incluyendo aquellos que no tengan pagos
select
	c.first_name,
    p.amount
from customer c
left join payment p
	on c.customer_id = p.customer_id;
    
-- Mostrar pagos de clientes que han pagado
select
	c.first_name,
    p.amount
from payment p
left join customer c
	on p.customer_id = c.customer_id;
    
-- mostrar los pagos asi no tengan clientes
select
	c.first_name,
    p.amount
from payment p
left join customer c
	on p.customer_id = c.customer_id;

-- mostrar clientes que no tengan pago
select *
from customer c 
left join payment p 
	on c.customer_id = p.customer_id
where p.payment_id is null;
    
-- --------------------- RIGHT -----------------------------

-- mostrar los pagos asi no tengan clientes
select
	c.first_name,
    p.amount
from customer c
right join payment p
	on c.customer_id = p.customer_id;
    

    

    
    