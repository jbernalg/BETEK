-- --------------------------- ----------- Taller 10 --------------------------------
-- _____________________________________________________________________________________________________________________________

-- ------------------------------------- 1. Cargar Datos ------------------------------------- 
use callcenter;
select * from raw_call_center;

-- ----------------------- 2. Creación y Poblado de la Dimensión Categoría (dim_categoria) --------------------------------------- 
create table dim_category as 
select 
	concat('C', row_number()over() ) as id_categoria,
	category, 
'si' as Categoria_Activa
from (
	select 
		distinct(category) AS category
	from raw_call_center order by category asc
) as categoria_unicas;

select * from dim_category;

-- ------------------------- 3. Creación y Poblado de la Dimensión Agente (dim_agente) ----------------------------------------- 

 -- Crea la tabla de dimensión dim_agente
create table dim_agente as
select
	Agent_ID,
	null as nombre_agente,
	null as agente_activo,
	null as id_sup
from (
	select 
		distinct(Agent_ID) AS Agent_ID
	from raw_call_center order by Agent_ID asc
) as agentes_unicos;

select * from dim_agente; 

-- mostrar configuracion de la tabla dim_agente
show create table dim_agente;

-- Editar tipos de datos de la tabla dim_agente
alter table dim_agente
modify nombre_agente varchar(50),
modify agente_activo char(2),
modify id_sup varchar(10);

-- Asigne los valores a cada fila según corresponda tomando la información de la hoja agente del archivo Dimensiones.xlsx 
update dim_agente
set nombre_agente = 'Luis Gomez',
	agente_activo = 'si',
    id_sup = 'SP02'
where Agent_ID = 'AG_017';

-- Agregar registros faltantes: AG_001, AG_005, AG_009, AG_0014, AG_0016
insert into dim_agente (Agent_ID, nombre_agente, agente_activo, id_sup)
values ('AG_001', 'María González', 'si', 'SP01'),
	   ('AG_005', 'Laura Martínez', 'si', 'SP01'),
       ('AG_009', 'Valentina López', 'si', 'SP03'),
       ('AG_014', 'Diego Vargas', 'si', 'SP02'),
       ('AG_016', 'Luis Gomez', 'si', 'SP02');

-- ------------------------------- 4. Creación y poblado de la tabla de dimensión dim_supervisor ----------------------------------
select * from raw_call_center;

-- crear tabla dim_supervisor
create table dim_supervisor (
	id_supervisor varchar(10) primary key,
    nombre_supervisor varchar (50) not null,
    supervisor_activo char(2) default 'si'
);

select * from dim_supervisor;

-- agregar registros a la tabla dim_supervisor
insert into dim_supervisor (id_supervisor, nombre_supervisor)
values ('SP01', 'Cristian Aguirre'),
	   ('SP02', 'Rosa Ariza'),
	   ('SP03', 'Andrea Mendoza');
       
-- ------------------------------- 5.  Creación y Poblado de la Dimensión Turno (dim_turno) --------------------------------------
-- crear tabla dim_turno 
create table dim_turno (
	id_shift int primary key,
    acr_shift varchar (5) not null,
    nombre_shift varchar(10) not null
);

select * from dim_turno;

-- agregar registros a la tabla dim_turno
insert into dim_turno (id_shift, acr_shift, nombre_shift)
values (1, 'T1', 'Manana'),
	   (2, 'T2', 'Tarde'),
	   (3, 'T3', 'Noche');
       
-- ------------------------------- 6. Creación y Poblado de la Dimensión Categoría (dim_Pais) ---------------------------------------
select * from raw_call_center;

-- crear tabla dim_Pais
create table dim_Pais as 
select 
	concat('P', row_number()over() ) as id_pais,
    nombre_pais,
	null as iso_pais,
    null as region_pais,
	'si' as pais_activo
from (
	select
		distinct (Country) as nombre_pais
	from raw_call_center
	order by Country asc
) as paises_unicos;

select * from dim_Pais;


-- Editar tipos de datos de la tabla dim_Pais
alter table dim_Pais
modify iso_pais varchar(5),
modify region_pais varchar(30);

-- asignar valores a las filas segun corresponda
update dim_Pais
set iso_pais = 'VE',
	region_pais = 'Sudamerica'
where id_pais = 'P17';

-- ------------------------- 7. Creación Estructurada de la Tabla de Hechos (fact_call_center) --------------------------------

