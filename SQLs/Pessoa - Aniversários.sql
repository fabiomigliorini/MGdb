
with aniversarios as (
	select 
		date_part('month', p.nascimento) as mes, 
		date_part('day', p.nascimento) as dia, 
		date_part('year', now()) - date_part('year', p.nascimento) as idade,
		'Idade' as tipo,
		p.pessoa, 
		p.codpessoa,
		p.nascimento as data
	from tblpessoa p
	where p.nascimento is not null
	and p.fisica 
	--and p.cliente -- filtro cliente
	--and p.fornecedor -- filtro fornecedor
	and p.codpessoa not in ( --filtro colaborador
		select c.codpessoa
	 	from tblcolaborador c
	 	where c.rescisao is null
	)
	union all --- daqui 
	select 
		date_part('month', c.contratacao) as mes, 
		date_part('day', c.contratacao) as dia, 
		date_part('year', now()) - date_part('year', c.contratacao) as idade,
		'Empresa' as tipo,
		p.pessoa,
		c.codpessoa, 
		c.contratacao as data
	from tblcolaborador c
	inner join tblpessoa p on (p.codpessoa = c.codpessoa)
	where c.rescisao is null
	and date_part('year', c.contratacao) < date_part('year', CURRENT_DATE) -- ate aqui somente se Todos ou Colaborador
)
select * 
from aniversarios 
order by mes, dia
