use callcenter;

select * from llamadas_enero;
select * from supervisor;
select * from agente;

-- ---------------- Mostrar la cantidad de llamadas por supervisor -------------------------
-- forma tradicional
select *
from llamadas_enero
join agente         -- join = inner join
	on llamadas_enero.Agent_ID = agente.id_agent;
    
-- forma con buenas practicas
select *
from llamadas_enero lc
join agente a         
	on lc.Agent_ID = a.id_agent;
    
-- obtener campos a mostrar
select
	lc.Call_ID,
    lc.Country,
    lc.Category,
    a.nombre_agente
from llamadas_enero lc
join agente a         
	on lc.Agent_ID = a.id_agent;

-- arreglar problema de mismo ID con diferentes valores en diferentes tablas
-- crear nuevo campo en supervisor
alter table supervisor
add column id_sup varchar(50) not null;

select * from supervisor;

-- reemplazar los valores 
update supervisor
set id_sup = 'SP01'
where id_supervisor = 1;

update supervisor
set id_sup = 'SP02'
where id_supervisor = 2;

update supervisor
set id_sup = 'SP03'
where id_supervisor = 3;

select * from supervisor;

-- agregar nueva tabla al join y responder pregunta de negocio
select
	lc.Call_ID,
    a.nombre_agente,
    s.nombre_supervisor
from llamadas_enero lc
join agente a         
	on lc.Agent_ID = a.id_agent
join supervisor s         
	on a.id_sup = s.id_sup;

-- ---------------- Mostrar la cantidad de llamadas por supervisor junto al correspondiente turno-------------------------
select * from shift;
select * from llamadas_enero;

select
	lc.Call_ID,
    a.nombre_agente,
    s.nombre_supervisor,
    sh.nombre_shift
from llamadas_enero lc
join agente a         
	on lc.Agent_ID = a.id_agent
join supervisor s         
	on a.id_sup = s.id_sup
join shift sh         
	on lc.shift = sh.acr_shift;
    
-- ---------------- trabajando con sakila ------------
-- -------------------------------------------------------------
use sakila;

-- ----------- indica la direccion de cada cliente --------------------
select * from customer;
select * from address;

select
	c.first_name,
    c.last_name,
    ad.address,
    ad.district
from customer c
join address ad 
	on c.address_id = ad.address_id;
    
-- ----------- indica la direccion de cada cliente  y la ciudad--------------------
select * from city;

select
	c.first_name,
    c.last_name,
    ad.address,
    ad.district,
    cy.city
from customer c
join address ad 
	on c.address_id = ad.address_id
join city cy 
	on ad.city_id = cy.city_id;
