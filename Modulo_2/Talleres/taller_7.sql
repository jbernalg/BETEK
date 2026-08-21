-- ------------------------ Talle 7: Refuerzo ---------------------------------

-- ------------------- Parte 1 ------------------------------------

-- Borrar la base de datos si ya existe para empezar desde cero 
DROP DATABASE IF EXISTS AcademiaDB; 

-- Crear la base de datos 
CREATE DATABASE AcademiaDB; 

-- Usar la base de datos recién creada 
use AcademiaDB;

-- Crear la tabla de Instructores 
CREATE TABLE Instructores ( 
InstructorID INT PRIMARY KEY AUTO_INCREMENT, 
Nombre VARCHAR(100) NOT NULL, 
Especialidad VARCHAR(100) 
); 

-- Crear la tabla de Cursos 
CREATE TABLE Cursos ( 
CursoID INT PRIMARY KEY AUTO_INCREMENT, 
Titulo VARCHAR(150) NOT NULL, 
Nivel VARCHAR(50), 
Horas INT, 
InstructorID INT, 
FOREIGN KEY (InstructorID) REFERENCES Instructores(InstructorID) 
); 

-- Crear la tabla de Inscripciones 
CREATE TABLE Inscripciones ( 
InscripcionID INT PRIMARY KEY AUTO_INCREMENT, 
CursoID INT, 
NombreEstudiante VARCHAR(100), 
FechaInscripcion DATE, 
CalificacionFinal DECIMAL(4, 2), 
FOREIGN KEY (CursoID) REFERENCES Cursos(CursoID) 
); 

-- Insertar datos en la tabla de Instructores 
INSERT INTO Instructores (Nombre, Especialidad) VALUES 
('Carlos Ruiz', 'Bases de Datos'), 
('Ana Gomez', 'Desarrollo Web'), 
('Luis Peña', 'Ciencia de Datos'), 
('Sofia Luna', 'Bases de Datos'); 

-- Insertar datos en la tabla de Cursos 
INSERT INTO Cursos (Titulo, Nivel, Horas, InstructorID) VALUES 
('SQL para Principiantes', 'Básico', 20, 1), 
('Modelado de Datos Avanzado', 'Avanzado', 35, 1), 
('JavaScript Moderno', 'Intermedio', 40, 2), 
('Python para Ciencia de Datos', 'Básico', 50, 3), 
('Machine Learning Aplicado', 'Avanzado', 60, 3), 
('Introducción a MySQL', 'Básico', 25, 4); 

-- Insertar datos en la tabla de Inscripciones 
INSERT INTO Inscripciones (CursoID, NombreEstudiante, FechaInscripcion, CalificacionFinal) 
VALUES 
(1, 'Elena Torres', '2023-01-10', 8.50), 
(1, 'Juan Vargas', '2023-01-12', 9.10), 
(2, 'Maria Solis', '2023-02-15', 9.50), 
(3, 'Pedro Campos', '2023-03-01', 8.80), 
(3, 'Laura Mendez', '2023-03-05', 7.90), 
(4, 'Elena Torres', '2023-04-20', 9.80), 
(5, 'Juan Vargas', '2023-05-10', 9.20), 
(6, 'Ricardo Perez', '2023-06-01', 8.00); 

-- ------------------------------ Parte 2: Consultas y Manipulación de Datos ------------------------------------

-- -----------------------------------Consultas Básicas y Filtrado----------------------------------------- 

-- 1. Muestra todos los cursos de nivel 'Básico'. 
select 
	CursoID,
	Titulo
from cursos
where Nivel = 'Básico';

-- 2. Encuentra todos los instructores cuya especialidad sea 'Bases de Datos'. 
select * from instructores
where Especialidad = 'Bases de Datos';

-- 3. Lista los cursos que tengan más de 40 horas de duración. 
select * from cursos
where Horas > 40;

-- 4. Muestra las inscripciones realizadas después del '2023-03-01'. 
select * from inscripciones
where FechaInscripcion > '2023-03-01';

-- --------------------------------Funciones de Agregación y Agrupamiento---------------------------------- 

-- 5. Calcula el número total de cursos ofrecidos. 
select * from cursos;

select 
	count(CursoID) total_cursos
from cursos;

-- 6. Encuentra la calificación final promedio de todos los estudiantes inscritos. 
select 
	avg(CalificacionFinal) promedio_estudiantes
from inscripciones;

-- 7. Muestra cuántos cursos imparte cada instructor. El resultado debe mostrar el nombre del instructor y la cantidad de cursos. 
select * from instructores;
select * from cursos;

select
	i.Nombre Instructor,
    count(CursoID) Cant_cursos
from cursos c
join instructores i 
	on c.InstructorID = i.InstructorID
group by i.InstructorID;

-- 8. Calcula la calificación promedio por curso. El resultado debe mostrar el título del curso y su calificación promedio. 
select * from cursos;
select * from inscripciones;

select
	c.titulo Curso,
    avg(i.CalificacionFinal) calificacion_prom
