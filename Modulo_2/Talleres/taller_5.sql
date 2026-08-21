-- Taller 5

-- 1. Crear BD
create database callcenter;
use callcenter;

--  2. Utilice el asistente de importación de datos de MySQL Workbench para importar el archivo call_center_data_latam_enero.csv 
-- dentro de la base de datos callcenter. Nombre la tabla como llamadas_enero. 

select * from llamadas_enero;

-- Renombrar Call_ID
ALTER TABLE llamadas_enero
RENAME COLUMN ï»¿Call_ID TO Call_ID;

--  El asistente para importación carga las fechas como texto, vuélvelas fecha con este script: 
-- UPDATE <NOMBRE DE TU TABLA> 
-- SET <NOMBRE DE TU COLUMNA> = STR_TO_DATE(<NOMBRE DE TU COLUMNA>, '%d/%m/%Y'); 

UPDATE llamadas_enero 
SET Date = STR_TO_DATE(Date, '%d/%m/%Y'); 

-- Las columnas de tiempo también se importan como texto, vuélvelas tipo time con este script: 
-- ALTER TABLE <NOMBRE DE TU TABLA> 
-- MODIFY COLUMN <NOMBRE DE TU COLUMNA> TIME; 

ALTER TABLE llamadas_enero MODIFY COLUMN Time TIME; 

-- 3: Muestre todas las columnas de las primeras 10 llamadas registradas en la tabla. 
select * from llamadas_enero
limit 10;

-- 4: Liste únicamente el Call_ID, Country y categoría de todas las llamadas. 
select
	Call_ID,
    Country,
    Category
from llamadas_enero;

-- 5. Muestre todas las llamadas que sean del país Colombia. 
select
	*
from llamadas_enero
where Country = 'Colombia';

-- 6. Liste las llamadas donde el tipo de problema sea "Problemas tecnicos" del país Honduras.
select
	*
from llamadas_enero
where Category = 'Problemas tecnicos' 
	and Country = 'Honduras';
    
-- 7. Muestre las llamadas de México donde el turno sea T1 antes de las 10:00 am.
select
	*
from llamadas_enero
where Country = 'México'
	and Shift = 'T1'
    and Time < '10:00:00';
    
-- 8. Liste las llamadas donde el país sea Argentina o Chile, ordenadas alfabéticamente por país. 
select
	*
from llamadas_enero
where Country = 'Argentina' 
	or Country = 'Chile'
order by Country;

-- 9.  Muestre las llamadas con duración (Duration_min) mayor a 150 minutos, ordenadas de mayor a menor duración. 
select
	*
from llamadas_enero
where Duration_min > 150;

-- 10.  Liste todas las llamadas donde el agente sea AG_003 y el tipo de problema sea "Acceso y cuenta". 
select
	*
from llamadas_enero
where Agent_ID = 'AG_003'
	and Category = 'Acceso y cuenta';

-- 11. 	Muestre las llamadas donde la duración esté entre 5 y 7 minutos, ordenadas por duración ascendente.
select
	*
from llamadas_enero
where Duration_min between 5 and 7
order by Duration_min asc;

-- 12. Liste las llamadas donde el país NO sea México, mostrando solo Call_ID, Country y Category.
select
	Call_ID,
    Country,
    Category
from llamadas_enero
where Country != 'México';

select
	Call_ID,
    Country,
    Category
from llamadas_enero
where Country not in ('México');

-- 13. Cuente el total de llamadas registradas en la tabla para cada asesor del turno T3. 
select
	Agent_ID,
    count(Call_ID) Total_llamadas
from llamadas_enero
where Shift = 'T3'
group by Agent_ID;

-- 14. Calcule la duración promedio (AVG) de las llamadas por categoría.
select
	Category,
    round(avg(Duration_min),2) duracion_promedio
from llamadas_enero
group by Category;

-- 15.  Cuente cuántas llamadas hubo por cada país (Country), mostrando el país y el total de llamadas, ordenado de mayor a menor cantidad.
select
	Country,
    count(Call_ID) cant_llamadas
from llamadas_enero
group by Country
order by cant_llamadas desc;

-- 16: Muestre el tipo de problema (Categoría) con el mayor número de llamadas registradas. 
select
	Category,
    count(Call_ID) cant_llamadas
from llamadas_enero
group by Category
order by cant_llamadas desc
limit 1;


-- 17: Liste los agentes (AgentID) que hayan atendido más de 500 llamadas en cada turno, mostrando el ID del agente y el total atendido, 
-- ordenados de mayor a menor. 
select
	Agent_ID,
    count(Call_ID) cant_llamadas
from llamadas_enero
group by Agent_ID
having cant_llamadas > 500
order by cant_llamadas desc;


-- 18: Por cada país, calcule la duración de las llamadas para cada categoría, solo muestre aquellos países cuyo promedio de duración 
-- sea mayor a 120 minutos y ordénelos por país de forma alfabética y por cantidad de mayor a menor.  
select
	Country,
    Category,
    round(avg(Duration_min),2) duracion_prom
from llamadas_enero
group by Country, Category
having duracion_prom > 120
order by Country, duracion_prom desc;

-- 19 (ALTER): Agregue una nueva columna llamada Pais_Codigo de tipo VARCHAR(5) a la tabla llamadas_enero.
alter table llamadas_enero	
add Pais_codigo varchar(5);

select * from llamadas_enero;
 
-- 20 (UPDATE): Actualice la columna Pais_Codigo con el valor "COL" para todas las llamadas donde el país sea Colombia. 
update llamadas_enero set Pais_codigo = 'COL' where Country = 'Colombia';
select * from llamadas_enero where Country = 'Colombia';

-- Bonus: Cambie el nombre de la columna *Queue_Time_sec* por *Queue_Time_min* y convierte los datos de esta columna a minutos

-- cambiar nombre de la columna
ALTER TABLE llamadas_enero
RENAME COLUMN Queue_Time_sec TO Queue_Time_min;

-- cambiar el tipo de dato a decimal
ALTER TABLE llamadas_enero
MODIFY COLUMN Queue_Time_min DECIMAL(10,2);

-- convertir valores de segundos a minutos
UPDATE llamadas_enero
SET Queue_Time_min = Queue_Time_min / 60;

-- verificar el tipo de dato del campo en cuestion
DESCRIBE llamadas_enero;


