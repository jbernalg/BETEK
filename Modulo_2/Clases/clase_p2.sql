use sakila;

select * from customer;

select * from address;

-- mostrar los clientes con id del 10 al 20
select
	customer_id,
	first_name,
    last_name
from customer
where customer_id between 10 and 20;

-- mostrar los clientes con store_id = 2 y que esten activos
select
	customer_id,
	first_name,
    last_name
from customer
where store_id = 2 and active = 1;

-- ----------- importancia de la precedencia --------------------
select *
from customer
where store_id = 2 and active = 3 or last_name = 'Jones';

select *
from customer
where store_id = 2 or active = 3 and last_name = 'Jones';

select *
from customer
where not address_id = 2;

-- ----------- LIKE --------------
select *
from customer
where last_name like 'Var%';

select *
from customer
where address_id like '%10%';

select *
from customer
where address_id like '10%';
