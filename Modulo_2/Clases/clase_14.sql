-- ----------------- Esquema Estrella ----------------------------

-- Crear BD
create database if not exists estrella_ventas;
use estrella_ventas;

-- Crear tablas dimensiones
CREATE TABLE dim_cliente (
    cliente_id INT PRIMARY KEY,
    nombre VARCHAR(80) NOT NULL,
    ciudad VARCHAR(60) NOT NULL
);
 
CREATE TABLE dim_producto (
    producto_id INT PRIMARY KEY,
    producto VARCHAR(80) NOT NULL,
    categoria VARCHAR(50) NOT NULL
);
 
CREATE TABLE dim_vendedor (
    vendedor_id INT PRIMARY KEY,
    nombre VARCHAR(80) NOT NULL,
    cargo VARCHAR(50) NOT NULL
);
 
CREATE TABLE dim_tienda (
    tienda_id INT PRIMARY KEY,
    tienda VARCHAR(80) NOT NULL,
    ciudad VARCHAR(60) NOT NULL
);

-- crear tabla FACT
CREATE TABLE fact_ventas (
    venta_id INT PRIMARY KEY,
    fecha_venta DATE NOT NULL,
    cliente_id INT NOT NULL,
    producto_id INT NOT NULL,
    vendedor_id INT NOT NULL,
    tienda_id INT NOT NULL,
    cantidad INT NOT NULL,
    precio_unitario DECIMAL(10,2) NOT NULL,
    total_venta DECIMAL(10,2) NOT NULL,
    FOREIGN KEY (cliente_id) REFERENCES dim_cliente(cliente_id),
    FOREIGN KEY (producto_id) REFERENCES dim_producto(producto_id),
    FOREIGN KEY (vendedor_id) REFERENCES dim_vendedor(vendedor_id),
    FOREIGN KEY (tienda_id) REFERENCES dim_tienda(tienda_id)
);

-- Poblar tablas dimensiones
INSERT INTO dim_cliente VALUES
(1,'Ana','Medellín'),(2,'Carlos','Bogotá'),(3,'Laura','Cali'),
(4,'Juan','Medellín'),(5,'Sofía','Rionegro');
 
INSERT INTO dim_producto VALUES
(1,'Café','Bebidas'),(2,'Sandwich','Comidas'),(3,'Torta','Postres'),
(4,'Jugo','Bebidas'),(5,'Ensalada','Comidas');
 
INSERT INTO dim_vendedor VALUES
(1,'Laura','Asesora'),(2,'Pedro','Asesor'),
(3,'Camila','Asesora'),(4,'Andrés','Asesor');
 
INSERT INTO dim_tienda VALUES
(1,'Laureles','Medellín'),(2,'El Poblado','Medellín'),
(3,'Centro','Bogotá'); 

-- Poblar tabla FACT
INSERT INTO fact_ventas
(
    venta_id,
    fecha_venta,
    cliente_id,
    producto_id,
    vendedor_id,
    tienda_id,
    cantidad,
    precio_unitario,
    total_venta
)
VALUES
(1,  '2026-08-01', 1, 1, 1, 1, 2,  9000, 18000),
(2,  '2026-08-01', 2, 2, 2, 2, 1, 18000, 18000),
(3,  '2026-08-02', 3, 3, 3, 1, 2, 12000, 24000),
(4,  '2026-08-02', 1, 4, 1, 1, 3,  7000, 21000),
(5,  '2026-08-03', 4, 1, 4, 2, 1,  9000,  9000),
(6,  '2026-08-03', 5, 5, 2, 3, 2, 16000, 32000),
(7,  '2026-08-04', 2, 3, 3, 2, 1, 12000, 12000),
(8,  '2026-08-04', 3, 2, 1, 1, 2, 18000, 36000),
(9,  '2026-08-05', 1, 4, 4, 3, 4,  7000, 28000),
(10, '2026-08-05', 4, 1, 2, 1, 3,  9000, 27000),
(11, '2026-08-06', 5, 3, 3, 2, 1, 12000, 12000),
(12, '2026-08-06', 2, 5, 4, 3, 2, 16000, 32000),
(13, '2026-08-07', 1, 2, 1, 1, 2, 18000, 36000),
(14, '2026-08-07', 3, 1, 2, 2, 5,  9000, 45000),
(15, '2026-08-08', 5, 4, 3, 3, 2,  7000, 14000);

-- verificar carga de los datos
select * from fact_ventas;

-- reunir todos los datos en una misma tabla (enriquecimiento de la informacion)
select
	*
from fact_ventas fv 
inner join dim_cliente dc 
	on fv.cliente_id = dc.cliente_id
inner join dim_producto dp
	on fv.producto_id = dp.producto_id
inner join dim_vendedor dv
	on fv.vendedor_id = dv.vendedor_id
inner join dim_tienda dt 
	on fv.tienda_id = dt.tienda_id;

