use ecommerce_db;

-- -------------- Where --------------------
select *
from clientes
where ciudad = 'Medellin';

-- operadores de comparacion >=, <=, >, <, !=, =
select *
from pedidos
where monto > 60;

-- ------------------ NULL ------------------------------
-- formas en que se reresentan comunmente los nulos: ' ', 0, 'n'
-- llevarlos al formato NULL que entiende la BD

select * from empleados;

-- mostrar registros con bono igual a nulo
select * from empleados
where bono is null;

select * from empleados
where bono is not null;

-- ------------- Booleanos --------------
-- true = 1
-- false = 0

select * from pedidos
where monto >= 85;


-- --------------- operadores de condicion ---------
-- between para numeros y fechas
select * from pedidos
where monto between 120 and 250;

-- like para texto
select * from clientes
where nombre like 'Ju%';
-- cadena + %: busca todo lo que inicia con la cadena
-- % + cadena: busca todo lo que finaliza con la cadena
-- % + cadena + %: busca la cadena en cualquier parte

-- ------------- operadores logicos ---------------------
-- and: ambas condiciones se deben cumplir, true - true
select * from pedidos
where monto > 60 and id_cliente = 1;

-- or: al menos una de las condiciones se debe cumplir, true 
select * from pedidos
where monto > 60 or id_cliente = 1;

-- not: contrario a la condicion dada
select * from pedidos
where not monto >= 60;

-- ---------------- parentesis para definir prioridad ----------------
select * from envios;

-- mostrar los envios internacionales o aquellos que si son nacionales tengan costo de envio alto mayor a 50$
select * from envios
where es_internacional = 1 or
	 (es_internacional = 0 and costo_envio > 50);

-- ------------ prioridad operadores logico -------------
-- primero not
-- segundo and
-- tercero or
select * from envios
where not es_internacional = 0 or
	      es_internacional = 0 and costo_envio > 50;

-- arroja el mismo resultado que el anterior debido a la prioridad de los operadores
select * from envios
where not es_internacional = 0 or
	      (es_internacional = 0 and costo_envio > 50);
