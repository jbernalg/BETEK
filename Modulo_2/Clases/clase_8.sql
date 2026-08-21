use sakila;

-- DDL:

CREATE TABLE customer_demo (

    customer_id INT PRIMARY KEY,

    first_name VARCHAR(50) NOT NULL,

    last_name VARCHAR(50) NOT NULL,

    registration_date DATE

);
 
CREATE TABLE payment_demo (

    payment_id INT PRIMARY KEY,

    customer_id INT,

    amount DECIMAL(10,2) NOT NULL,

    payment_date DATE NOT NULL

);
 
-- DML:

INSERT INTO customer_demo (customer_id, first_name, last_name, registration_date) VALUES

(1, 'Elena', 'Rios', '2026-01-15'),     -- Multiple payments

(2, 'Mario', 'Velez', '2026-02-10'),    -- ZERO payments (LEFT JOIN target)

(3, 'Sofia', 'Castro', '2026-03-22'),   -- Multiple payments

(4, 'Diego', 'Ortiz', '2026-04-05'),    -- Single payment

(5, 'Ana', 'Gomez', '2026-04-18'),      -- Multiple payments

(6, 'Lucas', 'Molina', '2026-05-01'),   -- ZERO payments (LEFT JOIN target)

(7, 'Maria', 'Paz', '2026-05-20'),      -- Single payment

(8, 'Jorge', 'Ruiz', '2026-06-11'),     -- ZERO payments (LEFT JOIN target)

(9, 'Camila', 'Soto', '2026-07-02'),    -- Multiple payments

(10, 'David', 'Lopera', '2026-07-15');  -- ZERO payments (LEFT JOIN target)
 
INSERT INTO payment_demo (payment_id, customer_id, amount, payment_date) VALUES

-- Valid transactions (INNER JOIN matches)

(1001, 1, 55.00, '2026-01-20'),

(1002, 1, 120.00, '2026-02-15'),

(1003, 1, 35.50, '2026-03-10'),

(1004, 3, 200.00, '2026-03-25'),

(1005, 3, 150.00, '2026-04-02'),

(1006, 4, 85.50, '2026-04-10'),

(1007, 5, 45.00, '2026-04-20'),

(1008, 5, 60.00, '2026-05-05'),

(1009, 7, 110.00, '2026-05-25'),

(1010, 9, 90.00, '2026-07-05'),

(1011, 9, 12.50, '2026-07-10'),
 
-- Orphaned transactions (RIGHT JOIN targets)

(1012, 99, 40.00, '2026-07-22'),        -- Non-existent customer_id

(1013, 150, 75.00, '2026-07-23'),       -- Non-existent customer_id

(1014, NULL, 15.00, '2026-07-25'),      -- NULL customer_id (System error simulation)

(1015, NULL, 30.00, '2026-07-26');      -- NULL customer_id (System error simulation)


-- ----------- Practica Joins ----------------------------
-- --------------------------------------------------------------------

select * from customer_demo;
select * from payment_demo; 


-- 1. Cual es el listado de todos los ingresos (pagos) recibidos, cruzados con la informacion del cliente si existe,
-- para auditar pagos de origen desconocido?
select *
from payment_demo p -- prioridad en la tabla izquierda
left join customer_demo c 
	on p.customer_id = c.customer_id;
    
-- 2. obtener todos los clientes asi no tengan pagos
select *
from payment_demo p 
right join customer_demo c 
	on p.customer_id = c.customer_id;
    
select *
from customer_demo c
left join payment_demo p 
	on c.customer_id = p.customer_id;
    
-- 3. Mostrar solo los pagos de origen desconocido
select *
from payment_demo p -- prioridad en la tabla izquierda
left join customer_demo c 
	on p.customer_id = c.customer_id
where c.customer_id is null;

-- 4. Cuanto ha pagado cada cliente y cuantas transacciones ha realizado?
select 
	c.customer_id,
    sum(p.amount) pago_total,
    count(p.payment_id) cant_transaccion
from customer_demo c 
inner join payment_demo p 
	on c.customer_id = p.customer_id
group by c.customer_id;

-- 5. obtener solo los pagos y cantidad de transacciones de cliente con id = 1
select 
	c.customer_id,
    sum(p.amount) pago_total,
    count(p.payment_id) cant_transaccion
from customer_demo c 
inner join payment_demo p 
	on c.customer_id = p.customer_id
    where c.customer_id = 1
group by c.customer_id;

-- ------------------------- Full Join -----------------------------
-- -----------------------------------------------------------------
-- 6. Analizar los clientes asi no tengas pagos, los pagos asi no tengan cliente y los pagos desconocidos
select 
	c.customer_id,
    c.first_name,
    p.payment_id,
    p.amount
from customer_demo c 
left join payment_demo p 
	on c.customer_id = p.customer_id
union
select 
	c.customer_id,
    c.first_name,
    p.payment_id,
    p.amount
from customer_demo c 
right join payment_demo p 
	on c.customer_id = p.customer_id;

-- admite where pero debe aplicarse en ambas consultas
select 
	c.customer_id,
    c.first_name,
    p.payment_id,
    p.amount
from customer_demo c 
left join payment_demo p 
	on c.customer_id = p.customer_id
where c.customer_id = 2 -- primer where
union
select 
	c.customer_id,
    c.first_name,
    p.payment_id,
    p.amount
from customer_demo c 
right join payment_demo p 
	on c.customer_id = p.customer_id
where c.customer_id = 2; -- segundo where

-- el comando union funciona sobre consultas con los mismos campos
-- elimina los duplicados de la consulta