from cursos c 
inner join inscripciones i 
	on c.CursoID = i.CursoID
group by c.CursoID;

-- 9. Encuentra los cursos que tienen más de 1 estudiante inscrito, mostrando el título del curso y el número de inscritos. 
select * from cursos;
select * from inscripciones;

select
	c.CursoID,
	c.Titulo,
    count(i.InscripcionID) cant_inscritos
from cursos c 
inner join inscripciones i 
	on c.CursoID = i.CursoID
group by c.CursoID, c.Titulo
having count(i.InscripcionID) > 1
order by cant_inscritos desc;

-- ----------------------------------Uniones (Joins)------------------------------------- 

-- 10. Lista todos los cursos junto con el nombre del instructor que los imparte. 
select * from instructores;
select * from cursos;

select 
	c.Titulo curso,
    i.Nombre instructor
from cursos c 
inner join instructores i 
	on c.InstructorID = i.InstructorID;

-- 11. Muestra el nombre de los estudiantes y el título del curso al que están inscritos.
select * from inscripciones;
select * from cursos;

select
	i.NombreEstudiante Estudiante,
    c.Titulo Curso
from inscripciones i 
inner join cursos c 
	on i.CursoID = c.CursoID;

-- 12. Encuentra todos los instructores y los cursos que imparten. Incluye a los instructores que no imparten ningún curso (si los hubiera). 
select * from instructores;
select * from cursos;

select
	i.Nombre Instructor,
    c.Titulo Curso
from instructores i 
left join cursos c 
	on i.InstructorID = c.InstructorID;
    
-- ------------------------------------- Manipulación de Datos ---------------------------------------------------

-- 13. Insertar: Agrega un nuevo instructor llamado 'Laura Paez' con especialidad en'Ciberseguridad'.

insert into instructores (Nombre, Especialidad)
values ('Laura Perez', 'Ciberseguridad');  

select * from instructores;

-- 14. Insertar: Inscribe a un nuevo estudiante, 'Ana Juarez', en el curso 'Introducción a MySQL' de ID = 6 con fecha de hoy y una calificación final nula.
select * from cursos;
select * from inscripciones;

insert into inscripciones (CursoID, NombreEstudiante, FechaInscripcion, CalificacionFinal)
values (6, 'Ana Juarez', '2026-07-31', Null);  

-- 15. Actualizar: Carlos Ruiz ha cambiado su especialidad a 'Bases de Datos y Cloud'. Actualiza su registro.
select * from instructores;
update instructores set Especialidad = 'Bases de Datos y Cloud' where Nombre = 'Carlos Ruiz';

-- 16. Eliminar: El estudiante 'Ricardo Perez' ha decidido darse de baja del curso 'Introducción a MySQL'. Elimina su inscripción.
select * from inscripciones;

delete from inscripciones where NombreEstudiante = 'Ricardo Perez';

-- -------------------------- PARTE 3: Subconsultas y vistas -----------
-- 17. Encuentra los cursos impartidos por instructores especializados en 'Bases de Datos'.
select * from instructores;
select * from cursos;

select
	Titulo
from cursos
where InstructorID in (
	select
		InstructorID
	from instructores 
	where Especialidad = 'Bases de Datos'
);

-- 18. Muestra los nombres de los estudiantes que han obtenido una calificación final superior al promedio de todas las calificaciones.
select * from inscripciones;

select
	NombreEstudiante,
    CalificacionFinal
from inscripciones
where CalificacionFinal > (
	select avg(CalificacionFinal) from inscripciones
);


-- 19. Lista los cursos en los que 'Elena Torres' está inscrita.
select * from inscripciones;

select
	Titulo
from cursos
where CursoID in (
	select
		CursoID
	from inscripciones 
	where NombreEstudiante = 'Elena Torres'
);

-- 20. (Reto) Encuentra al instructor que imparte el curso con la mayor cantidad de horas.
select * from cursos;
select * from instructores;

select
	Nombre
from instructores
where InstructorID = (
	select
		InstructorID
	from cursos
    order by Horas desc
    limit 1
);

-- otra alternativa
select
	Nombre
from instructores
where InstructorID in (
	select
		InstructorID
	from cursos
    where Horas = (
		select
			max(Horas)
		from cursos
    )
);


-- ----------------------------------- Vistas (Views) --------------------------------------------
-- 21. Crear Vista: Crea una vista llamada Vista_Cursos_Instructores que muestre el CursoID, Titulo del curso, Nivel y el Nombre del instructor.

-- 22. Consultar Vista: Realiza una consulta a la vista Vista_Cursos_Instructores para encontrar todos los cursos de nivel 'Avanzado'.


-- 23. Crear Vista: Crea una vista llamada Vista_Rendimiento_Estudiantes que muestre el NombreEstudiante, el Titulo del curso y la CalificacionFinal.

-- 24. Consultar Vista: Usando la vista Vista_Rendimiento_Estudiantes, encuentra a los estudiantes con calificaciones superiores a 9.0.


-- 25. Eliminar Vista: Borra la vista Vista_Cursos_Instructores.