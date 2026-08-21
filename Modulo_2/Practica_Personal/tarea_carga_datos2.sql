-- ---------------------------- creacion de BD y configuracion ----------------------------
create database callcenter2;

use callcenter2;

select * from llamadas_enero;

-- Renombrar Call_ID
ALTER TABLE llamadas_enero
RENAME COLUMN ï»¿Call_ID TO Call_ID;

UPDATE llamadas_enero 
SET Date = STR_TO_DATE(Date, '%d/%m/%Y'); 

ALTER TABLE llamadas_enero MODIFY COLUMN Time TIME; 

-- -------------- Tabla Pais --------------------
select 
	Country
from llamadas_enero
limit 0;

-- crear tabla
create table Pais as
select 
	Country
from llamadas_enero
limit 0;

select * from Pais;

select
	distinct(Country)
from llamadas_enero
order by Country asc;

-- insertar datos
insert into Pais (Country)
select
	distinct(Country)
from llamadas_enero
order by Country asc;

select * from Pais;

-- agregar id
alter table Pais
add column id_pais int auto_increment primary key first;

-- agregar pais_activo
alter table Pais
add column pais_activo varchar(2) default 'si';

select * from Pais;

-- ---------------------- Tabla Categoria ---------------------
-- seleccionar datos
select
	distinct Category
from llamadas_enero;

-- crear tabla 
create table Categoria as
select
	distinct Category
from llamadas_enero;

select * from Categoria;

-- agregar id y categoria_activa
alter table Categoria
add column id_categoria int auto_increment primary key first,
add column categoria_activa varchar(2) default 'si';

select * from Categoria;

-- ---------------- Tabla Agente ------------------------------
select
	Agent_ID
from llamadas_enero;