-- Definición explícita de la estructura física 
CREATE TABLE fact_call_center ( 
	id_llamada VARCHAR(20) NOT NULL, 
	fecha DATE NOT NULL, 
	hora TIME NOT NULL, 
	pais VARCHAR(50) NULL, 
	id_cliente VARCHAR(50) NOT NULL, -- Llaves de conexión hacia las dimensiones 
	id_pais VARCHAR(10) NOT NULL, 
	id_categoria VARCHAR(10) NOT NULL, 
	id_shift INT NOT NULL,  
	id_agente VARCHAR(20) NOT NULL,     -- Métricas de rendimiento 
	tiempo_espera_seg INT UNSIGNED DEFAULT 0, 
	tiempo_hablado_min DECIMAL(5,2) DEFAULT 0.00, 
	tiempo_retencion_min DECIMAL(5,2) DEFAULT 0.00, 
	duracion_total_min DECIMAL(5,2) DEFAULT 0.00, 
	tiempo_post_llamada_min DECIMAL(5,2) DEFAULT 0.00,  
	-- KPIs de satisfacción 
	csat INT UNSIGNED DEFAULT NULL, 
	fcr TINYINT UNSIGNED DEFAULT NULL, 
	nps INT UNSIGNED DEFAULT NULL, 
	PRIMARY KEY (id_llamada)
)

-- verificar que la tabla se haya creado correctamente
select * from fact_call_center;

-- verificar formato de fecha y hora
select
	DATE,
    time
from raw_call_center
limit 5;


-- insertar los datos a la tabla fact
select * from raw_call_center;
select * from dim_pais;
select * from dim_category;
select * from dim_turno;

insert into fact_call_center(
	id_llamada,
    fecha,
    hora,
    pais,
    id_cliente,
    id_pais,
    id_categoria,
    id_shift,
    id_agente,
    tiempo_espera_seg,
    tiempo_hablado_min,
    tiempo_retencion_min,
    duracion_total_min,
    tiempo_post_llamada_min,
    csat,
    fcr,
    nps
)
select
	r.ï»¿Call_ID,
    str_to_date(r.Date, '%d/%m/%Y'),
    str_to_date(r.Time, '%H:%i:%s'),
    r.Country,
    r.Customer_ID,
    dp.id_pais,
    dc.id_categoria,
    dt.id_shift,
    r.Agent_ID,
    r.Queue_Time_sec,
    r.Talk_Time_min,
    r.Hold_Time_min,
    r.Duration_min,
    r.ACW_min,
    r.CSAT,
    r.FCR,
    r.NPS
from raw_call_center r 
inner join dim_Pais dp 
	on  r.Country = dp.nombre_pais
inner join dim_category dc
	on r.Category = dc.category
inner join dim_turno dt 
	on r.Shift = dt.acr_shift;
    
select * from fact_call_center;

-- --------------------------- 8. Verificar misma cantidad de registros en tabla raw y fact -----------------------------------
 select
	(select count(*) from raw_call_center) as total_crudo,
    (select count(*) from fact_call_center) as total_fact;
    
-- --------------------------- 9. Agregar las FK de las dimensiones a tabla fact para plasmar relaciones -------------------------

-- correccion de restricciones de las tablas dimensiones
show create table dim_pais;
alter table dim_pais add primary key (id_pais);

show create table dim_category;
alter table dim_category add primary key (id_categoria);

show create table dim_turno;
alter table dim_turno add primary key (id_shift);

show create table dim_agente;
alter table dim_agente modify Agent_ID VARCHAR(20) not null;
alter table dim_agente add primary key (Agent_ID);

-- agregar FK a la tabla fact
alter table fact_call_center
	add constraint fk_fact_pais foreign key (id_pais) references dim_pais(id_pais)
		on delete restrict on update cascade,
	add constraint fk_fact_categoria foreign key (id_categoria) references dim_category(id_categoria)
		on delete restrict on update cascade,
	add constraint fk_fact_turno foreign key (id_shift) references dim_turno(id_shift)
		on delete restrict on update cascade,
	add constraint fk_fact_agente foreign key (id_agente) references dim_agente(Agent_ID)
		on delete restrict on update cascade;
        
-- ------------------------------ 10. Consultar validacion final del modelo estrella -------------------------------------
select
	f.id_llamada,
    f.fecha,
    p.nombre_pais,
    c.category,
    a.nombre_agente,
    f.duracion_total_min,
    f.csat,
    f.nps
from fact_call_center f 
inner join dim_pais p 
	on f.id_pais = p.id_pais
inner join dim_category c 
	on f.id_categoria = c.id_categoria
inner join dim_turno t 
	on f.id_shift = t.id_shift
inner join dim_agente a 
	on f.id_agente = a.Agent_ID
limit 10;
    
 
 