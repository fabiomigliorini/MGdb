with ab as (
	select 
		t.codpessoa, 
		sum(t.saldo) as saldo, 
		min(vencimento) as vencimento 
	from tbltitulo t
	where t.saldo != 0
	group by t.codpessoa
)
select 
	p.codpessoa,
	p.fantasia,
	fp.formapagamento,
	ab.*
from tblformapagamento fp
inner join tblpessoa p on (p.codformapagamento = fp.codformapagamento)
inner join ab on (ab.codpessoa = p.codpessoa)
where fp.fechamento 
and ab.vencimento < (now() - '5 days'::interval)
order by vencimento desc, p.fantasia 