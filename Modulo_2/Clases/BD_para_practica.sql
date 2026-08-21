-- ----------------------- BD para Ejercicios -------------------------------

-- creacion BD
drop table if exists tienda_online;
create database tienda_online;
use tienda_online;

-- crecion de tablas

-- ---------------------------
-- Tabla: categorias
-- ---------------------------
CREATE TABLE categorias (
    categoria_id INT AUTO_INCREMENT PRIMARY KEY,
    nombre VARCHAR(50) NOT NULL
);
 
-- ---------------------------
-- Tabla: productos
-- ---------------------------
CREATE TABLE productos (
    producto_id INT AUTO_INCREMENT PRIMARY KEY,
    nombre VARCHAR(100) NOT NULL,
    categoria_id INT NOT NULL,
    precio DECIMAL(10,2) NOT NULL,
    stock INT NOT NULL,
    FOREIGN KEY (categoria_id) REFERENCES categorias(categoria_id)
);
 
-- ---------------------------
-- Tabla: clientes
-- ---------------------------
CREATE TABLE clientes (
    cliente_id INT AUTO_INCREMENT PRIMARY KEY,
    nombre VARCHAR(50) NOT NULL,
    apellido VARCHAR(50) NOT NULL,
    ciudad VARCHAR(50) NOT NULL,
    fecha_registro DATE NOT NULL
);
 
-- ---------------------------
-- Tabla: empleados (con jerarquía y departamento)
-- ---------------------------
CREATE TABLE empleados (
    empleado_id INT AUTO_INCREMENT PRIMARY KEY,
    nombre VARCHAR(100) NOT NULL,
    departamento VARCHAR(50) NOT NULL,
    salario DECIMAL(10,2) NOT NULL,
    jefe_id INT NULL,
    FOREIGN KEY (jefe_id) REFERENCES empleados(empleado_id)
);
 
-- ---------------------------
-- Tabla: pedidos
-- ---------------------------
CREATE TABLE pedidos (
    pedido_id INT AUTO_INCREMENT PRIMARY KEY,
    cliente_id INT NOT NULL,
    empleado_id INT NOT NULL,
    fecha_pedido DATE NOT NULL,
    FOREIGN KEY (cliente_id) REFERENCES clientes(cliente_id),
    FOREIGN KEY (empleado_id) REFERENCES empleados(empleado_id)
);
 
-- ---------------------------
-- Tabla: detalle_pedido
-- ---------------------------
CREATE TABLE detalle_pedido (
    detalle_id INT AUTO_INCREMENT PRIMARY KEY,
    pedido_id INT NOT NULL,
    producto_id INT NOT NULL,
    cantidad INT NOT NULL,
    precio_unitario DECIMAL(10,2) NOT NULL,
    FOREIGN KEY (pedido_id) REFERENCES pedidos(pedido_id),
    FOREIGN KEY (producto_id) REFERENCES productos(producto_id)
);

-- Poblar tablas
INSERT INTO categorias (nombre) VALUES
('Electrónica'), ('Hogar'), ('Ropa'), ('Accesorios');
 
INSERT INTO productos (nombre, categoria_id, precio, stock) VALUES
('Audífonos Bluetooth', 4, 45.99, 120),
('Laptop 15"', 1, 899.99, 15),
('Cafetera', 2, 59.90, 40),
('Camiseta Básica', 3, 15.50, 200),
('Mouse Inalámbrico', 4, 19.99, 150),
('Smart TV 50"', 1, 549.00, 10),
('Silla de Oficina', 2, 120.00, 25),
('Jeans Slim', 3, 45.00, 80),
('Cargador USB-C', 4, 12.99, 300),
('Monitor 24"', 1, 189.99, 20);
 
INSERT INTO clientes (nombre, apellido, ciudad, fecha_registro) VALUES
('Ana', 'López', 'Bogotá', '2023-01-15'),
('Carlos', 'Pérez', 'Medellín', '2023-02-20'),
('Laura', 'Gómez', 'Cali', '2023-03-05'),
('Diego', 'Ramírez', 'Bogotá', '2023-04-10'),
('Sofía', 'Torres', 'Barranquilla', '2023-05-22'),
('Andrés', 'Martínez', 'Medellín', '2023-06-18'),
('Valentina', 'Rojas', 'Bogotá', '2023-07-02'),
('Miguel', 'Castro', 'Cali', '2023-08-14'),
('Camila', 'Vargas', 'Bogotá', '2023-09-09'),
('Juan', 'Herrera', 'Medellín', '2023-10-01');  -- este cliente nunca compra
 
INSERT INTO empleados (nombre, departamento, salario, jefe_id) VALUES
('Pedro Sánchez', 'Ventas', 2200000, NULL),
('María Díaz', 'Ventas', 2500000, 1),
('Jorge Ruiz', 'Ventas', 1900000, 1),
('Lucía Fernández', 'Soporte', 2000000, NULL),
('Tomás Ortiz', 'Soporte', 2100000, 4),
('Elena Molina', 'Logística', 2300000, NULL),
('Raúl Guerrero', 'Logística', 1800000, 6),
('Paula Navarro', 'Logística', 2400000, 6);
 
INSERT INTO pedidos (cliente_id, empleado_id, fecha_pedido) VALUES
(1, 2, '2024-01-05'),
(1, 3, '2024-02-10'),
(2, 2, '2024-01-20'),
(3, 3, '2024-03-01'),
(4, 2, '2024-01-15'),
(5, 3, '2024-02-25'),
(5, 2, '2024-04-01'),
(6, 3, '2024-03-10'),
(7, 2, '2024-01-30'),
(7, 3, '2024-05-02'),
(8, 2, '2024-02-14'),
(9, 3, '2024-03-22'),
(1, 2, '2024-06-01'),
(3, 3, '2024-06-15'),
(5, 2, '2024-07-01');
 
INSERT INTO detalle_pedido (pedido_id, producto_id, cantidad, precio_unitario) VALUES
(1, 1, 2, 45.99),
(1, 5, 1, 19.99),
(2, 2, 1, 899.99),
(3, 4, 3, 15.50),
(3, 9, 2, 12.99),
(4, 3, 1, 59.90),
(5, 6, 1, 549.00),
(5, 6, 1, 549.00),
(6, 7, 2, 120.00),
(7, 1, 1, 45.99),
(7, 8, 2, 45.00),
(8, 4, 5, 15.50),
(9, 2, 1, 899.99),
(9, 5, 3, 19.99),
(10, 6, 1, 549.00),
(11, 3, 2, 59.90),
(11, 9, 4, 12.99),
(12, 3, 1, 59.90),
(12, 7, 1, 120.00),
(13, 1, 1, 45.99),
(13, 4, 2, 15.50),
(14, 8, 3, 45.00),
(14, 9, 1, 12.99),
(15, 2, 1, 899.99),
(15, 5, 2, 19.99);

select * from clientes;
