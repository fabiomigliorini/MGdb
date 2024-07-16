
update tblpessoa set creditobloqueado = true where codpessoa in (
	with uc as (
		select n.codpessoa, max(n.lancamento) as lancamento
		from tblnegocio n 
		where n.codnegociostatus = 2
		group by n.codpessoa 
	)
	select p.codpessoa--, p.fantasia, uc.lancamento
	from tblpessoa p 
	left join uc on (uc.codpessoa = p.codpessoa)
	where p.creditobloqueado = false
	and uc.lancamento <= now() - '1 year'::interval  
	order by p.codpessoa
)