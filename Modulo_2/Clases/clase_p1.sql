create database test2;
use test2;

drop table sales;

select * from sales;

select location from sales;

select store_name
from sales
where store_name = 'Tech Haven';

-- group by
select
	store_name,
    location,
    count(transaction_id)*2 as transacciones,
    sum(quantity) as cant_vendidas,
    avg(quantity),
    avg(price) as precio_prom
from sales
group by location, store_name;
