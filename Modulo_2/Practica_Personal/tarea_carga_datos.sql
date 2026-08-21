use callcenter;

select * from llamadas_enero;

select
	distinct Country
from llamadas_enero;
drop table dimfechas;

-- ----------------- Tabla Pais ----------------------
drop table if exists Pais;

create table Pais (
id_pais int auto_increment primary key,
nombre_pais varchar(50) not null,
iso_pais char(2) not null unique,
region_pais varchar(50) not null,
pais_activo varchar(2) not null
);

-- activar carga de archivos locales
set global local_infile = 1;

LOAD DATA INFILE 'C:/ProgramData/MySQL/MySQL Server 8.0/Uploads/Pais.csv'
INTO TABLE Pais
FIELDS TERMINATED BY ','
ENCLOSED BY '"'
LINES TERMINATED BY '\n'
IGNORE 1 ROWS
(@id_pais, nombre_pais, iso_pais, region_pais, pais_activo)
SET id_pais = NULLIF(@id_pais, '');

select * from Pais;

-- ----------------- Tabla Categorias -------------------
create table Categoria (
id_categoria int auto_increment primary key,
nombre_categoria varchar(100) not null,
categoria_activa varchar(2) not null
);

LOAD DATA INFILE 'C:/ProgramData/MySQL/MySQL Server 8.0/Uploads/Categoria.csv'
INTO TABLE Categoria
FIELDS TERMINATED BY ','
ENCLOSED BY '"'
LINES TERMINATED BY '\r\n'
IGNORE 1 ROWS
(@id_categoria, nombre_categoria, categoria_activa)
SET id_categoria = NULLIF(@id_categoria, '');

select * from Categoria;

-- ------------------------ Tabla Supervisor ----------------
create table Supervisor (
id_supervisor int auto_increment primary key,
nombre_supervisor varchar(100) not null,
supervisor_activo varchar(2) not null
);

LOAD DATA INFILE 'C:/ProgramData/MySQL/MySQL Server 8.0/Uploads/Supervisor.csv'
INTO TABLE Supervisor
FIELDS TERMINATED BY ','
ENCLOSED BY '"'
LINES TERMINATED BY '\r\n'
IGNORE 1 ROWS
(@id_superisor, nombre_supervisor, supervisor_activo)
SET id_supervisor = NULLIF(@id_supervisor, '');

select * from Supervisor;

-- ---------------------- Tabla Agente -------------------------
create table Agente (
id_main int auto_increment primary key,
id_agent varchar(10) not null,
nombre_agente varchar(100) not null,
agente_activo varchar(2) not null,
id_sup varchar(10) not null
);

LOAD DATA INFILE 'C:/ProgramData/MySQL/MySQL Server 8.0/Uploads/Agente.csv'
INTO TABLE Agente
FIELDS TERMINATED BY ','
ENCLOSED BY '"'
LINES TERMINATED BY '\r\n'
IGNORE 1 ROWS
(@id_main, id_agent, nombre_agente, agente_activo, id_sup)
SET id_main = NULLIF(@id_main, '');

select * from Agente;

-- ------------------ Tabla Shift -----------------------
create table Shift (
id_shift int auto_increment primary key,
acr_shift varchar(10) not null,
nombre_shift varchar(20) not null
);

LOAD DATA INFILE 'C:/ProgramData/MySQL/MySQL Server 8.0/Uploads/Shift.csv'
INTO TABLE Shift
FIELDS TERMINATED BY ','
ENCLOSED BY '"'
LINES TERMINATED BY '\n'
IGNORE 1 ROWS
(@id_shift, acr_shift, nombre_shift)
SET id_shift = NULLIF(@id_shift, '');

select * from Shift;
