

-- ________________________________________________________________________________ 
-- 1. Cargar datos raw
use callcenter2;
select * from raw_call_center;

-- ________________________________________________________________________________
-- 2. Modificar nombre de campos que arrojen error
alter table raw_call_center 
rename column ï»¿Call_ID to Call_ID;

-- _________________________________________________________________________________
-- 3. Crear tablas dimensionales

-- tabla dim_categoria
create table dim_categoria as (
	select
		concat('C', lpad(row_number() over (order by Category), 2, '0')) as id_categoria,
		Category nombre_categoria,
        'si' as categoria_activa
    from (
		select
			distinct Category
		from raw_call_center
		where Category is not null
		order by Category asc
        ) as categorias_unicas
);

select * from dim_categoria;

-- asignar PK a dim_categoria
alter table dim_categoria
add primary key (id_categoria);