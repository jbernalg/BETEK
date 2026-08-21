-- ___________________________________ Case __________________________________________

use callcenter;

select * from llamadas_enero;

-- Campo que define los turnos de forma categorica
select
	agent_id,
    shift,
	case	
        when shift = 'T1' then 'manana'
        when shift = 'T2' then 'tarde'
        else 'noche'
	end as turnos_text
from llamadas_enero;

-- case para actualizar datos basado en condiciones
select * from shift;

update shift
set nombre_shift = 
case
	when nombre_shift = 'Mañana' then 'Morning'
    when nombre_shift = 'Tarde' then 'Afternoon'
    else 'Night'
end;
select * from shift;

update shift
set nombre_shift = 'Afternoon' 
where acr_shift = 'T2';

-- _______________________________ Views ___________________________________
select * from llamadas_enero;

-- creacion de una vista
create or replace view vw_FCR as  -- codigo para actualizar una views que ya existe
select
	date,
    Agent_ID,
    FCR,
    case
		when FCR = 1 then 'Resuelta'
        else 'No Resuelta'
    end as Text_FCR
from llamadas_enero;

select * from vw_FCR;

-- agregar campo category a la ista
create or replace view vw_FCR as 
select
	date,
    Agent_ID,
    FCR,
    category,
    case
		when FCR = 1 then 'Resuelta'
        else 'No Resuelta'
    end as Text_FCR
from llamadas_enero;