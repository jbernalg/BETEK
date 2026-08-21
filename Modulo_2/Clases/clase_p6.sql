use callcenter;

select * from llamadas_enero;

-- ----------------------- crear tabla de Pais a partir de la tabla llamadas_enero
-- obtener nombre para el campo de la tabla Pais
select Country
from llamadas_enero
limit 0;

-- creat tabla Pais
create table Pais as
select Country
from llamadas_enero
limit 0;

show tables;

-- --------------- Agregar valores a la tabla Pais

-- obtener valore unicos de country
select distinct(Country)
from llamadas_enero
order by Country asc;

-- insertar valores a la tabla
insert into Pais (Country)
select distinct(Country)
from llamadas_enero
order by Country asc;

select * from Pais;

-- ------------------- crear tabla dimfechas a partir de los datos de llamadas_enero

-- obtener la fecha y tiempo
select 
	Date,
    Time
from llamadas_enero
limit 0;

-- crear tabla dimfechas
create table dimfechas as 
select 
	Date,
    Time
from llamadas_enero
limit 0;

show tables;

-- ------------------------- insertar valores a la tabla dimfechas

-- obtener valores de Date y Time
select
	Date,
    Time
from llamadas_enero;

-- insert into dimfechas (Date, Time)
insert into dimfechas (Date, Time)
select
	Date,
    Time
from llamadas_enero;

select * from dimfechas;