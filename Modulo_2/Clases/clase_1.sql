DROP TABLE IF EXISTS empleados;
 
CREATE TABLE empleados (
    id_empleado INT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
    nombre_completo VARCHAR(100) NOT NULL,
    departamento VARCHAR(50) NOT NULL,
    salario DECIMAL(10, 2) NOT NULL,
    bono DECIMAL(10, 2) DEFAULT NULL,
    id_jefe INT UNSIGNED DEFAULT NULL
);
 
INSERT INTO empleados (nombre_completo, departamento, salario, bono, id_jefe)
VALUES 
    ('Alicia Gómez', 'Dirección', 150000.00, NULL, NULL),
    ('Roberto Silva', 'Ingeniería', 95000.00, 5000.00, 1),
    ('Carlos Mendoza', 'Ingeniería', 85000.00, NULL, 1);
    
CREATE TABLE envios (     
	id_envio INT PRIMARY KEY AUTO_INCREMENT,     
    id_pedido INT NOT NULL,     
    empresa_transporte VARCHAR(50),     
    costo_envio DECIMAL(10, 2),     
    fecha_entrega DATE,     -- Nueva Columna Booleana: 1 (True/Sí) o 0 (False/No)     
    es_internacional BOOLEAN DEFAULT FALSE );
    
INSERT INTO envios (id_pedido, empresa_transporte, costo_envio, fecha_entrega, es_internacional) 
VALUES (101, 'FedEx', 45.00, '2024-02-10', 1),    -- Internacional y entregado 
		(102, 'DHL', 120.00, NULL, 0),               -- Nacional y en tránsito 
        (103, 'Servientrega', 8.50, '2024-02-12', 0),-- Nacional y entregado 
        (104, NULL, 0.00, NULL, 0),                 -- Nacional, pendiente procesar 
        (105, 'UPS', 55.00, NULL, 1);               -- Internacional y en tránsito