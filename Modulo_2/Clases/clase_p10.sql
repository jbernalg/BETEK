-- ______________________________ sub concultas ___________________________________________

use callcenter;

select * from llamadas_enero;

-- obtener los agentes cuyas llamadas estan por encima del promedio de llamadas

select
	*
from  llamadas_enero
where Duration_min >= (
	select
		avg(Duration_min)
	from llamadas_enero
);

-- obtener la duracion maxima de llamadas para Panama
select
	max(Duration_min)
from llamadas_enero
where Country = 'Panama';

-- Cuales paises tienen duracion maxima de llamada superior al de Panama
select
	distinct (Country),
    Duration_min
from llamadas_enero
where Duration_min > (
	select
	max(Duration_min)
from llamadas_enero
where Country = 'Panama'
);

-- obtener los datos de agente, duracion de llamadas y fecha para aquellos paises con duracion de llamada mayor a 11.9
select
	Country,
    Agent_ID,
    Duration_min,
    date 
from llamadas_enero
where Country in (
select distinct (Country) from llamadas_enero where Duration_min > 11.9
);

-- obtener los datos de agente, duracion de llamadas y fecha para aquellos paises con duracion de llamada mayor a la duracion
-- maxima de Panama
select
	Country,
    Agent_ID,
    Duration_min,
    Date
from llamadas_enero
where Country in (   -- segunda subconsulta
	select 
		distinct (Country) 
    from llamadas_enero 
    where Duration_min > ( -- primera subconsulta
			select
				max(Duration_min)
			from llamadas_enero
			where Country = 'Panama'
	)
);

-- indicar que asesores tienen llamadas menores al promedio minimo de llamadas por asesor de Chile
select
	Agent_ID,
    Duration_min
from llamadas_enero
where Duration_min <= (
	select
		avg(Duration_min) llam_mas_corta
	from llamadas_enero
    group by Agent_ID
    order by llam_mas_corta
    limit 1
) and Country = 'Chile'
order by Duration_min;

-- listado de asesores cuyo pais inicia con 'M'
select
	Country,
    Agent_ID
from llamadas_enero
where Country = (
	select
		distinct (Country)
	from llamadas_enero
	where Country like 'M%'
    );
    
-- ______________________________ CTE ______________________________________

with promedio_pais as (
select
	Country,
    avg(Duration_min) duracion_prom
from llamadas_enero
group by Country
)
select * from promedio_pais;