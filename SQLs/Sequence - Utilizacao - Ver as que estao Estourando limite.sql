-- Percentual de utilizacao
select 
	((s."last_value"::float * 100) / s.max_value::float)::float as utilizacao,
	s.sequencename, 
	s."last_value",
	s.max_value, 
	s.min_value
from pg_sequences s
order by 1 desc nulls last

-- Tabelas 
SELECT 
	table_name, 
	replace(table_name, 'tbl', 'cod') as pk, 
	table_name || replace(table_name, 'tbl', 'cod') || '_seq' as seq
FROM information_schema.tables 
WHERE table_schema='mgsis' AND table_type='BASE TABLE'
