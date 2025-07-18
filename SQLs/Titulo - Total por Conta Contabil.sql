with totais as (
	select 
		p.codpessoa,
		p.fantasia, 
		cc.contacontabil,
		sum(t.credito) as credito, 
		sum(case when (t.saldo < 0) then t.saldo else 0 end * -1) as pagar,
		sum(case when (t.saldo > 0) then t.saldo else 0 end) as adiantamento
	from tbltitulo t 
	inner join tblpessoa p on (p.codpessoa = t.codpessoa)
	inner join tblcontacontabil cc on (cc.codcontacontabil = t.codcontacontabil)
	where t.codcontacontabil in (:codcontacontabil) 
	and t.estornado is null
	--and t.emissao  <= '2025-12-31 23:59:59'
	--and t.criacao >= '2025-01-01 00:00:00'
	group by p.codpessoa, p.fantasia, cc.contacontabil 
) 
select 
	totais.contacontabil,
	totais.codpessoa,
	totais.fantasia,
	totais.credito, 
	totais.adiantamento,
	totais.credito + totais.adiantamento as total,
	totais.pagar
from totais	
order by totais.credito + totais.adiantamento desc
