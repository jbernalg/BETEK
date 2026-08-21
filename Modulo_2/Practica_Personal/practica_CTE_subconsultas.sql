-- --------------------- Responder preguntas de negocio ---------------------------

-- 1. ¿Qué productos tienen un precio superior al precio promedio de todos los productos?
select * from productos;

-- subconsulta: un valor
select
	avg(precio) precio_prom
from productos;

select
	nombre,
    precio
from productos
where precio > (
	select
		avg(precio) precio_prom
	from productos
);

-- 2. ¿Qué clientes han realizado al menos un pedido?
select * from pedidos;
select * from clientes;

-- subconsulta: lista
select
	distinct cliente_id
from pedidos;

select
	concat(nombre,' ',apellido) cliente
from clientes
where cliente_id in (
	select
		distinct cliente_id
	from pedidos
);

-- 3. ¿Qué clientes nunca han realizado un pedido?
select
	concat(nombre,' ',apellido) cliente
from clientes
where cliente_id not in (
	select
		distinct cliente_id
	from pedidos
);

-- 4. ¿Qué empleados ganan más que el salario promedio de su propio departamento?
select * from empleados;

select
	nombre,
    salario
from empleados e 
where e.salario > (
	select
		avg(salario)
	from empleados ep
    where ep.departamento = e.departamento
);

-- 5. ¿Cuál es el gasto promedio por ciudad, calculando primero el gasto total de cada cliente y luego promediando por ciudad?
select * from clientes;
select * from pedidos;
select * from detalle_pedido;

select
	c.cliente_id,
    c.ciudad,
    sum(dp.cantidad * dp.precio_unitario) gasto_total
from clientes c 
inner join pedidos p 
	on c.cliente_id = p.cliente_id
inner join detalle_pedido dp 
	on p.pedido_id = dp.pedido_id
group by c.cliente_id,  c.ciudad;

select
	ciudad,
    avg(gasto_total) gasto_promedio
from (select
	c.cliente_id,
    c.ciudad,
    sum(dp.cantidad * dp.precio_unitario) gasto_total
from clientes c 
inner join pedidos p 
	on c.cliente_id = p.cliente_id
inner join detalle_pedido dp 
	on p.pedido_id = dp.pedido_id
group by c.cliente_id,  c.ciudad) as gasto_cliente
group by ciudad;

-- 6. ¿Cuál es el producto más caro de cada categoría?
select * from categorias;
select * from productos;

select
	nombre,
    categoria_id,
    precio
from productos p 
where p.precio = (
	select
		max(precio)
	from productos pr 
    where pr.categoria_id = p.categoria_id
);

-- 7. ¿Cuáles son los 3 clientes que más han gastado en total? CTEs

with gasto_clientes as (
	select
		c.cliente_id,
		sum(dp.cantidad * dp.precio_unitario) gasto_total
	from clientes c 
	inner join pedidos p 
		on c.cliente_id = p.cliente_id
	inner join detalle_pedido dp 
		on p.pedido_id = dp.pedido_id
	group by c.cliente_id
)
select
	*
from gasto_clientes 
order by gasto_total desc
limit 3;